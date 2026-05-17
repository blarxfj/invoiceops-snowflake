#!/usr/bin/env bash
# Tail service logs from SPCS via SYSTEM$GET_SERVICE_LOGS.
# Usage: bash scripts/logs.sh [backend|frontend|router]
# Not implemented yet — see docs/project-pack.md Part 14.
set -euo pipefail

SERVICE="${1:-backend}"
echo "not implemented yet — see project-pack.md Part 14"
echo "Manual equivalent:"
echo "  CALL SYSTEM\$GET_SERVICE_LOGS('INVOICE_OPS.APP.INVOICE_OPS_${SERVICE^^}', 0, '${SERVICE}', 1000);"
exit 1
