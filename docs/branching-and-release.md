# Branching and Release Strategy

## Branch rules

- **`main` is always deployable.** Protected. No direct commits. Everything merges via PR.
- Feature branches use the prefix that matches the change type:

| Prefix | Use for |
|---|---|
| `feat/<slug>` | new functionality |
| `fix/<slug>` | bug fixes |
| `chore/<slug>` | tooling, deps, scaffolding |
| `docs/<slug>` | documentation only |
| `ci/<slug>` | CI/CD pipeline changes |
| `refactor/<slug>` | code restructuring with no behavior change |
| `test/<slug>` | tests only |
| `hotfix/<slug>` | urgent production fix (see below) |

- One PR per logical change. If a task touches three subsystems, split it.
- **Squash-merge** into `main`. Every feature branch collapses to one atomic commit on `main`.

## Commit message convention

Format: `<type>(<scope>): <imperative subject>`

Types: `feat`, `fix`, `chore`, `docs`, `ci`, `refactor`, `test`, `build`, `perf`

Rules:
- Imperative mood: "add IBAN masking policy", not "added IBAN masking policy"
- Subject under 72 characters
- Body explains *why*, not *what* (the diff shows the what)
- Reference the project-pack section when relevant: `feat(governance): add IBAN masking policy (project-pack §4)`
- One concern per commit. If you find yourself writing "and" in the subject, split the commit.

## Release tags

| Tag | Milestone | Criteria |
|---|---|---|
| `v0.1.0` | End of week 1 | Container stack deployed; SQL pipeline processing invoices end-to-end |
| `v0.2.0` | End of week 2 | React UI working against real backend; role-switching demo functional |
| `v1.0.0` | End of week 3 | Shipped: eval harness complete, README polished, Loom recorded |

Tag from `main` after the squash-merge that represents the milestone:

```bash
git tag -a v0.1.0 -m "Week 1: container infra proved, SQL pipeline end-to-end"
git push origin v0.1.0
```

## Hotfix workflow

For urgent production fixes after a release tag:

```bash
git checkout -b hotfix/<short-description> v0.1.0
# make the fix
git commit -m "fix: <what and why>"
# open a PR targeting main
```

After the PR merges to `main`, tag the new release if warranted.

## Pre-commit and CI gates

Every commit on any branch runs the pre-commit hooks (fast smoke tests + linters).
Every PR must pass all five CI jobs before merge:

1. `Lint` — ruff, eslint, prettier, yamllint, sqlfluff, hadolint
2. `Backend tests` — pytest with coverage
3. `Frontend tests` — vitest with coverage
4. `Build Docker images` — all three images with `--platform=linux/amd64`
5. `SQL syntax check` — sqlfluff lint on `sql/`

Never bypass pre-commit with `--no-verify`. If a hook fails, fix the underlying issue.
