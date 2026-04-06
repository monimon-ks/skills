# Install Claude Code skills and agents globally (~/.claude/) or into a project
# Usage:
#   .\install.ps1                          # Install globally to ~/.claude/
#   .\install.ps1 --project                # Install to current directory's .claude/
#   .\install.ps1 --project C:\path\to\project

param(
    [switch]$Project,
    [string]$Target = "."
)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

if ($Project) {
    $Target = Resolve-Path $Target
    $Dest = Join-Path $Target ".claude"
} else {
    $Dest = Join-Path $HOME ".claude"
}

Write-Host "Installing Claude Code skills & agents into: $Dest\"

# Create directories
New-Item -ItemType Directory -Force -Path (Join-Path $Dest "agents") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $Dest "skills") | Out-Null

# Copy agents
Write-Host "Copying agents..."
$agentFiles = Get-ChildItem -Path "$ScriptDir\agents\*.md"
foreach ($file in $agentFiles) {
    Copy-Item $file.FullName -Destination (Join-Path $Dest "agents") -Force
}
Write-Host "  -> $($agentFiles.Count) agents installed"

# Copy skills
Write-Host "Copying skills..."
$skillDirs = Get-ChildItem -Path "$ScriptDir\skills" -Directory
foreach ($dir in $skillDirs) {
    $destDir = Join-Path $Dest "skills\$($dir.Name)"
    New-Item -ItemType Directory -Force -Path $destDir | Out-Null
    Copy-Item "$($dir.FullName)\*" -Destination $destDir -Recurse -Force
}
Write-Host "  -> $($skillDirs.Count) skills installed"

Write-Host ""
Write-Host "Done! Installed $($agentFiles.Count) agents and $($skillDirs.Count) skills."
Write-Host ""
Write-Host "Available skills (trigger with /skill-name):"
foreach ($dir in $skillDirs) {
    Write-Host "  /$($dir.Name)"
}
