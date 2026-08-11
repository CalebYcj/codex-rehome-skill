# Troubleshooting Codex Migration

This page lists common issues when migrating OpenAI Codex Desktop between Mac and Windows computers.

## Socket Or IPC File Copy Failure

Some live Codex or Git cache folders can contain socket or IPC files. The package scripts exclude `*.ipc`, `*.sock`, runtime folders, and process manager state by default.

Older Mac restore scripts could still fail while backing up an existing target `~/.codex` directory because `cp -a` cannot copy a Unix socket such as `~/.codex/ipc/ipc.sock`. The current restore script uses a filtered `rsync` backup that skips runtime sockets, browser login state, auth/config identity files, `.env` files, and private keys. If a restore stops during the backup step, update the restore script and rerun it after fully quitting Codex; the merge has not started yet at that point.

## `vendor_imports` Or Git Object Permission Denied

Some cached Git objects under runtime or vendor import folders may be unreadable. Standard mode excludes `vendor_imports`, `.git`, `node_modules`, `.venv`, `venv`, and `__pycache__`.

## Package Is Too Large

Codex session history can be large. If the package is too large, inspect:

- `~/.codex/sessions`
- generated images
- project `outputs` and `artifacts`
- selected project folders passed with `--project`

Avoid including `node_modules`, virtual environments, and Git object stores.

## Target Codex Requires Login Again

This is expected. Standard and full modes do not migrate browser login state, cookies, auth tokens, or private keys.

## Old Conversations Reference Source Computer Paths

Old threads may contain paths like `/Users/<name>/Documents/...` or `C:\Users\<name>\Documents\...`. On the target computer, restore or move the project folder, then reopen it from Codex. Avoid direct JSONL path rewrites unless you have a verified backup and a parser-safe migration tool.

## Chrome Plugin Or Native Host Is Disconnected

Codex Chrome integration may need target-side setup. Reinstall or repair the Chrome plugin from Codex on the target computer and confirm the Codex Chrome extension is installed and enabled in the same Chrome profile.
