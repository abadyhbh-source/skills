---
name: sync-upstream
description: Pull Emil Kowalski's latest skills from emilkowalski/skills into this fork, merge them, drop upstream junk, validate, and bump the plugin version. Use when asked to sync, update, or catch up with upstream, or when a new skill has appeared in the original repo.
disable-model-invocation: true
allowed-tools: Bash(./scripts/sync-upstream.sh *) Bash(./scripts/validate.sh) Bash(git *) Read Edit
---

# Sync With Upstream

This fork tracks https://github.com/emilkowalski/skills. Upstream owns `skills/`; this fork owns everything else (manifests, `.claude/`, `scripts/`, CI, README).

## Steps

1. Run `./scripts/sync-upstream.sh`. It adds the `upstream` remote if missing, fetches, and lists what is new. Stop here if it says up to date.
2. Read the listed diff. Upstream sometimes adds files by accident (an empty `.pl` once). Note anything that is not a skill, a README line, or a reference file.
3. Run `./scripts/sync-upstream.sh --merge`. It merges, removes an empty `.pl` if present, and runs validation.
4. If the merge conflicts, it is almost always README.md. Keep this fork's intro and Install section, and take upstream's changes to the Reference list. The conflict in `skills/` should be resolved in upstream's favour unless this fork deliberately changed that skill.
5. If a skill was added or removed, update the Reference list in README.md so it matches `ls skills`. Adjust the wording so it reads in this fork's voice: Emil's skills are described as his, not as "mine".
6. Bump `version` in both `.claude-plugin/plugin.json` and the plugin entry in `.claude-plugin/marketplace.json`. New skill: minor bump. Changed skill text only: patch bump. Users only receive the update when the version changes.
7. Run `./scripts/validate.sh` and commit with a message that lists the upstream commits merged.

## Do not

- Do not rebase or rewrite history. Merge commits keep the upstream relationship readable.
- Do not edit the skills under `skills/` during a sync. Fork-specific changes to a skill are a separate commit so they survive the next merge cleanly.
