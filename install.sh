#!/bin/bash
# Install Claude Code agent team harnesses globally (~/.claude/) or into a project
# Usage:
#   ./install.sh                              # Install ALL harnesses globally
#   ./install.sh thesis-advisor meal-planner   # Install specific harnesses globally
#   ./install.sh --project [path]              # Install ALL harnesses into a project
#   ./install.sh --project [path] thesis-advisor  # Install specific harnesses into a project
#   ./install.sh --list                        # List available harnesses

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
HARNESS_DIR="$SCRIPT_DIR/harnesses"

# Parse arguments
PROJECT_MODE=false
LIST_MODE=false
TARGET=""
HARNESSES=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project)
      PROJECT_MODE=true
      if [[ -n "$2" && "$2" != --* ]]; then
        TARGET="$(cd "$2" && pwd)"
        shift
      else
        TARGET="$(pwd)"
      fi
      shift
      ;;
    --list)
      LIST_MODE=true
      shift
      ;;
    *)
      HARNESSES+=("$1")
      shift
      ;;
  esac
done

# --list mode
if $LIST_MODE; then
  echo "Available harnesses:"
  for dir in "$HARNESS_DIR"/*/; do
    name=$(basename "$dir")
    agents=$(ls "$dir/agents/"*.md 2>/dev/null | wc -l | tr -d ' ')
    skills=$(ls -d "$dir/skills/"*/ 2>/dev/null | wc -l | tr -d ' ')
    echo "  $name ($agents agents, $skills skills)"
  done
  exit 0
fi

# Determine destination
if $PROJECT_MODE; then
  DEST="$TARGET/.claude"
else
  DEST="$HOME/.claude"
fi

# If no harnesses specified, install all
if [ ${#HARNESSES[@]} -eq 0 ]; then
  for dir in "$HARNESS_DIR"/*/; do
    HARNESSES+=("$(basename "$dir")")
  done
fi

echo "Installing harnesses into: $DEST/"
mkdir -p "$DEST/agents" "$DEST/skills"

TOTAL_AGENTS=0
TOTAL_SKILLS=0

for harness in "${HARNESSES[@]}"; do
  harness_path="$HARNESS_DIR/$harness"
  if [ ! -d "$harness_path" ]; then
    echo "WARNING: Harness '$harness' not found, skipping."
    continue
  fi

  echo ""
  echo "[$harness]"

  # Copy agents
  if [ -d "$harness_path/agents" ]; then
    cp "$harness_path/agents/"*.md "$DEST/agents/" 2>/dev/null || true
    count=$(ls "$harness_path/agents/"*.md 2>/dev/null | wc -l | tr -d ' ')
    TOTAL_AGENTS=$((TOTAL_AGENTS + count))
    echo "  agents: $count"
  fi

  # Copy skills
  if [ -d "$harness_path/skills" ]; then
    for skill_dir in "$harness_path/skills/"*/; do
      skill_name=$(basename "$skill_dir")
      mkdir -p "$DEST/skills/$skill_name"
      cp -r "$skill_dir"* "$DEST/skills/$skill_name/"
    done
    count=$(ls -d "$harness_path/skills/"*/ 2>/dev/null | wc -l | tr -d ' ')
    TOTAL_SKILLS=$((TOTAL_SKILLS + count))
    echo "  skills: $count"
  fi
done

echo ""
echo "Done! Installed $TOTAL_AGENTS agents and $TOTAL_SKILLS skills from ${#HARNESSES[@]} harness(es) into $DEST/"
