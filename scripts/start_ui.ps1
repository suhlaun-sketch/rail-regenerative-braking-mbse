param([switch]$NoBrowser)
$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$backend = Join-Path $root 'ui/backend'
$frontend = Join-Path $root 'ui/frontend'
$python = Join-Path $backend '.venv/Scripts/python.exe'
if (-not (Test-Path -LiteralPath $python)) {
    if (Get-Command py -ErrorAction SilentlyContinue) { py -3.10 -m venv (Join-Path $backend '.venv') }
    else { python -m venv (Join-Path $backend '.venv') }
    if ($LASTEXITCODE -ne 0) { throw 'Python virtual environment creation failed' }
}
& $python -m pip install -r (Join-Path $backend 'requirements.txt')
if ($LASTEXITCODE -ne 0) { throw 'Backend dependency installation failed' }
Push-Location $frontend
try {
    npm ci
    if ($LASTEXITCODE -ne 0) { throw 'Frontend dependency installation failed' }
} finally { Pop-Location }
$logs = Join-Path $root 'ui/logs'
New-Item -ItemType Directory -Force -Path $logs | Out-Null
$be = Start-Process -FilePath $python -ArgumentList '-m','uvicorn','app.main:app','--host','127.0.0.1','--port','8000' -WorkingDirectory $backend -WindowStyle Hidden -RedirectStandardOutput (Join-Path $logs 'backend.stdout.log') -RedirectStandardError (Join-Path $logs 'backend.stderr.log') -PassThru
$fe = Start-Process -FilePath 'cmd.exe' -ArgumentList '/d','/s','/c','npm run dev -- --host 127.0.0.1 --port 5173' -WorkingDirectory $frontend -WindowStyle Hidden -RedirectStandardOutput (Join-Path $logs 'frontend.stdout.log') -RedirectStandardError (Join-Path $logs 'frontend.stderr.log') -PassThru
@{ backend_pid=$be.Id; frontend_pid=$fe.Id } | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $logs 'pids.json') -Encoding UTF8
foreach ($url in @('http://127.0.0.1:8000/api/health','http://127.0.0.1:5173')) {
    $ready = $false
    for ($i=0; $i -lt 90; $i++) {
        try { if ((Invoke-WebRequest -UseBasicParsing -Uri $url -TimeoutSec 2).StatusCode -eq 200) { $ready=$true; break } } catch {}
        Start-Sleep -Milliseconds 500
    }
    if (-not $ready) { throw "Service did not start: $url; inspect ui/logs" }
}
if (-not $NoBrowser) { Start-Process 'http://127.0.0.1:5173' }
Write-Output 'UI=http://127.0.0.1:5173 BACKEND=http://127.0.0.1:8000/api/health'
