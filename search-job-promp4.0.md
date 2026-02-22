# 🔍 Senior Angular / Front-End Developer — Job Search Prompt
> **Version 4.0** | February 2026
> Rebuilt on production LLM principles: Structured Output · Guardrails · Evaluation Loops · Hallucination Handling · Latency & Cost Discipline

---

## ⚙️ PRINCIPLE 1 — STRUCTURED OUTPUT
> *"You can't render safely if the shape is random. Treat the model like a slightly unreliable microservice."*

Every role discovered MUST be output as a JSON object before being rendered into HTML. This enforces a stable, predictable data shape that survives prompt version changes, model updates, and edge cases.

### 📐 Canonical Role Schema

```json
{
  "id": "string (board-shortcode + sequential number, e.g. REED-001)",
  "title": "string",
  "company": "string | null",
  "salary_perm": "string | null",
  "day_rate": "string | null",
  "day_rate_arrangement": "umbrella | ltd | unknown | null",
  "work_mode": "remote_uk | hybrid_london | remote_eu | onsite | unknown",
  "hybrid_days_onsite": "number | null",
  "ir35": "outside | inside | not_applicable | tbc",
  "contract_type": "permanent | contract | ftc | freelance",
  "contract_duration": "string | null",
  "clearance": "none | bpss | sc_eligible | sc_active | dv_active | nppv3 | unknown",
  "wcag_required": true | false | null,
  "tech_stack": ["string"],
  "bonus_signals": ["string"],
  "sector": "commercial | government | eu_remote",
  "source_board": "string",
  "source_url": "string (direct job page URL)",
  "source_url_verified": true | false,
  "also_listed_on": ["string"],
  "date_posted": "string | null",
  "date_flag": "current | stale_14d | stale_30d | unknown",
  "confidence": "high | medium | low",
  "confidence_reason": "string | null",
  "excluded": false,
  "exclusion_reason": null
}
```

### Excluded Role Schema (roles that fail QC)
```json
{
  "id": "string",
  "title": "string",
  "source_url": "string",
  "excluded": true,
  "exclusion_reason": "junior_title | no_angular | onsite_only | unverified_url | pipeline_ad | duplicate | stale_closed | relocation_required"
}
```

**Rule:** Populate the schema first. Render the HTML tables from the schema. Never render directly from raw search results.

---

## 🛡️ PRINCIPLE 2 — GUARDRAILS
> *"Defensive programming for probabilistic systems."*

### Input Guardrails (applied before any search step executes)

| Guardrail | Rule |
|-----------|------|
| Role scope | Only search for Angular / Front-End / UI roles. If prompt is reused for a different role, halt and flag scope mismatch. |
| Location scope | UK only (Remote UK, Hybrid London, Remote EU with explicit UK acceptance). Reject all others at schema level. |
| Seniority gate | If title contains any of: `Junior` `Graduate` `Associate` `Intern` `Entry Level` `Trainee` `Apprentice` → set `excluded: true`, `exclusion_reason: "junior_title"`. Do not include in output tables. |
| Tech gate | If Angular is not confirmed in title OR job description → set `excluded: true`, `exclusion_reason: "no_angular"`. |

### Output Guardrails (applied before any row is written to HTML)

| Field | Rule |
|-------|------|
| `source_url` | Must be a non-homepage, non-search-results URL where possible. If only a search URL is available, set `source_url_verified: false`. |
| `salary_perm` / `day_rate` | Must be verbatim from the listing. If not stated, set `null`. Never estimate or interpolate. |
| `ir35` | Must be stated in the listing. If not stated, set `"tbc"`. Never infer from sector or role type. |
| `company` | If the company is undisclosed by the listing, set `null`. Never guess from context. |
| `confidence` | Set `"low"` if: URL could not be fetched, posting date unknown, or more than 2 required fields are null. Always populate `confidence_reason`. |

