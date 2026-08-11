# Codex ReHome Skill

[中文](README.md) | [English](README.en.md) | [ReHome Desktop](https://github.com/CalebYcj/codex-rehome)

Codex ReHome Skill 是 Codex ReHome 的高级 Agent 版本。它帮助 AI 在 Mac 和 Windows 之间打包、恢复、检查 Codex Desktop 的项目、对话、Skills、Plugins 和已选择的项目文件。

> 普通用户请优先使用 [ReHome Desktop](https://github.com/CalebYcj/codex-rehome)。不需要把仓库交给 Agent，也不需要手动运行脚本。

## 什么时候用这个 Skill

- 你想让 Codex/Agent 自动完成迁移、检查或故障排查。
- 你处于无界面环境，或需要批量、可审计的脚本流程。
- ReHome Desktop 提示异常，需要查看迁移包、恢复报告或路径映射。
- 你需要在重装系统前把备份放到非系统盘或移动硬盘。

## 最快开始

把下面这段话发给原电脑上的 Codex：

```text
请使用 Codex ReHome Skill：
https://github.com/CalebYcj/codex-rehome-skill

我要把这台电脑上的 Codex 搬到另一台电脑。请确认源系统和目标系统，让我选择项目和对话，生成迁移包；默认排除登录信息、Cookies、.env、私钥、.git、node_modules 和虚拟环境。
```

把生成的私有 ZIP 通过网盘、局域网、移动硬盘或私人聊天工具传到新电脑。新电脑先安装并登录一次 Codex，然后完全退出 Codex，再让新电脑上的 Codex 读取迁移包并按本 Skill 恢复与验证。

## 支持范围

- Windows → Windows
- Windows → macOS
- macOS → Windows
- macOS → macOS
- 同一台电脑重装系统前后的备份与恢复

默认恢复是合并恢复：保留目标电脑的登录、配置和安装身份；对话、索引、Skills、Plugins、生成图片与选择的项目文件会按规则恢复。恢复项目后仍需通过 Codex Desktop 官方入口重新打开项目，才能让左侧项目栏可靠显示。

## 限制与安全

这不是官方云同步，也不会自动让两台电脑每天保持一致。跨系统后旧对话可以保留为历史上下文，但原任务绑定的工作目录可能不能继续直接使用；稳妥做法是重新打开恢复后的项目，再开一个新任务继续。

Windows 恢复只改写 `cwd`、项目路径和 rollout 等结构字段，不会替换历史提问、标题或普通正文里的旧路径文字。恢复后请启动一次 Codex，再完全退出并重新运行验证脚本，确认旧进程没有把结构路径写回。

登录令牌、Cookies、`.env`、私钥、`.git`、`node_modules`、虚拟环境、正在运行的终端和未保存内容默认不会迁移。不要把个人迁移包上传到 GitHub、公开帖子或 Red Skill。

## 内容说明

- [完整 Agent 流程](SKILL.md)
- [迁移方向说明](docs/migrate-codex-between-mac-and-windows.md)
- [故障排查](docs/troubleshooting.md)
- [真实验收状态](docs/validation-status.md)
- [Red Skill](redskill/SKILL.md)

## 开发与许可

脚本位于 `scripts/`，验证用例位于 `tests/`。本仓库采用 [MIT License](LICENSE)。
