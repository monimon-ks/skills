# skills

Claude Code agent team harnesses to sync across devices.

## Quick Install

```bash
git clone git@github.com:monimon-ks/skills.git
```

### macOS / Linux

```bash
./install.sh                                # All harnesses globally to ~/.claude/
./install.sh thesis-advisor meal-planner     # Specific harnesses only
./install.sh --project /path/to/project      # Into a project's .claude/
./install.sh --list                          # List available harnesses
```

### Windows (PowerShell)

```powershell
.\install.ps1                                        # All harnesses globally to ~/.claude/
.\install.ps1 thesis-advisor meal-planner             # Specific harnesses only
.\install.ps1 -Project -Target C:\path\to\project     # Into a project's .claude/
.\install.ps1 -List                                   # List available harnesses
```

## Available Harnesses

| Harness | Agents | Skills | Trigger |
|---------|--------|--------|---------|
| thesis-advisor | 5 | 3 | `/thesis-advisor` |
| research-assistant | 5 | 3 | `/research-assistant` |
| personal-finance | 5 | 3 | `/personal-finance` |
| travel-planner | 4 | 3 | `/travel-planner` |
| meal-planner | 4 | 3 | `/meal-planner` |

## Structure

```
harnesses/
├── thesis-advisor/
│   ├── CLAUDE.md
│   ├── agents/ (5)
│   └── skills/ (3)
├── research-assistant/
│   ├── CLAUDE.md
│   ├── agents/ (5)
│   └── skills/ (3)
├── personal-finance/
│   ├── CLAUDE.md
│   ├── agents/ (5)
│   └── skills/ (3)
├── travel-planner/
│   ├── CLAUDE.md
│   ├── agents/ (4)
│   └── skills/ (3)
└── meal-planner/
    ├── CLAUDE.md
    ├── agents/ (4)
    └── skills/ (3)
```

Each harness is self-contained with its own agents, skills, and documentation. See the `CLAUDE.md` inside each harness for details.

## Plugins (global, via `~/.claude/settings.json`)

```
frontend-design, superpowers, code-review, code-simplifier, github,
feature-dev, playwright, ralph-loop, claude-md-management,
claude-code-setup, pr-review-toolkit, vercel, data-engineering,
product-tracking-skills, devops-skills@akin-ozer
```
