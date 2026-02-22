# 🏗️ Angular Job Search — System Design Spec
> **Version 1.0** | February 2026
> *search-job-prompt4.1.md*
> *Implements: Evaluation Loops (Principle 3) · Latency & Cost Discipline (Principle 5)*

---

## Overview

The prompt alone handles **what the model searches, validates, and renders**. This spec defines **everything around the model**: how runs are triggered, how results are compared across versions, how drift is detected, how costs are controlled, and how outputs are cached and served.

Without this layer, the prompt is a good one-shot tool. With it, it becomes a measurable, maintainable production system.

---

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                      TRIGGER LAYER                          │
│         Scheduler · Manual UI · Webhook · CLI               │
└─────────────────────┬───────────────────────────────────────┘
                      │
┌─────────────────────▼───────────────────────────────────────┐
│                   ORCHESTRATION LAYER                        │
│    Step Prioritiser · Token Budget Manager · Retry Logic     │
└──────┬──────────────┬──────────────────────┬────────────────┘
       │              │                      │
┌──────▼──────┐ ┌─────▼──────┐ ┌────────────▼───────────────┐
│ CACHE LAYER │ │ MODEL CALL │ │      FALLBACK ROUTER        │
│ Static URLs │ │ Claude API │ │ 403 → flag · 404 → exclude  │
│ Section 4   │ │ Prompt 4.1 │ │ Timeout → retry (max 2)     │
└──────┬──────┘ └─────┬──────┘ └────────────┬───────────────┘
       │              │                      │
┌──────▼──────────────▼──────────────────────▼───────────────┐
│                    OUTPUT LAYER                             │
│     Schema Parser · QC Validator · HTML Renderer            │
└──────────────────────┬──────────────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────────────┐
│                   EVAL & STORAGE LAYER                       │
│   Run Logger · Version Comparator · Drift Detector · DB      │
└─────────────────────────────────────────────────────────────┘
```

---

## Principle 3 — Evaluation Loops

### 3.1 Run Storage Schema

Every prompt execution produces a run record. Store in a lightweight database (SQLite locally, Postgres in production, or even a flat JSON file for solo use):

```json
{
  "run_id": "uuid",
  "prompt_version": "4.1",
  "executed_at": "ISO8601 timestamp",
  "steps_attempted": 14,
  "steps_successful": 10,
  "steps_blocked": 3,
  "steps_empty": 1,
  "roles_found_raw": 42,
  "roles_excluded": 11,
  "roles_output": 31,
  "exclusions": {
    "junior_title": 4,
    "no_angular": 2,
    "unverified_url": 3,
    "duplicate": 2,
    "pipeline_ad": 0,
    "other": 0
  },
  "confidence_distribution": {
    "high": 18,
    "medium": 9,
    "low": 4
  },
  "field_completeness": {
    "salary_rate_confirmed": 24,
    "ir35_confirmed": 19,
    "date_confirmed": 27,
    "url_verified": 28
  },
  "tokens_used": 18420,
  "cost_usd": 0.23,
  "output_file": "Angular_Jobs_2026-02-18.html",
  "known_gaps": ["EU remote section empty", "Hiring.cafe blocked"]
}
```

### 3.2 Automated Evaluation Checks

Run these checks automatically after each execution and flag regressions:

```python
def evaluate_run(current_run, previous_run):
    checks = []

    # Role count regression
    delta = current_run.roles_output - previous_run.roles_output
    if delta < -5:
        checks.append(("WARN", f"Role count dropped by {abs(delta)} vs previous run"))

    # Confidence degradation
    prev_high_pct = previous_run.confidence_distribution["high"] / previous_run.roles_output
    curr_high_pct = current_run.confidence_distribution["high"] / current_run.roles_output
    if curr_high_pct < prev_high_pct - 0.15:
        checks.append(("WARN", "High-confidence role % dropped >15pp vs previous run"))

    # Exclusion rate spike
    prev_excl_rate = previous_run.roles_excluded / previous_run.roles_found_raw
    curr_excl_rate = current_run.roles_excluded / current_run.roles_found_raw
    if curr_excl_rate > prev_excl_rate + 0.20:
        checks.append(("WARN", f"Exclusion rate spiked: {curr_excl_rate:.0%} vs {prev_excl_rate:.0%}"))

    # Source regression
    if current_run.steps_blocked > previous_run.steps_blocked + 2:
        checks.append(("WARN", "More sources blocked than previous run — check board access"))

    # Cost spike
    if current_run.cost_usd > previous_run.cost_usd * 1.5:
        checks.append(("WARN", f"Cost spiked: ${current_run.cost_usd:.2f} vs ${previous_run.cost_usd:.2f}"))

    return checks
