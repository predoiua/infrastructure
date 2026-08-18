import * as fs from 'node:fs';
import * as path from 'node:path';
import type { ExtensionAPI, MessageEndEvent } from '@earendil-works/pi-coding-agent';

/**
 * MD Log Extension for Pi Agent
 * Logs finalized assistant responses, Mermaid graphs, and embeds generated SVG files
 * into an Obsidian/Markdown note.
 *
 * Uses the real pi events:
 *   - `message_end`  -> finalized assistant message content (text + mermaid fences)
 *   - `tool_result`  -> SVG file paths returned by SVG-producing tools
 *
 * The `visual-agent` is a sub-agent, so its SVG output arrives in assistant
 * messages; those file paths are detected and embedded as Obsidian `![[...]]` tags.
 */

/** Find `.svg` file references inside a text string. */
const SVG_REF_RE = /[\w/\-]+\.svg\b/gi;

/** Extract plain text from message content (string or content-block array). */
function extractText(content: unknown): string {
  if (typeof content === 'string') return content;
  if (!Array.isArray(content)) return '';
  return content
    .map((block) => {
      if (typeof block === 'string') return block;
      if (block && typeof block === 'object') {
        const b = block as { type?: string; text?: unknown };
        if (b.type === 'text' && typeof b.text === 'string') return b.text;
      }
      return '';
    })
    .join('');
}

/** Resolve a possibly-relative svg path against cwd and append an Obsidian embed tag. */
function embedSvg(logPath: string, rawPath: string) {
  const abs = path.resolve(process.cwd(), rawPath.trim());
  if (!fs.existsSync(abs)) return;
  const rel = path.relative(process.cwd(), abs).replace(/\\/g, '/');
  fs.appendFileSync(logPath, `\n![[${rel}]]\n`);
}

/** Scan text for `.svg` references and embed any that exist on disk. */
function embedSvgRefs(logPath: string, text: string) {
  const matches = text.match(SVG_REF_RE) ?? [];
  for (const m of matches) embedSvg(logPath, m);
}

export default function mdLogExtension(pi: ExtensionAPI) {
  const targetFile = process.env.MD_LOG_FILE || 'learning_notes.md';
  const logPath = path.resolve(process.cwd(), targetFile);

  // Initialize the Markdown file header if it doesn't exist
  if (!fs.existsSync(logPath)) {
    fs.writeFileSync(
      logPath,
      `# Learning Session Notes\n*Session started: ${new Date().toISOString()}*\n\n---\n\n`
    );
  }

  // Log finalized assistant responses (text + Mermaid graphs), embedding any SVGs referenced.
  pi.on('message_end', (event: MessageEndEvent) => {
    if (event.message.role !== 'assistant') return;
    const text = extractText(event.message.content).trim();
    if (!text) return;

    fs.appendFileSync(logPath, `\n\n---\n\n${text}\n`);
    embedSvgRefs(logPath, text);
  });

  // Embed SVG files returned directly by SVG-producing tools.
  pi.on('tool_result', (event) => {
    const text = extractText(event.content).trim();
    if (!text) return;
    embedSvgRefs(logPath, text);
  });
}