### Schema Enforcement Rules
- All 24 fields must be present in every role object — use `null` for unknown, never omit
- `work_mode` must be one of the 5 enum values — no free text
- `ir35` must be one of the 4 enum values — no free text
- `sector` must be one of the 3 enum values — determines which output table the role appears in
- `confidence` must always be set — never omit

### Fallback Flows
| Failure Mode | Fallback Behaviour |
|---|---|
| URL fetch returns 403 | Set `source_url_verified: false`, `confidence: "low"` — include in output with ⚠️ badge |
| URL fetch returns 404 | Set `excluded: true`, `exclusion_reason: "unverified_url"` — do not include |
| Date cannot be determined | Set `date_flag: "unknown"`, `confidence: "medium"` or `"low"` |
| All fields null except title + URL | Set `confidence: "low"`, include with full null fields — do not fabricate |
| Source board blocks all fetches | Include live search link only in Section 4, do not fabricate roles |

---

## 🔬 PRINCIPLE 3 — EVALUATION LOOP
> *"You don't just ship a prompt. You measure it."*

### Self-Evaluation: Run After Every Execution

Before finalising output, the model must complete this evaluation pass and append results as a collapsible `<details>` block in the HTML output:

```
## 📊 Execution Evaluation Report

### Coverage
- Steps executed: X / 14
- Steps that returned results: X
- Steps blocked (403/timeout): X (list which)
- Steps with no results: X (list which)

### Role Quality
- Total roles found (before QC): X
- Roles excluded (QC failures): X
- Exclusion breakdown: { junior_title: X, no_angular: X, unverified_url: X, duplicate: X, pipeline_ad: X, other: X }
- Roles included in output: X

### Confidence Distribution
- High confidence roles: X (X%)
- Medium confidence roles: X (X%)
- Low confidence roles: X (X%)

### Field Completeness
- Roles with salary/rate confirmed: X / X
- Roles with IR35 confirmed: X / X
- Roles with date confirmed: X / X
- Roles with URL verified: X / X

### Known Gaps This Run
- [ List any sectors, boards, or role types known to be under-represented ]

### Prompt Version: 4.0 | Execution Date: [date]
```

### Version Comparison Checklist (when re-running after prompt update)
- Did role count increase or decrease vs previous run?
- Did confidence distribution shift?
- Did new sources contribute unique roles not found previously?
- Did any exclusion reason appear more frequently (signal of prompt drift)?

---

## 🎲 PRINCIPLE 4 — HALLUCINATION HANDLING
> *"A strong AI feature isn't one that's always right. It's one that fails safely."*

### Uncertainty Signals — When to Set `confidence: "low"`
- URL could not be fetched (fetch returned error or redirect to homepage)
- Salary or day rate not confirmed by source text
- Posting date not present in search result or fetched page
- Company name not stated in listing (undisclosed client)
- More than 2 required schema fields are null
- Role found only in a search snippet — full page not fetched

### What the Model Must Never Do
- ❌ Estimate a salary based on "typical market rates" for that role type
- ❌ Assume IR35 status based on sector (e.g. "government = inside IR35")
- ❌ Infer company name from context clues
- ❌ Mark a role as "Remote UK" because the board is UK-based (must be stated in listing)
- ❌ Fabricate a posting date based on recency of search result
- ❌ Create a plausible-sounding apply URL that was not returned in search results

### UI Warning Signals (in HTML output)
| Signal | Badge | Meaning |
|--------|-------|---------|
| `confidence: "low"` | 🔶 Low Confidence | More than 2 fields unconfirmed — verify carefully |
| `source_url_verified: false` | ⚠️ Unverified | URL found but not fetched — may be dead |
| `date_flag: "stale_14d"` | 🕐 14d+ | Posted over 14 days ago — confirm still open |
| `date_flag: "stale_30d"` | 🕑 30d+ | Posted over 30 days ago — likely filled |
| `date_flag: "unknown"` | ❓ Date unknown | Could not confirm posting date |

