$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$source = Join-Path $root 'third_party/ssi_transformer/Standard-System-Interface/source'
$entry = Join-Path $source 'SSI_transformer.py'
$venv = Join-Path $root 'third_party/ssi_transformer/.venv'
$python = Join-Path $venv 'Scripts/python.exe'
if (-not (Test-Path -LiteralPath $entry)) { throw 'SSI GUI source not found' }
if (-not (Test-Path -LiteralPath $python)) {
    if (Get-Command py -ErrorAction SilentlyContinue) { py -3.11 -m venv $venv }
    else { python -m venv $venv }
    if ($LASTEXITCODE -ne 0) { throw 'Python 3.11 is required for SSI GUI' }
    & $python -m pip install PyQt5==5.15.10
    if ($LASTEXITCODE -ne 0) { throw 'PyQt5 install failed' }
}
$env:PYTHONDONTWRITEBYTECODE = '1'
$env:QT_QPA_PLATFORM = 'windows'
$process = Start-Process -FilePath $python -ArgumentList $entry -WorkingDirectory $source -PassThru
Write-Output "SSI_GUI_PID=$($process.Id)"
