$ErrorActionPreference = 'Stop'
$uiRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$backend = Join-Path $uiRoot 'backend'
$frontend = Join-Path $uiRoot 'frontend'
$cache = Join-Path $uiRoot 'cache'
$logs = Join-Path $uiRoot 'logs'
New-Item -ItemType Directory -Force -Path $cache,$logs | Out-Null
$python = Join-Path $backend '.venv\Scripts\python.exe'
if (-not (Test-Path -LiteralPath $python)) { throw 'Backend virtual environment is missing.' }
$backendOut = Join-Path $logs 'backend.stdout.log'; $backendErr = Join-Path $logs 'backend.stderr.log'
$frontendOut = Join-Path $logs 'frontend.stdout.log'; $frontendErr = Join-Path $logs 'frontend.stderr.log'
$be = Start-Process -FilePath $python -ArgumentList '-m','uvicorn','app.main:app','--host','127.0.0.1','--port','8000' -WorkingDirectory $backend -WindowStyle Hidden -RedirectStandardOutput $backendOut -RedirectStandardError $backendErr -PassThru
$fe = Start-Process -FilePath 'cmd.exe' -ArgumentList '/d','/s','/c','npm run dev -- --host 127.0.0.1 --port 5173' -WorkingDirectory $frontend -WindowStyle Hidden -RedirectStandardOutput $frontendOut -RedirectStandardError $frontendErr -PassThru
@{backend_pid=$be.Id;frontend_pid=$fe.Id;started_at=(Get-Date).ToString('o')} | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $cache 'ui_processes.json') -Encoding UTF8
foreach($url in @('http://127.0.0.1:8000/api/health','http://127.0.0.1:5173')) {
    $ready=$false
    for($i=0;$i -lt 60;$i++){try{if((Invoke-WebRequest -UseBasicParsing -Uri $url -TimeoutSec 2).StatusCode -eq 200){$ready=$true;break}}catch{};Start-Sleep -Milliseconds 500}
    if(-not $ready){throw "UI service failed to start: $url"}
}
Start-Process 'http://127.0.0.1:5173'
Write-Output 'LOCAL_URL = http://127.0.0.1:5173'
