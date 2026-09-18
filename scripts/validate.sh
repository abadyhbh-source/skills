#!/usr/bin/env bash
# Validate the plugin manifest, the marketplace manifest, and every skill.
# Run before committing. CI runs the same script.
#
# Note on the third step: `claude plugin validate` only inspects SKILL.md files
# when pointed at a directory that contains a `skills/` folder and has no
# manifest of its own, and it does not follow symlinks. So the skills are
# copied into a temp directory and validated there.
set -euo pipefail
cd "$(dirname "$0")/.."

claude plugin validate .claude-plugin/plugin.json --strict
claude plugin validate .claude-plugin/marketplace.json --strict

stage=$(mktemp -d)
trap 'rm -rf "$stage"' EXIT
cp -R skills "$stage/skills"
claude plugin validate "$stage" --strict

# Project-local maintenance skills under .claude/skills/ (not shipped in the plugin).
claude plugin validate .claude --strict

# Checks the CLI does not do: folder name must match the frontmatter name,
# so that /<name> and the README agree with what actually loads.
status=0
for dir in skills/*/; do
  skill="${dir%/}"
  file="$skill/SKILL.md"
  if [ ! -f "$file" ]; then echo "MISSING: $file"; status=1; continue; fi
  fm_name=$(sed -n 's/^name:[[:space:]]*//p' "$file" | head -1)
  if [ "$fm_name" != "$(basename "$skill")" ]; then
    echo "NAME MISMATCH: $file declares '$fm_name' but folder is '$(basename "$skill")'"; status=1
  fi
done
[ "$status" -eq 0 ] && echo "√ Folder/name check passed"
exit $status