```

### 3.3 Test Dataset for Prompt Evaluation

Maintain a golden dataset of known roles used to measure prompt accuracy across versions. Update monthly.

```json
{
  "test_dataset_version": "2026-02",
  "cases": [
    {
      "id": "TC-001",
      "description": "Should be INCLUDED — confirmed Senior Angular, remote UK, outside IR35",
      "input_snippet": "Senior Angular Developer | TypeScript | RxJS | Fully Remote UK | Outside IR35 | £450/day",
      "expected": { "excluded": false, "ir35": "outside", "work_mode": "remote_uk", "confidence": "high" }
    },
    {
      "id": "TC-002",
      "description": "Should be EXCLUDED — Junior in title",
      "input_snippet": "Junior Angular Developer | Remote | £30,000",
      "expected": { "excluded": true, "exclusion_reason": "junior_title" }
    },
    {
      "id": "TC-003",
      "description": "Should be EXCLUDED — Angular secondary",
      "input_snippet": "Senior React Developer with some Angular experience | London | £80,000",
      "expected": { "excluded": true, "exclusion_reason": "no_angular" }
    },
    {
      "id": "TC-004",
      "description": "IR35 must be TBC, not inferred — government role without explicit IR35 statement",
      "input_snippet": "Front End Developer | DWP | SC Cleared | London | £500/day",
      "expected": { "ir35": "tbc", "clearance": "sc_active" }
    },
    {
      "id": "TC-005",
      "description": "Salary must be null — listing says 'competitive salary'",
      "input_snippet": "Senior Angular Developer | FinTech | Competitive salary | Remote UK",
      "expected": { "salary_perm": null, "day_rate": null }
    },
    {
      "id": "TC-006",
      "description": "Should be low confidence — URL not fetchable",
      "input_snippet": "Senior Angular Developer | Company X | [403 on fetch]",
      "expected": { "source_url_verified": false, "confidence": "low" }
    },
    {
      "id": "TC-007",
      "description": "Should be EXCLUDED — EU role, no explicit UK acceptance",
      "input_snippet": "Senior Angular Developer | Amsterdam | €80,000",
      "expected": { "excluded": true, "exclusion_reason": "relocation_required" }
    },
    {
      "id": "TC-008",
      "description": "Should be INCLUDED as remote_eu — explicitly states UK accepted",
      "input_snippet": "Senior Angular Developer | Remote EU | UK candidates welcome | €90,000",
      "expected": { "excluded": false, "work_mode": "remote_eu", "sector": "eu_remote" }
    }
  ]
}
```

### 3.4 Version Comparison Report

Generate this diff report whenever the prompt version changes:

```
## Prompt Version Comparison
Previous: v3.1 → Current: v4.1
Runs compared: [run_id_old] vs [run_id_new]

| Metric                  | v3.1  | v4.1  | Delta  |
|-------------------------|-------|-------|--------|
| Roles output            | 23    | 31    | +8 ✅  |
| High confidence %       | 48%   | 58%   | +10pp ✅|
| Exclusion rate          | 18%   | 26%   | +8pp ⚠️ |
| URL verified %          | 74%   | 90%   | +16pp ✅|
| IR35 confirmed %        | 61%   | 71%   | +10pp ✅|
| Steps blocked           | 4     | 3     | -1 ✅  |
| Cost (USD)              | $0.18 | $0.23 | +$0.05 ⚠️|
| Token usage             | 14200 | 18420 | +4220 ⚠️|

Regressions flagged: Exclusion rate increased — investigate if new QC rules are too aggressive
Improvements: URL verification, IR35 completeness, overall role count
```

---

## Principle 5 — Latency & Cost Discipline

### 5.1 Token Budget Manager

Before executing optional steps (Steps 9–14), estimate remaining token budget:

```python
TOKEN_LIMITS = {
    "mandatory_steps": 8000,    # Steps 1–5: search + schema population
    "important_steps": 4000,    # Steps 6–8
    "optional_steps": 3000,     # Steps 9–14
    "render_budget": 5000,      # HTML generation
    "eval_block": 500,          # Self-evaluation block
    "buffer": 1000,             # Safety margin
    "total_target": 20000       # Stay under this per run
}

def should_run_optional_steps(tokens_used_so_far):
    remaining = TOKEN_LIMITS["total_target"] - tokens_used_so_far
    return remaining >= TOKEN_LIMITS["optional_steps"] + TOKEN_LIMITS["render_budget"] + TOKEN_LIMITS["buffer"]
