# Install Claude Code skills and agents into a project's .claude/ directory
# Usage: .\install.ps1 [target-project-path]
#   If no path given, installs to current directory's .claude/

param(
    [string]$Target = "."
)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Target = Resolve-Path $Target

Write-Host "Installing Claude Code skills & agents into: $Target\.claude\"

# Create directories
New-Item -ItemType Directory -Force -Path "$Target\.claude\agents" | Out-Null
New-Item -ItemType Directory -Force -Path "$Target\.claude\skills" | Out-Null

# Copy agents
Write-Host "Copying agents..."
$agentFiles = Get-ChildItem -Path "$ScriptDir\agents\*.md"
foreach ($file in $agentFiles) {
    Copy-Item $file.FullName -Destination "$Target\.claude\agents\" -Force
}
Write-Host "  -> $($agentFiles.Count) agents installed"

# Copy skills
Write-Host "Copying skills..."
$skillDirs = Get-ChildItem -Path "$ScriptDir\skills" -Directory
foreach ($dir in $skillDirs) {
    $destDir = "$Target\.claude\skills\$($dir.Name)"
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
