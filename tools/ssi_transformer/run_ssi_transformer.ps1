[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$projectRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..'))
$physicalRepositoryRoot = Join-Path $projectRoot 'third_party\ssi_transformer\Standard-System-Interface'
$physicalPython = Join-Path $projectRoot 'third_party\ssi_transformer\.venv\Scripts\python.exe'
$physicalEntryPoint = Join-Path $physicalRepositoryRoot 'source\SSI_transformer.py'
$physicalQtPluginDirectory = Join-Path $projectRoot 'third_party\ssi_transformer\.venv\Lib\site-packages\PyQt5\Qt5\plugins'

if (-not (Test-Path -LiteralPath $physicalPython -PathType Leaf)) {
    throw "SSI Transformer virtual-environment Python was not found: $physicalPython"
}

if (-not (Test-Path -LiteralPath $physicalEntryPoint -PathType Leaf)) {
    throw "SSI Transformer entry point was not found: $physicalEntryPoint"
}

if (-not (Test-Path -LiteralPath $physicalQtPluginDirectory -PathType Container)) {
    throw "PyQt5 plugin directory was not found: $physicalQtPluginDirectory"
}

$runtimeRepositoryRoot = 'C:\SSI_Runtime\repo'
$runtimeVenvRoot = 'C:\SSI_Runtime\venv'
$sourceDirectory = Join-Path $runtimeRepositoryRoot 'source'
$python = Join-Path $runtimeVenvRoot 'Scripts\python.exe'
$entryPoint = Join-Path $sourceDirectory 'SSI_transformer.py'
$qtPluginDirectory = Join-Path $runtimeVenvRoot 'Lib\site-packages\PyQt5\Qt5\plugins'
$qtPlatformPluginDirectory = Join-Path $qtPluginDirectory 'platforms'

if (-not (Test-Path -LiteralPath $entryPoint -PathType Leaf)) {
    throw "ASCII repo junction is missing or invalid: $runtimeRepositoryRoot"
}

if (-not (Test-Path -LiteralPath $python -PathType Leaf)) {
    throw "ASCII venv junction is missing or invalid: $runtimeVenvRoot"
}

if (-not (Test-Path -LiteralPath (Join-Path $qtPlatformPluginDirectory 'qwindows.dll') -PathType Leaf)) {
    throw "PyQt5 qwindows.dll was not found: $qtPlatformPluginDirectory"
}

# Keep the vendored source tree byte-for-byte clean while running the tool.
$env:PYTHONDONTWRITEBYTECODE = '1'
$env:QT_QPA_PLATFORM = 'windows'
$env:QT_QPA_PLATFORM_PLUGIN_PATH = $qtPlatformPluginDirectory
$env:QT_PLUGIN_PATH = $qtPluginDirectory

Push-Location -LiteralPath $sourceDirectory
try {
    & $python $entryPoint
    if ($LASTEXITCODE -ne 0) {
        throw "SSI Transformer exited with code $LASTEXITCODE."
    }
}
finally {
    Pop-Location
}
