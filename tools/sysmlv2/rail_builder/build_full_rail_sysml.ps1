[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$projectRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..\..'))
$python = Join-Path $projectRoot 'tools\interface_pipeline\.venv\Scripts\python.exe'
$nodeBuilder = Join-Path $PSScriptRoot 'build_mapping_workbooks.mjs'
$generated = Join-Path $projectRoot 'work\sysmlv2\full_engineering_model\01_generated\Rail_MBSE_Full_v1.sysml'

if (-not (Test-Path -LiteralPath $python -PathType Leaf)) { throw "Project Python not found: $python" }
if (-not (Test-Path -LiteralPath (Join-Path $PSScriptRoot 'node_modules') -PathType Container)) { throw "Artifact Tool node_modules junction is missing in $PSScriptRoot" }

$env:PYTHONDONTWRITEBYTECODE = '1'
$env:PYTHONIOENCODING = 'utf-8'

Push-Location -LiteralPath $projectRoot
try {
    & $python (Join-Path $PSScriptRoot 'inspect_excel_source.py')
    if ($LASTEXITCODE -ne 0) { throw 'Source audit failed.' }
    & $python (Join-Path $PSScriptRoot 'validate_source.py')
    if ($LASTEXITCODE -ne 0) { throw 'Source validation failed.' }
    & $python (Join-Path $PSScriptRoot 'build_full_model.py')
    if ($LASTEXITCODE -ne 0) { throw 'SysML build failed.' }
    $firstHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $generated).Hash
    & $python (Join-Path $PSScriptRoot 'build_full_model.py')
    if ($LASTEXITCODE -ne 0) { throw 'Determinism rebuild failed.' }
    $secondHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $generated).Hash
    if ($firstHash -ne $secondHash) { throw "Non-deterministic semantic output: $firstHash != $secondHash" }
    & node $nodeBuilder
    if ($LASTEXITCODE -ne 0) { throw 'Mapping workbook export failed.' }
    & $python (Join-Path $PSScriptRoot 'validate_sysml.py')
    if ($LASTEXITCODE -ne 0) { throw 'Official SysML validation failed.' }
    & $python (Join-Path $PSScriptRoot 'build_reports.py')
    if ($LASTEXITCODE -ne 0) { throw 'Report generation failed.' }
    Write-Output "FULL_RAIL_SYSML_V2=PASS"
}
finally {
    Pop-Location
}
