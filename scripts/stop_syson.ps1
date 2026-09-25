param([switch]$Test2026_9)
$ErrorActionPreference = 'Stop'
$dir = Join-Path $PSScriptRoot '../tools/syson-local'
$compose = if ($Test2026_9) { 'compose-test.yaml' } else { 'compose.yaml' }
Push-Location $dir
try { docker compose -f $compose down; if ($LASTEXITCODE -ne 0) { throw 'SysON Docker stop failed' } }
finally { Pop-Location }
