#!/bin/bash
# Install Claude Code skills and agents globally (~/.claude/) or into a project
# Usage:
#   ./install.sh              # Install globally to ~/.claude/
#   ./install.sh --project    # Install to current directory's .claude/
#   ./install.sh --project /path/to/project

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ "$1" = "--project" ]; then
  TARGET="${2:-.}"
  TARGET="$(cd "$TARGET" && pwd)"
  DEST="$TARGET/.claude"
else
  DEST="$HOME/.claude"
fi

echo "Installing Claude Code skills & agents into: $DEST/"

# Create directories
mkdir -p "$DEST/agents"
mkdir -p "$DEST/skills"

# Copy agents
echo "Copying agents..."
cp -r "$SCRIPT_DIR/agents/"*.md "$DEST/agents/"
AGENT_COUNT=$(ls "$SCRIPT_DIR/agents/"*.md 2>/dev/null | wc -l | tr -d ' ')
echo "  -> $AGENT_COUNT agents installed"

# Copy skills
echo "Copying skills..."
for skill_dir in "$SCRIPT_DIR/skills/"*/; do
  skill_name=$(basename "$skill_dir")
  mkdir -p "$DEST/skills/$skill_name"
  cp -r "$skill_dir"* "$DEST/skills/$skill_name/"
done
SKILL_COUNT=$(ls -d "$SCRIPT_DIR/skills/"*/ 2>/dev/null | wc -l | tr -d ' ')
echo "  -> $SKILL_COUNT skills installed"

echo ""
echo "Done! Installed $AGENT_COUNT agents and $SKILL_COUNT skills."
echo ""
echo "Available skills (trigger with /skill-name):"
for skill_dir in "$SCRIPT_DIR/skills/"*/; do
  echo "  /$(basename "$skill_dir")"
done
