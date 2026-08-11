#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RESTORE_SCRIPT="$REPO_ROOT/scripts/restore_codex_to_mac.sh"
TMP="$(mktemp -d /tmp/codex-restore-socket-test.XXXXXX)"
SOCKET_PID=""

cleanup() {
  if [[ -n "$SOCKET_PID" ]]; then
    kill "$SOCKET_PID" 2>/dev/null || true
    wait "$SOCKET_PID" 2>/dev/null || true
  fi
  rm -rf "$TMP"
}
trap cleanup EXIT

assert_exists() {
  if [[ ! -e "$1" ]]; then
    echo "expected path to exist: $1" >&2
    exit 1
  fi
}

assert_not_exists() {
  if [[ -e "$1" ]]; then
    echo "expected path to be excluded: $1" >&2
    exit 1
  fi
}

NC_BIN="$(command -v nc || true)"
if [[ -z "$NC_BIN" ]]; then
  echo "nc is required for this test" >&2
  exit 1
fi

PACKAGE_DIR="$TMP/package"
HOME_DIR="$TMP/home"
TARGET_CODEX_HOME="$HOME_DIR/.codex"
mkdir -p "$PACKAGE_DIR/home/.codex/sessions" "$TARGET_CODEX_HOME/ipc"
cp "$RESTORE_SCRIPT" "$PACKAGE_DIR/Restore-Codex-To-Mac.sh"

cat > "$PACKAGE_DIR/home/.codex/sessions/source-session.jsonl" <<'EOF'
{"type":"session_meta","payload":{"id":"source-session","thread_name":"Source session"}}
EOF
cat > "$TARGET_CODEX_HOME/keep.txt" <<'EOF'
keep this backup file
EOF
cat > "$TARGET_CODEX_HOME/auth.json" <<'EOF'
target auth must not be copied
EOF
cat > "$TARGET_CODEX_HOME/config.toml" <<'EOF'
target config must not be copied
EOF
cat > "$TARGET_CODEX_HOME/.env" <<'EOF'
TARGET_SECRET=must-not-be-copied
EOF
cat > "$TARGET_CODEX_HOME/id_ed25519" <<'EOF'
target private key must not be copied
EOF

"$NC_BIN" -lU "$TARGET_CODEX_HOME/ipc/ipc.sock" >/dev/null 2>&1 &
SOCKET_PID=$!

for _ in 1 2 3 4 5 6 7 8 9 10; do
  [[ -S "$TARGET_CODEX_HOME/ipc/ipc.sock" ]] && break
  sleep 0.1
done
if [[ ! -S "$TARGET_CODEX_HOME/ipc/ipc.sock" ]]; then
  echo "test socket was not created" >&2
  exit 1
fi

HOME="$HOME_DIR" \
USER="codex-restore-test" \
CODEX_REHOME_SKIP_APP_REGISTRATION=1 \
bash "$PACKAGE_DIR/Restore-Codex-To-Mac.sh"

BACKUP_DIR="$(find "$HOME_DIR" -maxdepth 1 -type d -name '.codex.backup-*' -print -quit)"
if [[ -z "$BACKUP_DIR" ]]; then
  echo "restore did not create a target backup" >&2
  exit 1
fi

assert_exists "$BACKUP_DIR/keep.txt"
assert_not_exists "$BACKUP_DIR/ipc/ipc.sock"
assert_not_exists "$BACKUP_DIR/auth.json"
assert_not_exists "$BACKUP_DIR/config.toml"
assert_not_exists "$BACKUP_DIR/.env"
assert_not_exists "$BACKUP_DIR/id_ed25519"
assert_exists "$TARGET_CODEX_HOME/auth.json"
assert_exists "$TARGET_CODEX_HOME/config.toml"
assert_exists "$TARGET_CODEX_HOME/sessions/source-session.jsonl"

echo "mac_restore_socket_backup_test passed"
