# Skills

A curated set of Claude Code skills for building interfaces that feel right, packaged as a plugin I can install anywhere and keep current.

The skills themselves are Emil Kowalski's, from [emilkowalski/skills](https://github.com/emilkowalski/skills). They encode his rules for animation, motion review, and UI polish, and the credit for that material is his. What this fork adds is the packaging and the maintenance: a plugin manifest so the skills load in Claude Code, validation on every change, CI, and a repeatable way to pull in his updates without losing my own.

## Install

In Claude Code:

```
/plugin marketplace add abadyhbh-source/skills
/plugin install design-eng@abadyhbh-skills
```

Every skill then loads by name, for example `/animate` or `/review-animations`. Skills marked as invoke-only in their frontmatter never fire on their own, so a review does not start unless I ask for one.

To install the original set straight from Emil's repo instead:

```bash
npx skills@latest add emilkowalski/skills
```

## Why I keep this

Agents make small, confident mistakes in UI work. An `ease-in` on an enter animation. A solid border where a soft shadow belongs. A hand-rolled toast component when a good library exists. None of them is a bug, and together they are the difference between an interface that feels finished and one that feels generated.

These skills put the right defaults in front of the agent before it starts. I would rather correct taste once, in a skill, than in every review.

## Reference

Emil's skills, shipped unchanged under `skills/`:

- **[emil-design-eng](./skills/emil-design-eng/SKILL.md)** — The main skill: mostly animation, plus general design advice.
- **[animate](./skills/animate/SKILL.md)** — Builds an animation from scratch, choosing the curve, duration, and properties in the right order.
- **[animate-expo](./skills/animate-expo/SKILL.md)** — The same bar for React Native and Expo: gestures, sheets, haptics, screen transitions, and keeping motion off the JS thread.
- **[mobile-native](./skills/mobile-native/SKILL.md)** — Make a web app feel native on a phone: sticky hover states, tap highlights, the 100vh bug, inputs that zoom the page, safe areas.
- **[review-animations](./skills/review-animations/SKILL.md)** — Strict review of animation code against Emil's rules. Invoke-only.
- **[improve-animations](./skills/improve-animations/SKILL.md)** — Audit every animation in a codebase and produce prioritized, self-contained plans any agent can execute.
- **[find-animation-opportunities](./skills/find-animation-opportunities/SKILL.md)** — Search a UI for places that would genuinely benefit from motion, and say what not to animate.
- **[animation-vocabulary](./skills/animation-vocabulary/SKILL.md)** — Turn a vague description of an effect into its exact name so you can ask for it precisely.
- **[apple-design](./skills/apple-design/SKILL.md)** — Apple's principles for interface design and fluid motion, distilled from WWDC talks and translated for the web.
- **[write-swift](./skills/write-swift/SKILL.md)** — Modern Swift: value types, Swift 6 concurrency, generics, performance, and Swift Testing.
- **[pick-ui-library](./skills/pick-ui-library/SKILL.md)** — Pick a library from Emil's short list of ones he uses and trusts, instead of hand-rolling or installing an abandoned package. Invoke-only.
- **[prototype](./skills/prototype/SKILL.md)** — Build several different versions of a UI piece and flip through them with a switcher. Invoke-only.
- **[ask-sonner](./skills/ask-sonner/SKILL.md)** — Working with [Sonner](https://sonner.emilkowal.ski), Emil's toast library: setup, styling, recipes, and common fixes.

Also from upstream: [performance-cheatsheet.md](./performance-cheatsheet.md), a one-table list of animation performance problems and their fixes.

From other authors, vendored with their licenses:

- **[grill-me-codex](./skills/grill-me-codex/SKILL.md)**: Chase AI's two-act plan hardening from [chaseai-yt/claudex-loop](https://github.com/chaseai-yt/claudex-loop) (legacy version). First Claude grills me about a plan. Then OpenAI Codex reviews the plan read-only until it approves. Needs the `codex` CLI installed and logged in. Invoke-only.

## Maintaining the fork

Project skills under `.claude/skills/` load automatically when working in this repo:

- `/sync-upstream` fetches Emil's latest changes, merges them, validates, and reminds me to bump the version.
- `/add-skill` scaffolds a new skill that follows the conventions here.
- `/release` bumps both manifests, validates, and tags.

`./scripts/validate.sh` checks the manifests and every skill. CI runs it on every push and pull request.

## License

MIT. Copyright for the skill content belongs to Emil Kowalski; see [LICENSE](./LICENSE).
