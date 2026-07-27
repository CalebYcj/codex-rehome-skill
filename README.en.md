# Codex ReHome Skill

[中文](README.md) | [English](README.en.md) | [ReHome Desktop](https://github.com/CalebYcj/codex-rehome)

Codex ReHome Skill is the advanced, agent-operated edition of Codex ReHome. It helps an AI package, restore, inspect, and troubleshoot Codex Desktop projects, conversations, Skills, Plugins, and selected project files across macOS and Windows.

> Most users should start with [ReHome Desktop](https://github.com/CalebYcj/codex-rehome). It provides the same local migration workflow without asking an Agent to run repository scripts.

## When to use this Skill

- You want Codex or another capable Agent to automate migration, verification, or troubleshooting.
- You need a no-GUI, batch, or auditable script workflow.
- ReHome Desktop needs investigation of a package, restore report, or path mapping.
- You are preserving Codex before reinstalling an operating system.

## Quick start

Send this to Codex on the source computer:

```text
Use Codex ReHome Skill:
https://github.com/CalebYcj/codex-rehome-skill

I want to move Codex from this computer to another computer. Confirm the source and target operating systems, let me choose projects and conversations, then create a migration package. Exclude login data, cookies, .env files, private keys, .git, node_modules, and virtual environments by default.
```

Transfer the resulting private ZIP through a private channel. On the target computer, install and sign in to Codex once, fully quit Codex, then ask its Codex instance to restore and verify the package with this Skill.

## Supported scope

- Windows to Windows
- Windows to macOS
- macOS to Windows
- macOS to macOS
- Backup and restore around an OS reinstall on the same computer

The default is a merge-safe restore: target login, configuration, and installation identity are preserved while selected conversations, indexes, Skills, Plugins, generated images, and project files are restored. Reopen restored projects through Codex Desktop so they can reliably appear in the project sidebar.

## Limits and safety

This is not official cloud sync and it does not keep two computers continuously synchronized. After a cross-platform move, an old conversation can remain useful historical context while its original working-directory handle no longer works. Reopen the restored project and continue in a new task when needed.

Login tokens, cookies, `.env` files, private keys, `.git`, `node_modules`, virtual environments, running terminals, and unsaved work are excluded by default. Never upload a personal migration package to GitHub, a public post, or Red Skill.

## Documentation

- [Full Agent workflow](SKILL.md)
- [Migration directions](docs/migrate-codex-between-mac-and-windows.md)
- [Troubleshooting](docs/troubleshooting.md)
- [Validation status](docs/validation-status.md)
- [Red Skill](redskill/SKILL.md)

## Development and license

Scripts live in `scripts/`; verification lives in `tests/`. Licensed under [MIT](LICENSE).
