.PHONY: setup lint test build push deploy \
        logs-backend logs-frontend logs-router clean

# ── Setup ──────────────────────────────────────────────────────────────────────
setup:
	pip install -r backend/requirements-dev.txt
	pip install -r synthetic/requirements.txt
	npm --prefix frontend ci
	pre-commit install
	@echo "Setup complete. Copy .env.example to .env and fill in your values."

# ── Lint ───────────────────────────────────────────────────────────────────────
lint:
	ruff check backend/ synthetic/
	ruff format --check backend/ synthetic/
	npm --prefix frontend run lint
	sqlfluff lint --dialect snowflake sql/
	pre-commit run --all-files yamllint

# ── Test ───────────────────────────────────────────────────────────────────────
test:
	pytest tests/backend -x -q
	npm --prefix frontend test -- --run

# ── Build ──────────────────────────────────────────────────────────────────────
build:
	docker build --platform=linux/amd64 -t invoiceops-frontend:latest ./frontend
	docker build --platform=linux/amd64 -t invoiceops-backend:latest ./backend
	docker build --platform=linux/amd64 -t invoiceops-router:latest ./router

# ── Push ───────────────────────────────────────────────────────────────────────
push:
	@echo "not implemented yet — see project-pack.md Part 5"
	@echo "Run: bash scripts/build_push.sh"

# ── Deploy ─────────────────────────────────────────────────────────────────────
deploy:
	@echo "not implemented yet — see project-pack.md Part 5"
	@echo "Run: bash scripts/deploy.sh"

# ── Logs ───────────────────────────────────────────────────────────────────────
logs-backend:
	bash scripts/logs.sh backend

logs-frontend:
	bash scripts/logs.sh frontend

logs-router:
	bash scripts/logs.sh router

# ── Clean ──────────────────────────────────────────────────────────────────────
clean:
	docker rmi -f invoiceops-frontend:latest invoiceops-backend:latest invoiceops-router:latest 2>/dev/null || true
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name .pytest_cache -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name .ruff_cache -exec rm -rf {} + 2>/dev/null || true
	rm -rf frontend/dist frontend/node_modules/.vite 2>/dev/null || true
	@echo "Clean complete."
