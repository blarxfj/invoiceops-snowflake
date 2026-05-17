# SQL Directory

All SQL files are **idempotent** — every statement uses `CREATE OR REPLACE` or
`CREATE … IF NOT EXISTS`. You can re-run any file from scratch without side effects.

## File numbering convention

Run directories in ascending numeric order. Within a directory, run files in
alphabetical order unless the file header says otherwise.

| Directory | Contents | Run order |
|---|---|---|
| `00_ddl/` | Database, schemas, warehouses, roles, stages, image repository, compute pool | First |
| `10_governance/` | Object tags, masking policies, row access policies | After `00_ddl/` |
| `20_pipeline/` | `AI_PARSE_DOCUMENT`, `AI_EXTRACT`, `AI_CLASSIFY`, `AI_FILTER`, `AI_AGG`, `AI_COMPLETE`, `AI_EMBED` pipeline views and procedures | After `10_governance/` |
| `30_streams_tasks/` | Streams on raw tables; chained Tasks for orchestration | After `20_pipeline/` |
| `40_eval/` | Eval harness queries, `AUDIT.EVAL_RUNS` writes, cost-routing comparison | After `30_streams_tasks/` |

## Idempotency rule

Every DDL statement must be safe to re-run. Use:

- `CREATE OR REPLACE TABLE …`
- `CREATE TABLE IF NOT EXISTS …`
- `CREATE OR REPLACE MASKING POLICY …`
- `CREATE OR REPLACE ROW ACCESS POLICY …`
- `CREATE OR REPLACE TASK …`
- etc.

Never use bare `CREATE` that would fail on re-run. Never use `DROP … CASCADE` in
pipeline files — put destructive teardown in a separate `teardown/` script that is
never run in CI.

## Linting

```bash
sqlfluff lint --dialect snowflake sql/
sqlfluff fix --dialect snowflake sql/   # auto-fix formatting
```

CI runs `sqlfluff lint` on every PR. Fix lint errors before opening a PR.
