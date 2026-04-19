#!/usr/bin/env bash
set -euo pipefail

PYTHON_BIN="${PYTHON:-python3}"

CURRENT_VER="$("$PYTHON_BIN" - <<'PY'
import importlib.metadata as m

try:
    print(m.version("causal-conv1d"))
except Exception:
    print("missing")
PY
)"

if "$PYTHON_BIN" -c "import causal_conv1d" >/dev/null 2>&1; then
  echo "  causal_conv1d: already installed (version=${CURRENT_VER})"
  exit 0
fi

echo "  causal_conv1d: missing -> installing causal-conv1d"
"$PYTHON_BIN" -m pip install causal-conv1d -q

"$PYTHON_BIN" -c "import causal_conv1d" >/dev/null 2>&1
INSTALLED_VER="$("$PYTHON_BIN" - <<'PY'
import importlib.metadata as m
print(m.version("causal-conv1d"))
PY
)"
echo "  causal_conv1d: installed (version=${INSTALLED_VER})"
