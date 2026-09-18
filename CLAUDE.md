# Skills repository

A collection of Claude Code skills for design engineering: animation, motion review, Apple-style interaction design, UI library choices, prototyping, Sonner, and modern Swift. This repo is a fork of emilkowalski/skills. It ships as one Claude Code plugin (`design-eng`) from the marketplace defined in `.claude-plugin/marketplace.json`.

## Layout

- `skills/<name>/SKILL.md` is the entry point for each skill. Extra reference files (RECIPES.md, STANDARDS.md, API.md, and so on) sit next to it and are read on demand by the skill.
- `.claude-plugin/plugin.json` is the plugin manifest. `skills` points at `./skills`.
- `.claude-plugin/marketplace.json` lists the plugin so users can run `/plugin marketplace add abadyhbh-source/skills`.
- `.claude/settings.json` holds project permissions and a PostToolUse hook that re-validates after any edit to a SKILL.md or manifest.
- `scripts/validate.sh` is the single validation entry point. CI runs it on every push and pull request.

## Working on a skill

1. The folder name and the frontmatter `name` must match. That is what `/<name>` resolves to and what the README links to.
2. `description` is the only text Claude sees before deciding to load a skill. Lead with what the skill does, then a "Use when ..." clause with the phrases a user would actually type, then what it is not for. Keep it under about 1024 characters.
3. Skills that should never fire on their own (reviews, library picks, prototyping) set `disable-model-invocation: true`. Do not remove that flag from an existing skill without a reason.
4. Each skill does one thing and names its neighbours for everything else. When adding a skill, add the cross-references in both directions and add a line to the README reference list.
5. Keep SKILL.md focused on decisions and rules. Long tables, prop lists, and recipes go in a sibling file that the skill tells the reader to open.

## Validating

Run this before committing. It validates both manifests and every skill, and checks that folder names match frontmatter names.

```bash
./scripts/validate.sh
```

`claude plugin validate` only inspects SKILL.md files when pointed at a directory that contains a `skills/` folder and no manifest of its own, and it does not follow symlinks. The script stages a copy of `skills/` in a temp directory for that reason. Pointing the validator straight at `skills/` or at a single skill folder passes silently without checking anything.

## Releasing a change

Bump `version` in both `.claude-plugin/plugin.json` and the plugin entry in `.claude-plugin/marketplace.json`. Users who installed the plugin only receive updates when the version changes. `claude plugin tag` checks that the two agree and creates the release tag.

## Keeping up with upstream

This fork has no `upstream` remote configured. To pull Emil Kowalski's new skills:

```bash
git remote add upstream https://github.com/emilkowalski/skills
git fetch upstream
git merge upstream/main
```

Then run `./scripts/validate.sh` and bump the version.