### "I Don't Know" Protocol
If a search step returns zero results and no fallback is available, the model must explicitly state this in the Evaluation Report rather than populating the section with inferred or approximate results. An empty section is always preferable to a fabricated one.

---

## ⚡ PRINCIPLE 5 — LATENCY & COST DISCIPLINE
> *"Suddenly AI design becomes systems design."*

### Token Budget Management

| Phase | Token Strategy |
|-------|---------------|
| Search execution | Use short, precise queries (≤8 words). Avoid verbose Boolean where a targeted URL fetch works. |
| Schema population | Populate only confirmed fields. Null is cheaper than fabrication. |
| HTML rendering | Generate once from schema — do not re-fetch or re-process results during render phase. |
| Evaluation report | Counts and percentages only — no prose summaries. |

### Search Step Prioritisation (execute in this order, stop early if token budget is at risk)

| Priority | Steps | Rationale |
|----------|-------|-----------|
| 🔴 Mandatory | Steps 1–3 (Reed, CWJobs, ZipRecruiter) | Highest UK volume, most fetchable |
| 🔴 Mandatory | Step 7 (TotalJobs) | Confirmed high unique role yield |
| 🔴 Mandatory | Step 14 (Government SC search) | Section 2 cannot be populated otherwise |
| 🟡 Important | Steps 4–6 (LinkedIn, JobServe, CareerHound) | High signal, variable fetch success |
| 🟢 Optional | Steps 8–13 (Hiring.cafe, Indeed, JobSite, WorkingNomads, RemoteOK, Google) | Supplementary — skip if token budget tight |

### Streaming-Friendly Output Order
Generate output sections in this order to allow partial rendering:
1. Evaluation metadata block (lightweight)
2. Section 1 — Commercial (largest, highest value)
3. Section 2 — Government
4. Section 3 — LinkedIn Spotted
5. Section 4 — Live Search Links (static, no fetch required)
6. Excluded roles log (appendix)

### Caching Guidance
The Section 4 live search links table is **static** — the URLs do not change between runs. Do not re-validate these URLs on every execution. Re-validate only when a board is added or a link is reported broken.

---

## 🎯 ROLE TARGETING (Strict — Unchanged from v3.1)

### Titles to Include
`Senior Angular Developer` · `Senior Front-End Developer/Engineer` · `Angular Architect` · `UI/UX Engineer (Angular stack)` · `Senior JavaScript Developer (Angular primary)` · `Full Stack Developer (Angular front-end dominant)`

### Hard Exclusions
`Junior` `Graduate` `Associate` `Intern` `Entry Level` `Trainee` `Apprentice` · Any role where Angular is secondary to another framework

### Required Tech Stack
Angular v12+ · TypeScript · RxJS

### Bonus Signals (weight higher)
NgRx · Signals · Jest/Vitest/Cypress · NX Monorepos · Micro-frontends · SCSS/Tailwind · WCAG 2.1

---

## 📍 LOCATION FILTER (Strict)

| Priority | Type | Condition |
|----------|------|-----------|
| ✅ Primary | Remote UK | Must be explicitly stated as UK-eligible |
| ✅ Primary | Hybrid London | Max 3 days/week onsite |
| ✅ Secondary | Remote EU | Must explicitly state "UK candidates welcome" / "UK timezone" / "EU/UK remote" |
| ❌ Exclude | Onsite only | 5 days/week in office |
| ❌ Exclude | Relocation | Outside UK or requires moving |

---

## 🔎 SEARCH EXECUTION PLAN (14 Steps)

Execute in priority order. Log fetch status for each URL. Populate schema before rendering.

### 🔴 MANDATORY

**Step 1 — Reed**
```
https://www.reed.co.uk/jobs/angular-developer-remote-jobs
https://www.reed.co.uk/jobs/contract-angular-developer-jobs
```

**Step 2 — CWJobs**
```
https://www.cwjobs.co.uk/jobs/angular-developer/in-london
https://www.cwjobs.co.uk/jobs/contract/angular-developer
https://www.cwjobs.co.uk/jobs/senior-angular-developer/in-london
https://www.cwjobs.co.uk/jobs/angular-remote
https://www.cwjobs.co.uk/jobs/angular-developer/in-europe
```