```

### 5.2 Caching Strategy

| Content | Cache? | TTL | Rationale |
|---------|--------|-----|-----------|
| Section 4 live search links | ✅ Yes | 7 days | URLs don't change frequently |
| Individual job listing pages | ✅ Yes | 24 hours | Listings are stable within a day |
| Search result pages (board indices) | ✅ Yes | 6 hours | Boards update multiple times/day |
| LinkedIn post searches | ❌ No | — | Too volatile; recruiter posts disappear |
| Government SC-cleared searches | ✅ Yes | 48 hours | Slower-moving market |
| Evaluation run records | ✅ Yes | Permanent | Required for trend analysis |

### 5.3 Streaming Output Order

If running via API with streaming enabled, generate in this order to allow partial rendering in the UI:

```
1. Page header + source strip          → renders immediately (user sees activity)
2. Section 1 — Commercial              → highest value, longest section
3. Section 2 — Government              → second priority
4. Section 3 — LinkedIn Spotted        → lighter, faster
5. Section 4 — Live Search Links       → static, no model work required
6. Appendix — Excluded roles           → lowest priority, collapsed by default
7. Evaluation Report block             → last, also collapsed by default
```

### 5.4 Batching Strategy

For teams running this for multiple role types simultaneously:

```python
# Instead of: run sequentially (4 × full token budget)
run_search("Senior Angular Developer")
run_search("Senior React Developer")
run_search("Front End Architect")
run_search("UI Engineer")

# Do: share mandatory steps, fork at schema population
shared_results = run_mandatory_steps()  # Steps 1–5 once

angular_roles = filter_and_schema(shared_results, role="angular")
react_roles   = filter_and_schema(shared_results, role="react")
# etc.
# Reduces mandatory step cost by ~75% for multi-role runs
```

### 5.5 Cost Monitoring Alerts

Set thresholds and alert if exceeded:

```python
COST_ALERTS = {
    "per_run_warn":   0.30,   # USD — warn if single run exceeds this
    "per_run_stop":   0.50,   # USD — halt optional steps if approaching this
    "per_week_warn":  3.00,   # USD — warn if weekly total exceeds this
    "per_month_warn": 10.00,  # USD — flag for review
}
```

### 5.6 Retry & Timeout Policy

```python
FETCH_POLICY = {
    "timeout_seconds": 8,        # Abort fetch after 8s — prevents blocking on slow boards
    "max_retries": 2,            # Retry once on timeout, then mark as blocked
    "retry_delay_seconds": 3,    # Wait before retry
    "blocked_codes": [403, 429], # Do not retry — mark as blocked immediately
    "exclude_codes": [404, 410], # Do not retry — mark as excluded
}
```

---

## Drift Detection

Prompt and model behaviour can degrade over time without obvious cause. Run this check monthly or after any model version update:

### Signals to Watch
| Signal | Threshold | Action |
|--------|-----------|--------|
| High-confidence role % falls below 50% | Sustained 2+ runs | Review QC rules — may be too aggressive |
| Exclusion rate exceeds 40% | Sustained 2+ runs | Review targeting rules or board changes |
| `unverified_url` exclusions spike | +50% vs baseline | Check if boards changed URL structure |
| IR35 confirmed % falls below 50% | Sustained 2+ runs | Boards may have reduced transparency |
| Cost per run increases >30% | Single run | Check for prompt token bloat — review schema verbosity |
| Step block rate increases | 3+ consecutive runs | Boards may have updated anti-bot measures |

### Model Version Change Protocol
When Claude model version updates:
1. Run prompt unchanged against golden test dataset (Section 3.3)
2. Compare pass rate vs previous model
3. If pass rate drops >10% → review and update prompt before production use
4. Log model version in every run record

---

## File Structure (Recommended)

```
angular-job-search/
├── prompts/
│   ├── Angular_Prompt_v4_1_PromptLayer.md      ← What goes to the model
│   └── changelog.md                             ← Prompt version history
├── system/
│   └── Angular_System_Design_Spec_v1.md         ← This file
├── evals/
│   ├── test_dataset_2026-02.json                ← Golden test cases
│   └── run_history.json                         ← All run records
├── cache/
│   └── section4_links.json                      ← Cached static search links
└── outputs/
    ├── Angular_Jobs_2026-02-18.html
    └── Angular_Jobs_2026-02-25.html
```

---

## Quick Reference — What Lives Where

| Concern | Prompt Layer | System Layer |
|---------|-------------|-------------|
| Search step URLs | ✅ | — |
| Role targeting rules | ✅ | — |
| Schema definition | ✅ | — |
| Input/output guardrails | ✅ | — |
| Hallucination prohibitions | ✅ | — |
| Self-evaluation block | ✅ | — |
| Run storage & history | — | ✅ |
| Version comparison | — | ✅ |
| Golden test dataset | — | ✅ |
| Drift detection | — | ✅ |
| Token budget management | — | ✅ |
| Caching | — | ✅ |
| Streaming order | — | ✅ |
| Cost monitoring | — | ✅ |
| Retry/timeout policy | — | ✅ |
| Batching (multi-role) | — | ✅ |

---

*System Design Spec v1.0 · Pairs with Prompt v4.1 · February 2026*
*Implement in: Python · Node.js · or any language with HTTP + JSON support*
