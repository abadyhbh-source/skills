#!/usr/bin/env bash
# Pull Emil Kowalski's latest skills into this fork.
# Adds the upstream remote if it is missing, fetches, and reports what is new.
# Pass --merge to also merge upstream/main into the current branch.
set -euo pipefail
cd "$(dirname "$0")/.."

UPSTREAM_URL="https://github.com/emilkowalski/skills"

if ! git remote get-url upstream >/dev/null 2>&1; then
  git remote add upstream "$UPSTREAM_URL"
  echo "added remote: upstream -> $UPSTREAM_URL"
fi

git fetch upstream main

behind=$(git rev-list --count HEAD..upstream/main)
if [ "$behind" -eq 0 ]; then
  echo "up to date with upstream/main"
  exit 0
fi

echo "$behind upstream commit(s) not in $(git branch --show-current):"
git log --oneline HEAD..upstream/main
echo
echo "files that would change:"
git diff --stat HEAD upstream/main | tail -n 25

if [ "${1:-}" = "--merge" ]; then
  git merge --no-edit upstream/main
  # Upstream ships an empty .pl file by accident; keep it out of this fork.
  if [ -f .pl ] && [ ! -s .pl ]; then git rm -q .pl; echo "dropped empty .pl"; fi
  ./scripts/validate.sh
  echo
  echo "merged. Now bump version in .claude-plugin/plugin.json and marketplace.json if skills changed."
else
  echo
  echo "run ./scripts/sync-upstream.sh --merge to merge"
fi
