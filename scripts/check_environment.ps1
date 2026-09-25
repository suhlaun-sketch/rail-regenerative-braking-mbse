$ErrorActionPreference = 'Stop'
$requirements = @(
    @{Name='Git'; Command='git'},
    @{Name='Git LFS'; Command='git-lfs'},
    @{Name='Python'; Command='python'},
    @{Name='Node'; Command='node'},
    @{Name='npm'; Command='npm'},
    @{Name='Docker'; Command='docker'}
)
foreach ($item in $requirements) {
    $found = Get-Command $item.Command -ErrorAction SilentlyContinue
    Write-Output ("{0}={1}" -f $item.Name, $(if ($found) { 'AVAILABLE' } else { 'MISSING' }))
}
python (Join-Path $PSScriptRoot 'check_release.py')
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
