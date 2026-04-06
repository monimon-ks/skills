# Install Claude Code agent team harnesses globally (~/.claude/) or into a project
# Usage:
#   .\install.ps1                                        # Install ALL harnesses globally
#   .\install.ps1 thesis-advisor meal-planner             # Install specific harnesses globally
#   .\install.ps1 -Project                                # Install ALL harnesses into current project
#   .\install.ps1 -Project -Target C:\path\to\project     # Install ALL harnesses into a project
#   .\install.ps1 -List                                   # List available harnesses

param(
    [switch]$Project,
    [switch]$List,
    [string]$Target = ".",
    [Parameter(ValueFromRemainingArguments)]
    [string[]]$Harnesses
)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$HarnessDir = Join-Path $ScriptDir "harnesses"

# --list mode
if ($List) {
    Write-Host "Available harnesses:"
    foreach ($dir in Get-ChildItem -Path $HarnessDir -Directory) {
        $agents = (Get-ChildItem -Path (Join-Path $dir.FullName "agents\*.md") -ErrorAction SilentlyContinue).Count
        $skills = (Get-ChildItem -Path (Join-Path $dir.FullName "skills") -Directory -ErrorAction SilentlyContinue).Count
        Write-Host "  $($dir.Name) ($agents agents, $skills skills)"
    }
    exit
}

# Determine destination
if ($Project) {
    $ResolvedTarget = Resolve-Path $Target
    $Dest = Join-Path $ResolvedTarget ".claude"
} else {
    $Dest = Join-Path $HOME ".claude"
}

# If no harnesses specified, install all
if (-not $Harnesses -or $Harnesses.Count -eq 0) {
    $Harnesses = (Get-ChildItem -Path $HarnessDir -Directory).Name
}

Write-Host "Installing harnesses into: $Dest\"
New-Item -ItemType Directory -Force -Path (Join-Path $Dest "agents") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $Dest "skills") | Out-Null

$TotalAgents = 0
$TotalSkills = 0

foreach ($harness in $Harnesses) {
    $harnessPath = Join-Path $HarnessDir $harness
    if (-not (Test-Path $harnessPath)) {
        Write-Host "WARNING: Harness '$harness' not found, skipping."
        continue
    }

    Write-Host ""
    Write-Host "[$harness]"

    # Copy agents
    $agentsPath = Join-Path $harnessPath "agents"
    if (Test-Path $agentsPath) {
        $agentFiles = Get-ChildItem -Path "$agentsPath\*.md" -ErrorAction SilentlyContinue
        foreach ($file in $agentFiles) {
            Copy-Item $file.FullName -Destination (Join-Path $Dest "agents") -Force
        }
        $TotalAgents += $agentFiles.Count
        Write-Host "  agents: $($agentFiles.Count)"
    }

    # Copy skills
    $skillsPath = Join-Path $harnessPath "skills"
    if (Test-Path $skillsPath) {
        $skillDirs = Get-ChildItem -Path $skillsPath -Directory -ErrorAction SilentlyContinue
        foreach ($dir in $skillDirs) {
            $destSkill = Join-Path $Dest "skills\$($dir.Name)"
            New-Item -ItemType Directory -Force -Path $destSkill | Out-Null
            Copy-Item "$($dir.FullName)\*" -Destination $destSkill -Recurse -Force
        }
        $TotalSkills += $skillDirs.Count
        Write-Host "  skills: $($skillDirs.Count)"
    }
}

Write-Host ""
Write-Host "Done! Installed $TotalAgents agents and $TotalSkills skills from $($Harnesses.Count) harness(es) into $Dest\"
