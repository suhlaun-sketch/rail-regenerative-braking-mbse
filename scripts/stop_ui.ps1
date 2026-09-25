$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$pidFile = Join-Path $root 'ui/logs/pids.json'
if (-not (Test-Path -LiteralPath $pidFile)) { return }
$ids = Get-Content -LiteralPath $pidFile -Raw | ConvertFrom-Json
foreach ($id in @($ids.backend_pid, $ids.frontend_pid)) {
    if ($id) { Stop-Process -Id $id -ErrorAction SilentlyContinue }
}
Remove-Item -LiteralPath $pidFile -ErrorAction SilentlyContinue
