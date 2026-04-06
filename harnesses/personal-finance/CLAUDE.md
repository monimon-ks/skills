# Personal Finance Harness

A harness where an agent team collaborates to produce financial management deliverables: income/expense analysis, budget design, investment strategy, tax savings approach, and retirement design.

## Structure

```
.claude/
├── agents/
│   ├── financial-analyst.md       — Financial analysis (income/expense, financial health diagnosis)
│   ├── budget-planner.md          — Budget design (category budget, savings goal)
│   ├── investment-advisor.md      — Investment strategy (asset allocation, portfolio design)
│   ├── tax-strategist.md          — Tax savings strategy (tax optimization, deductions)
│   └── finance-reviewer.md        — Cross-verification (analysis/budget/investment/tax consistency)
├── skills/
│   ├── personal-finance/
│   │   └── skill.md               — Orchestrator (team coordination, workflow, error handling)
│   ├── compound-interest-simulator/
│   │   └── skill.md               — Compound interest simulator (for investment-advisor)
│   └── financial-ratio-analyzer/
│       └── skill.md               — Financial ratio analysis (for financial-analyst)
└── CLAUDE.md                      — This file
```

## Usage

Trigger the `/personal-finance` skill, or make a natural language request such as "Help me with my finances."

## Deliverables

All deliverables are saved in the `_workspace/` directory:
- `00_input.md` — Organized user input
- `01_financial_analysis.md` — Income/expense analysis + financial health diagnosis
- `02_budget_plan.md` — Budget design + savings plan
- `03_investment_strategy.md` — Investment strategy + portfolio
- `04_tax_strategy.md` — Tax savings approach + retirement design
- `05_review_report.md` — Review report
