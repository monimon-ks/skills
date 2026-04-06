# skills
Skills repo to sync through devices. (mostly for claude-code)

## Quick Install

```bash
# Clone on a new machine
git clone git@github.com:monimon-ks/skills.git
```

### macOS / Linux

```bash
./install.sh                        # Global install to ~/.claude/
./install.sh --project /path/to/project  # Per-project install
```

### Windows (PowerShell)

```powershell
.\install.ps1                                # Global install to ~/.claude/
.\install.ps1 --project C:\path\to\project   # Per-project install
```

## What's Included

### Skills (15) - trigger with `/skill-name`

| Skill | Description |
|-------|-------------|
| `/thesis-advisor` | Thesis writing orchestrator |
| `/academic-writing-style` | Academic writing style guide |
| `/research-methodology` | Research methodology guidance |
| `/research-assistant` | Research assistant orchestrator |
| `/citation-formatter` | Citation format conversion (APA/MLA/Chicago/BibTeX) |
| `/systematic-review-protocol` | Systematic review (PRISMA, PICO, Boolean search) |
| `/personal-finance` | Personal finance orchestrator |
| `/compound-interest-simulator` | Compound interest calculations |
| `/financial-ratio-analyzer` | Financial ratio analysis |
| `/travel-planner` | Travel planning orchestrator |
| `/budget-calculator` | Travel budget calculations |
| `/route-optimizer` | Route optimization |
| `/meal-planner` | Meal planning orchestrator |
| `/nutrition-calculator` | Nutrition calculations |
| `/ingredient-substitution-engine` | Ingredient substitution (allergies, seasonal, budget) |

### Agents (23)

**Thesis Advisor**: literature-analyst, methodology-expert, proofreader, topic-explorer, writing-coach

**Research Assistant**: critic-synthesizer, literature-searcher, note-taker, reference-manager, research-coordinator

**Personal Finance**: budget-planner, finance-reviewer, financial-analyst, investment-advisor, tax-strategist

**Travel Planner**: budget-manager, destination-analyst, itinerary-designer, local-guide

**Meal Planner**: meal-designer, nutritionist, recipe-writer, shopping-coordinator

## Plugins (global, via `~/.claude/settings.json`)

These are installed globally and not project-specific:

```
frontend-design, superpowers, code-review, code-simplifier, github,
feature-dev, playwright, ralph-loop, claude-md-management,
claude-code-setup, pr-review-toolkit, vercel, data-engineering,
product-tracking-skills, devops-skills@akin-ozer
```
