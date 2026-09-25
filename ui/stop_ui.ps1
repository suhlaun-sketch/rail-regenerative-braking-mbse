$ErrorActionPreference = 'SilentlyContinue'
$uiRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$state = Join-Path $uiRoot 'cache\ui_processes.json'
if(Test-Path -LiteralPath $state){
    $pids = Get-Content -Raw -LiteralPath $state | ConvertFrom-Json
    foreach($id in @($pids.backend_pid,$pids.frontend_pid)){
        Get-CimInstance Win32_Process | Where-Object {$_.ParentProcessId -eq $id} | ForEach-Object {Stop-Process -Id $_.ProcessId -Force}
        Stop-Process -Id $id -Force
    }
    Remove-Item -LiteralPath $state -Force
}
Write-Output 'RAIL_MBSE_UI_STOPPED = YES'
