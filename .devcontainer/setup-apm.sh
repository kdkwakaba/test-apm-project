#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

cd "${REPO_ROOT}"

if ! command -v apm >/dev/null 2>&1; then
  echo "[devcontainer] Installing APM CLI..."
  curl -fsSL https://aka.ms/apm-unix | sh
fi

APM_BIN="$(command -v apm || true)"
if [ -z "${APM_BIN}" ] && [ -x "${HOME}/.local/bin/apm" ]; then
  APM_BIN="${HOME}/.local/bin/apm"
fi

if [ -z "${APM_BIN}" ]; then
  echo "[devcontainer] APM CLI was not found after installation." >&2
  exit 1
fi

echo "[devcontainer] Installing project dependencies from apm.yml..."
"${APM_BIN}" install