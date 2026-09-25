param([switch]$Test2026_9)
$ErrorActionPreference = 'Stop'
$dir = Join-Path $PSScriptRoot '../tools/syson-local'
if (-not (Test-Path -LiteralPath (Join-Path $dir '.env'))) {
    throw 'Copy tools/syson-local/.env.example to .env and set a local DB password first.'
}
$compose = if ($Test2026_9) { 'compose-test.yaml' } else { 'compose.yaml' }
Push-Location $dir
try {
    docker compose -f $compose up -d
    if ($LASTEXITCODE -ne 0) { throw 'SysON Docker start failed' }
} finally { Pop-Location }
Write-Output $(if ($Test2026_9) { 'SysON test: http://127.0.0.1:8090' } else { 'SysON formal version: http://127.0.0.1:8080' })
