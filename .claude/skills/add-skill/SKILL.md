---
name: add-skill
description: Scaffold a new skill in this repository following its conventions, then validate it and wire it into the README and plugin. Use when asked to add, create, or scaffold a new skill here. For improving the writing or triggering of an existing skill, use skill-creator instead.
disable-model-invocation: true
argument-hint: <skill-name> <one-line purpose>
allowed-tools: Bash(./scripts/validate.sh) Bash(claude plugin validate *) Bash(ls *) Read Write Edit
---

# Add A Skill

Skills in this repo are opinionated and narrow: each does one thing and names its neighbours for everything else. Read two existing skills before writing a new one. `skills/animate/SKILL.md` shows a construction skill and `skills/review-animations/SKILL.md` shows a review skill.

## Steps

1. Pick a kebab-case name. The folder `skills/<name>/` and the frontmatter `name` must be identical.
2. Write `skills/<name>/SKILL.md` with this frontmatter:
   - `name`: the folder name.
   - `description`: what it does, then "Use when ..." with the phrases a user would type, then what it is not for and which sibling skill covers that. Under about 1024 characters. This line is the only thing Claude sees before deciding to load the skill.
   - `disable-model-invocation: true` if the skill should only run when someone types `/<name>` (reviews, pickers, prototyping, anything expensive or opinionated).
3. Body structure used across this repo: a one-paragraph statement of the one thing the skill does and what it does not do, an "Operating Posture" section, then the decision procedure, then rules or checklists. Long tables, recipes, and API references go in a sibling file (RECIPES.md, STANDARDS.md, API.md) that the skill tells the reader to open.
4. Add a line to the Reference list in README.md in the same format as its neighbours.
5. Run `./scripts/validate.sh`. Fix every error and warning.
6. Bump the minor version in `.claude-plugin/plugin.json` and the plugin entry in `.claude-plugin/marketplace.json`.

## Quality bar

- A skill that could be a paragraph in another skill should be that paragraph instead.
- Every rule states why, in one sentence, so an agent can apply it to a case the rule does not literally cover.
- No "Initial Response" boilerplate. The user asked for the skill; answer the question.
