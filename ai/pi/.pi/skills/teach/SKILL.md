---
name: teach
description: Structured 4-phase pedagogical framework to teach complex technical concepts using adaptive quizzes, dependency DAGs, step-by-step reasoning, and SVG-first visual sub-agents.
---

# Teach Skill Framework

When the user asks to learn or understand a complex topic using `teach <topic>`:

## SVG-First Principle
Visualize everything. Prefer the `visual-agent` (which produces standalone SVG diagrams) over ASCII art, markdown text diagrams, or bare prose for anything spatial, structural, or relational. Mermaid is acceptable only for the dependency DAG in Phase 2. Every SVG produced is saved to `assets/` and referenced by its file path so the md_log extension auto-embeds it into `learning_notes.md`.

## Phase 1: Probe (Adaptive Diagnostic)
1. Do not start explaining immediately.
2. Ask 3–5 graded multiple-choice questions testing foundational prerequisites related to the requested topic.
3. Use binary search style probing: adjust question difficulty based on answers to map the exact boundary of the user's current understanding.

## Phase 2: Plan (Dependency Graph)
1. Synthesize user answers into a conceptual dependency map.
2. Generate a Mermaid DAG diagram displaying the full learning arc from current knowledge to the goal topic.
3. Spawn fact-checking/research sub-agents to verify underlying facts and math formulas before presenting the plan.

## Phase 3: Incremental Teach (One Step at a Time)
1. Walk down the dependency tree **one reasoning step at a time**.
2. Never rush ahead or dump multiple topics in one turn.
3. Invoke the `visual-agent` for **every** step where a diagram helps: geometry, spatial vectors, graph flows, flowcharts, timelines, architecture, data structures, state machines, circuit/network layouts. Treat it as mandatory, not optional. Ask it to return the SVG file path (e.g. `assets/diagram_N.svg`).
4. Present equations cleanly formatted in LaTeX.

## Phase 4: Feedback Loop
1. End each step with a quick diagnostic question to verify comprehension.
2. Update understanding state based on response before proceeding to the next node in the DAG.
