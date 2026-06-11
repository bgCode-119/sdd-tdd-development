param(
    [string]$TargetDir = "$HOME\.agents\skills"
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$skillsSource = Join-Path $repoRoot "skills"

if (-not (Test-Path -LiteralPath $skillsSource)) {
    throw "Skills source not found: $skillsSource"
}

New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null

$skillDirs = @(
    "sdd-tdd-development",
    "legacy-safe-refactor"
)

foreach ($skill in $skillDirs) {
    $source = Join-Path $skillsSource $skill
    $dest = Join-Path $TargetDir $skill

    if (-not (Test-Path -LiteralPath $source)) {
        throw "Missing skill directory: $source"
    }

    if (Test-Path -LiteralPath $dest) {
        Remove-Item -LiteralPath $dest -Recurse -Force
    }

    Copy-Item -LiteralPath $source -Destination $dest -Recurse -Force
    Write-Host "Installed $skill -> $dest"
}

Write-Host ""
Write-Host "Done."
Write-Host "Target: $TargetDir"
