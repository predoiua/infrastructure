
tree -L 2 # show 2 lvl only
tree 


uv tool install ruff
# Format code with ruff
uv run ruff format .

# Run linting with automated fixes
uv run ruff check --fix .