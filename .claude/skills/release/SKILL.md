---
name: release
description: Cut a release of the design-eng plugin by bumping the version in both manifests, validating, committing, and tagging. Use when asked to release, publish, tag, or bump the plugin version.
disable-model-invocation: true
argument-hint: [major|minor|patch]
allowed-tools: Bash(./scripts/validate.sh) Bash(claude plugin tag *) Bash(git *) Read Edit
---

# Release The Plugin

Installed users only receive updates when `version` changes, so every change to `skills/` that users should get needs a release.

## Steps

1. Check the working tree is clean and on `main` or a branch about to merge to `main`. Run `git status` and `git log --oneline -5`.
2. Decide the bump from the diff since the last tag: `git describe --tags --abbrev=0` then `git diff --stat <tag> -- skills`. New skill: minor. Text or rule changes inside existing skills: patch. Removed skill or renamed skill: major.
3. Set the same version string in `.claude-plugin/plugin.json` (`version`) and in `.claude-plugin/marketplace.json` (the `design-eng` entry's `version`). They must match or `claude plugin tag` refuses.
4. Run `./scripts/validate.sh`.
5. Commit with the message `Release design-eng v<version>` and a body listing what changed for users.
6. Run `claude plugin tag .` to create the `design-eng--v<version>` tag, then push the branch and the tag.

## Do not

- Do not bump only one manifest.
- Do not tag an unvalidated tree.
- Do not include model names or session links in the release commit.