**Step 3 — ZipRecruiter UK**
```
https://www.ziprecruiter.co.uk/Jobs/Remote-Angular/--in-England
https://www.ziprecruiter.co.uk/Jobs-/Angular
```

**Step 7 — TotalJobs**
```
https://www.totaljobs.com/jobs/angular-developer/in-london
https://www.totaljobs.com/jobs/contract/angular-developer
https://www.totaljobs.com/jobs/angular-remote
https://www.totaljobs.com/jobs/senior-angular-developer
```

**Step 14 — Government / SC-Cleared**
```
"angular developer" "SC cleared" OR "SC eligible" contract OR permanent London OR remote
site:cwjobs.co.uk "angular" "SC cleared" OR "security clearance"
"angular developer" "public sector" OR "GDS" OR "DWP" OR "MOD" OR "NHS"
```

### 🟡 IMPORTANT

**Step 4 — LinkedIn Jobs**
```
site:linkedin.com/jobs "senior angular developer" "remote" OR "london" "TypeScript"
site:linkedin.com/jobs "front end developer" "angular" "contract" "outside IR35" UK
site:linkedin.com/jobs "angular architect" OR "senior angular" "hybrid" "london"
```

**Step 5 — JobServe**
```
https://www.jobserve.com/gb/en/Job-Search/
Fallback: site:jobserve.com "angular developer" "remote" OR "london" contract 2026
```

**Step 6 — CareerHound**
```
https://www.careerhound.io/
Fallback: site:careerhound.io angular developer UK remote
```

### 🟢 OPTIONAL

**Step 8 — Hiring.cafe** (403 expected — provide URL for manual use)
```
https://hiring.cafe/
```

**Step 9 — Indeed**
```
https://uk.indeed.com/q-angular-contract-remote-jobs.html
```

**Step 10 — JobSite**
```
https://www.jobsite.co.uk/jobs/front-end-angular-developer
```

**Step 11 — WorkingNomads**
```
https://www.workingnomads.com/remote-angular-jobs
```

**Step 12 — RemoteOK**
```
https://remoteok.com/remote-angular-jobs
```

**Step 13 — Google Jobs**
```
"senior angular developer" "outside IR35" "remote" site:uk.indeed.com OR site:reed.co.uk OR site:cwjobs.co.uk
"senior angular developer" "hybrid london" "£" -junior -graduate
"angular developer" "remote UK" "TypeScript" "RxJS" contract permanent 2026
```

---

## 📊 OUTPUT SPECIFICATION

### Render Pipeline
```
[Search Results] → [Schema Population] → [QC Pass] → [HTML Render] → [Eval Report]
         ↓                   ↓                ↓
   Raw snippets       24-field JSON       Exclusion log
```

### HTML Output Requirements
- Single self-contained `.html` file
- All tables: `overflow-x: auto` wrapper, `min-width: max-content` on `<table>`
- Scroll hint `→ scroll horizontally` above each table
- Styled scrollbar (`::-webkit-scrollbar`)
- Confidence badges: 🔶 Low · ⚠️ Unverified · 🕐 Stale 14d · 🕑 Stale 30d · ❓ Date unknown
- Evaluation Report appended as `<details><summary>📊 Execution Report</summary>...</details>`

### Section Structure
| Section | Schema Filter | Columns |
|---------|--------------|---------|
| 1 — Commercial | `sector: "commercial"`, `excluded: false` | # · Title · Company · Rate · Mode · IR35 · Tech · Type · Date · Source · Apply · Also On |
| 2 — Government | `sector: "government"`, `excluded: false` | # · Title · Dept · Rate · Mode · Clearance · Type · IR35 · WCAG · Date · Source · Apply |
| 3 — LinkedIn Spotted | `source_board: "LinkedIn"`, recruiter posts | # · Title · Agency · Rate · Mode · IR35 · Link · Date |
| 4 — Live Search Links | Static — no schema row | Board · Focus · Volume · Status · Link |
| Appendix — Excluded | `excluded: true` | ID · Title · URL · Exclusion Reason |

