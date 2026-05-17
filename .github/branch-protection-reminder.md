# Branch Protection Reminder

Enable the following settings on `main` in GitHub → Settings → Branches → Add rule.

## Required settings

- **Branch name pattern:** `main`
- **Require a pull request before merging:** enabled
  - Require approvals: 1 (adjust to team size)
  - Dismiss stale pull request approvals when new commits are pushed: enabled
- **Require status checks to pass before merging:** enabled
  - Require branches to be up to date before merging: enabled
  - Required status checks (from CI workflow):
    - `Lint`
    - `Backend tests`
    - `Frontend tests`
    - `Build Docker images`
    - `SQL syntax check`
- **Require conversation resolution before merging:** enabled
- **Do not allow bypassing the above settings:** enabled (even for admins)
- **Allow force pushes:** disabled
- **Allow deletions:** disabled

## Why these settings

- All five CI jobs must pass so a green PR means the images build and tests pass.
- "Up to date before merging" prevents stale branches from slipping in regressions.
- No force pushes to `main` protects the release tag history (`v0.1.0`, etc.).

## Squash-merge policy

Set the default merge strategy to **Squash and merge** so each feature branch
collapses to one atomic commit on `main`, and the `main` history stays clean.
