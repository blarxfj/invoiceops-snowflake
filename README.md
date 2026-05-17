# InvoiceOps

![Status: Scaffolding](https://img.shields.io/badge/status-scaffolding-yellow)

A SQL-native multimodal invoice processing platform on Snowflake. The AI pipeline uses
`AI_PARSE_DOCUMENT`, `AI_EXTRACT`, `AI_CLASSIFY`, `AI_FILTER`, `AI_AGG`, `AI_COMPLETE`,
and `AI_EMBED`, orchestrated via Streams and Tasks. The reviewer UI is a React + Flask +
NGINX three-service stack deployed on Snowpark Container Services inside the Snowflake
governance boundary — no external app hosting, no external auth layer, no data egress.

Full architecture, design decisions, and week-by-week build plan: [`docs/project-pack.md`](docs/project-pack.md).

---

## Getting Started

> This section will be fleshed out once the day-2 de-risking stack is proved.
> See `docs/project-pack.md` Part 9 for the de-risking checklist.

### Prerequisites

- Docker with BuildKit (`docker buildx` available)
- `pre-commit` (`pip install pre-commit` or `brew install pre-commit`)
- Node 20+ and npm
- Python 3.11+
- Snowflake account with `AI_*` functions available in your region

### Quick setup

```bash
cp .env.example .env         # fill in your Snowflake account details
make setup                   # install Python deps, Node deps, and pre-commit hooks
make lint                    # verify linters pass
make test                    # run smoke tests
make build                   # build all three placeholder Docker images
docker compose up            # bring up the three services locally
```
