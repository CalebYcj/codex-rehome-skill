$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$chinese = Get-Content -LiteralPath (Join-Path $repoRoot 'README.md') -Raw -Encoding UTF8
$english = Get-Content -LiteralPath (Join-Path $repoRoot 'README.en.md') -Raw -Encoding UTF8

foreach ($text in @($chinese, $english)) {
    if (-not $text.Contains('https://github.com/CalebYcj/codex-rehome')) {
        throw 'README must link to ReHome Desktop.'
    }
    if (-not $text.Contains('SKILL.md')) {
        throw 'README must link to the full Skill workflow.'
    }
}

if (-not $chinese.Contains('[English](README.en.md)')) { throw 'Chinese README language link is missing.' }
if ($english -notmatch '\[[^\]]+\]\(README\.md\)') { throw 'English README language link is missing.' }

Write-Output 'PASS skill bilingual README contract'