---

## 🚫 QUALITY CONTROL CHECKLIST

Run against every schema object before render:

- [ ] `tech_stack` includes Angular OR title confirms Angular role
- [ ] `work_mode` is `remote_uk`, `hybrid_london`, or `remote_eu` (with explicit UK acceptance confirmed)
- [ ] `contract_type` is not excluded type
- [ ] Title contains no hard-exclusion seniority terms
- [ ] `source_url` is not a homepage or generic search page (if it is, set `source_url_verified: false`)
- [ ] `date_flag` is set to correct value — never left blank
- [ ] `ir35` is set — never blank, `"tbc"` if unknown
- [ ] `confidence` is set — never blank
- [ ] `excluded` is explicitly `false` (not absent) for included roles

---

## 📌 LINKEDIN HASHTAGS

**Commercial:** `#Angular` `#AngularDeveloper` `#FrontEndDeveloper` `#HiringNow` `#OutsideIR35` `#InsideIR35` `#ContractJobs` `#JobsInLondon` `#RemoteWork` `#UKTech` `#FinTechJobs` `#SaaSJobs`

**Government:** `#SCCleared` `#UKSecurityClearance` `#PublicSectorJobs` `#GDS` `#GovernmentJobs` `#CivilService` `#DefenceJobs` `#NHSJobs` `#Angular`

---

## 📋 SOURCE REFERENCE

| Source | Type | Priority | Known Behaviour |
|--------|------|----------|----------------|
| Reed | Volume jobs board | 🔴 Mandatory | Fetchable · 271+ Angular roles |
| CWJobs | London/contract specialist | 🔴 Mandatory | Fetchable · SC/cleared roles |
| ZipRecruiter UK | Remote specialist | 🔴 Mandatory | Fetchable · 137+ remote roles |
| TotalJobs | High-volume UK board | 🔴 Mandatory | Fetchable · 162+ London · day rates confirmed |
| LinkedIn | Network + jobs | 🟡 Important | Public listings fetchable · posts require login |
| JobServe | Contract specialist | 🟡 Important | May block fetch · use web_search fallback |
| CareerHound | Company website crawler | 🟡 Important | Requires account · unique inventory |
| Hiring.cafe | AI aggregator | 🟢 Optional | 403 to bots · manual browser only |
| Indeed | Generalist | 🟢 Optional | Fetchable · govt/SC roles surface here |
| JobSite | Generalist | 🟢 Optional | Fetchable · SC/cleared listings |
| WorkingNomads | Remote only | 🟢 Optional | Fetchable · lower UK volume |
| RemoteOK | Remote global | 🟢 Optional | Fetchable · filter for UK |
| Google Jobs | Aggregator | 🟢 Optional | Surfaces cross-board results |

---

## 🔁 REFRESH CADENCE

| Board | Alert Setup | Frequency |
|-------|-------------|-----------|
| Reed | Angular – Remote/London – posted today | Daily |
| CWJobs | Angular Developer – Contract/Perm – Remote | Daily |
| TotalJobs | Senior Angular – London/Remote – Contract/Perm | Daily |
| LinkedIn | Senior Angular Developer – UK – Remote | Daily |
| ZipRecruiter | Angular – Remote England | Daily |
| JobServe | Search Agent: Angular + Contract + London/Remote | Daily |
| Indeed | Angular Developer – Remote – UK | Daily |
| CareerHound | Browse: Angular UK | Weekly |
| Hiring.cafe | Manual: "Angular Developer UK Remote" | Weekly |

---

*Prompt Version: 4.0 · Principles: Structured Output · Guardrails · Eval Loops · Hallucination Handling · Latency & Cost Discipline*
*Previous version: 3.0 · Upgraded: February 2026*