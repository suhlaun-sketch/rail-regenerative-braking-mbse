param(
    [Parameter(Mandatory=$true)][string]$ProjectId,
    [string]$Url = 'http://127.0.0.1:8080'
)
$ErrorActionPreference = 'Stop'
if ($ProjectId -notmatch '^[0-9a-fA-F-]{36}$') { throw 'ProjectId must be a UUID' }
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$folder = Join-Path $root 'ui/exports/syson'
New-Item -ItemType Directory -Force -Path $folder | Out-Null
$out = Join-Path $folder ("project-$ProjectId-" + (Get-Date -Format 'yyyyMMdd-HHmmss') + '.zip')
Invoke-WebRequest -UseBasicParsing -Uri ($Url.TrimEnd('/') + '/api/projects/' + $ProjectId) -OutFile $out -TimeoutSec 180
$zip = [System.IO.Compression.ZipFile]::OpenRead($out)
try { if ($zip.Entries.Count -lt 2) { throw 'Project export contains no documents or representations' } }
finally { $zip.Dispose() }
Write-Output $out
