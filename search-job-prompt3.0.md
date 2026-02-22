
# 🔍 Technical Job Search Prompt — Senior Angular / Front-End Developer
> Version 3.0 | Updated: February 2026 | Incorporates location tightening, new sources (TotalJobs, JobServe, CareerHound, Hiring.cafe), scrollable output, and URL-verification guardrails

---

## ⚙️ AGENT RULES (Read First — Apply to Every Section)

1. **Only include roles you can verify with a real, fetchable URL.** If you cannot retrieve the job page or confirm the listing exists, do not include it.
2. **Flag unverified roles** with ⚠️ if a URL was found in a search snippet but the page could not be fully fetched.
3. **Never fabricate, infer, or estimate job details** (title, rate, company, IR35 status) unless the source page explicitly states it. Use `—` for unknown fields.
4. **Do not include pipeline ads**, speculative CV collections, "register your interest" pages, or roles with no application mechanism.
5. **Deduplicate aggressively** — if the same role appears on multiple boards, list it once under the most authoritative source and note duplicates in the `Also Listed On` column.
6. **Validate posting date** — if a role is older than 14 days, flag it with 🕐 but still include it if the listing is confirmed open.
7. **For each role, attempt to fetch the direct job page URL** using web_fetch before including it. If the fetch fails, mark with ⚠️ and use the search result URL as fallback.
8. **Output format is HTML** — produce a single self-contained `.html` file with all tables having horizontal scroll (`overflow-x: auto`) so every column is accessible on any screen width.

---

## 🎯 ROLE TARGETING (Strict — Apply to All Sections)

### Titles to Include (Any of the Following)
- Senior Angular Developer
- Senior Front-End Developer / Engineer
- Angular Architect
- UI Engineer / UX Engineer (Angular stack)
- Senior JavaScript Developer (Angular primary)
- Full Stack Developer (Angular front-end dominant)

### Titles to EXCLUDE (Hard Exclusions)
`Junior` `Graduate` `Associate` `Intern` `Entry Level` `Trainee` `Apprentice`
Any role where Angular is secondary to another framework (e.g., "React Developer with some Angular")

### Required Tech Stack (Must Be Present in JD)
- Angular v12+ (mandatory)
- TypeScript
- RxJS

### Bonus / Strong Signal Skills (Weight Higher in Results)
- NgRx or Signals
- Jest / Vitest / Cypress
- NX Monorepos
- Micro-frontends / Web Components
- SCSS or Tailwind CSS
- WCAG 2.1 / Accessibility

---

## 📍 LOCATION FILTER (Strict)

| Priority | Location Type | Condition |
|----------|--------------|-----------|
| ✅ Primary | Fully Remote UK | Must be open to UK-based candidates |
| ✅ Primary | Hybrid – London | Max 3 days/week onsite in London |
| ✅ Secondary | Remote EU | Must explicitly state "UK candidates welcome", "UK timezone", or "EU/UK remote" — do NOT infer |
| ❌ Exclude | Onsite only | Any role requiring 5 days/week in office |
| ❌ Exclude | Relocation required | Outside UK or requires candidate to relocate |

---

## 💼 CONTRACT TYPES ACCEPTED

- Permanent (Perm)
- Contract — Outside IR35 ✅ preferred
- Contract — Inside IR35 ✅ acceptable (flag clearly)
- Fixed-Term Contract (FTC)
- Freelance / Self-employed

---

## 🔎 SEARCH EXECUTION PLAN

Execute each step in order. Attempt to fetch all URLs. Record which steps returned results.

### Step 1 — Reed
```
https://www.reed.co.uk/jobs/angular-developer-remote-jobs
https://www.reed.co.uk/jobs/contract-angular-jobs
```

### Step 2 — CWJobs
```
https://www.cwjobs.co.uk/jobs/angular-developer/in-london
https://www.cwjobs.co.uk/jobs/contract/angular-developer
https://www.cwjobs.co.uk/jobs/senior-angular-developer/in-london
https://www.cwjobs.co.uk/jobs/angular-remote
https://www.cwjobs.co.uk/jobs/angular-developer/in-europe
```

### Step 3 — ZipRecruiter UK
```
https://www.ziprecruiter.co.uk/Jobs/Remote-Angular/--in-England
https://www.ziprecruiter.co.uk/Jobs-/Angular
```

### Step 4 — LinkedIn Jobs (Public Listings Only)
Use web_search to surface LinkedIn job URLs:
```
site:linkedin.com/jobs "senior angular developer" "remote" OR "london" "TypeScript"
site:linkedin.com/jobs "front end developer" "angular" "contract" "outside IR35" UK
site:linkedin.com/jobs "angular architect" OR "senior angular" "hybrid" "london"
```
Then fetch any LinkedIn job URLs returned to verify they are live.

### Step 5 — JobServe ★ NEW
```
https://www.jobserve.com/gb/en/Job-Search/
```
JobServe is a contract-specialist board updated daily. Use their Search Agent feature for Angular + Contract + Remote alerts. If direct fetch is blocked, use web_search:
```
site:jobserve.com "angular developer" "remote" OR "london" contract 2026
```

### Step 6 — CareerHound ★ NEW
```
https://www.careerhound.io/
```
CareerHound surfaces jobs posted directly on company websites — not aggregated from LinkedIn or Indeed. Lower competition, direct applications to hiring teams. Use web_search if direct fetch is blocked:
```
site:careerhound.io angular developer UK remote
```

### Step 7 — TotalJobs ★ NEW
```
https://www.totaljobs.com/jobs/angular-developer/in-london
https://www.totaljobs.com/jobs/contract/angular-developer
https://www.totaljobs.com/jobs/angular-remote
https://www.totaljobs.com/jobs/senior-angular-developer
https://www.totaljobs.com/jobs/angular-developer/in-europe
```
TotalJobs is a high-volume UK board with 162+ Angular roles in London and 501+ across Europe as of February 2026. Confirmed fetchable via web_search. Particularly strong for contract roles — the contract Angular page lists real day rates (e.g. £400–£450/day umbrella, Angular 19/20 roles). Use web_search fallback:
```
site:totaljobs.com "angular developer" "remote" OR "london" contract 2026
```

### Step 8 — Hiring.cafe ★ NEW
```
https://hiring.cafe/
```
Note: Hiring.cafe may return a 403 to automated fetches (requires browser session). Flag with ⚠️ if blocked. Direct URL should be provided so the user can open it manually and search "Angular Developer UK Remote".

### Step 9 — Indeed
```
https://uk.indeed.com/q-angular-contract-remote-jobs.html
```

### Step 10 — JobSite
```
https://www.jobsite.co.uk/jobs/front-end-angular-developer
```

### Step 11 — WorkingNomads
```
https://www.workingnomads.com/remote-angular-jobs
```

### Step 12 — RemoteOK
```
https://remoteok.com/remote-angular-jobs
```

### Step 13 — Google Jobs / Web Search Queries
Run web_search with each query:
```
"senior angular developer" "outside IR35" "remote" site:uk.indeed.com OR site:reed.co.uk OR site:cwjobs.co.uk
"senior angular developer" "hybrid london" "£" -junior -graduate
"angular developer" "remote UK" "TypeScript" "RxJS" contract permanent 2025 OR 2026
```

### Step 14 — Government / SC-Cleared Roles (Dedicated Search)
```
"angular developer" "SC cleared" OR "SC eligible" contract OR permanent London OR remote
site:cwjobs.co.uk "angular" "SC cleared" OR "security clearance"
"angular developer" "public sector" OR "central government" OR "DWP" OR "MOD" OR "NHS" OR "GDS"
```

---

## 📊 OUTPUT FORMAT

- Produce a **single self-contained HTML file**
- All tables must have `overflow-x: auto` on their wrapper div — horizontal scroll is mandatory
- Include a subtle scroll hint label (`→ scroll horizontally`) above each table
- Use `min-width: max-content` on tables so columns never collapse
- Styled scrollbar preferred (`::-webkit-scrollbar`)
- Every row must have a valid, working URL in the Apply column
- If a field is unknown, use `—` — never guess
- Use colour-coded badges for IR35 status, clearance level, and contract type

---

### SECTION 1 — 🟢 Commercial Sector (Remote UK / Hybrid London)

**Focus:** Private sector only. FinTech, SaaS, Retail, Media, Startups, Consultancies.
**Exclude:** Any role labelled Public Sector, Government, Central Government, Defence.

| # | Job Title | Company | Salary / Day Rate | Work Mode | IR35 Status | Tech Highlights | Contract Type | Date Posted | Source Board | Apply Link | Also Listed On |
|---|-----------|---------|-------------------|-----------|-------------|-----------------|---------------|-------------|--------------|------------|----------------|

**Salary guidance:** Permanent £60k–£100k+ | Contract £400–£700/day
**IR35 note:** State `Inside`, `Outside`, `TBC`, or `N/A – Perm`

---

### SECTION 2 — 🔴 Government / Public Sector (SC Cleared or Eligible)

**Focus:** Roles requiring or compatible with SC, DV, BPSS, or UKSV clearance.
**Includes:** GDS, NHS, MOD, DWP, HMRC, Home Office, Police, Local Government, and contractors to these bodies.
**Note:** WCAG 2.1/2.2 experience flagged where mentioned in the listing.

| # | Job Title | Company / Department | Salary / Day Rate | Work Mode | Clearance Required | Contract Type | IR35 Status | WCAG Required | Date Posted | Source Board | Apply Link |
|---|-----------|---------------------|-------------------|-----------|-------------------|---------------|-------------|---------------|-------------|--------------|------------|

---

### SECTION 3 — 🟦 LinkedIn Spotted Roles (Recruiter & Agency Posts)

**Focus:** Roles posted by recruiters or agencies on LinkedIn — not formal job ads.
**Source:** LinkedIn post search using Boolean:
`("Angular" AND "Senior") AND ("hiring" OR ""my client OR "urgent") AND ("London" OR "Remote UK") AND ("contract" OR "day rate" OR "salary")`

**Rules:**
- Only include if a direct contact name, apply link, or LinkedIn post URL is available
- Exclude automated reposts and vague "we're always looking for…" posts
- Flag exclusive roles with 🔒

| # | Job Title | Agency / Recruiter | Salary / Rate | Work Mode | IR35 | Contact / Post Link | Date Spotted |
|---|-----------|-------------------|---------------|-----------|------|---------------------|--------------|

---

### SECTION 4 — 🔗 Verified Live Search Links (Run Daily)

All search URLs confirmed live. Mark ★ NEW for sources added in this version.
Flag Hiring.cafe with ⚠️ if 403 is returned — include the URL anyway for manual use.

| Board | Search Query / Focus | Filters | Status | Live Link |
|-------|---------------------|---------|--------|-----------|

---

## 🚫 QUALITY CONTROL CHECKLIST

Before outputting any row, confirm:

- [ ] Job title contains "Angular" OR JD explicitly mentions Angular v12+
- [ ] Location matches: Remote UK, Hybrid London (≤3 days), or Remote EU (UK explicitly accepted)
- [ ] Role is Senior level (no junior/grad language)
- [ ] Apply link is a real URL (not a homepage or generic search page)
- [ ] Posting date is within 14 days OR flagged with 🕐 if older
- [ ] IR35 status is stated from the listing or marked `TBC` — never assumed
- [ ] Salary/rate is real data from the listing OR marked `—`

---

## 📌 SEARCH HASHTAGS (for LinkedIn Post Discovery)

**Commercial:**
`#Angular` `#AngularDeveloper` `#FrontEndDeveloper` `#HiringNow` `#OutsideIR35` `#InsideIR35` `#ContractJobs` `#JobsInLondon` `#RemoteWork` `#UKTech` `#FinTechJobs` `#SaaSJobs` `#TechJobs`

**Government / Cleared:**
`#SCCleared` `#UKSecurityClearance` `#PublicSectorJobs` `#GDS` `#GovernmentJobs` `#CivilService` `#DefenceJobs` `#NHSJobs` `#Angular`

---

## 📋 NEW SOURCE NOTES (v3.0)

| Source | Type | Why Use It | Known Limitations |
|--------|------|-----------|-------------------|
| **JobServe** | Contract specialist board | Daily-updated IT contract roles; Search Agent for email alerts | May block automated fetch — use web_search fallback |
| **CareerHound** | Company website crawler | Surfaces jobs NOT on LinkedIn/Indeed; lower competition; direct apply to hiring team | Requires account for full access |
| **Hiring.cafe** | AI job aggregator | Aggregates from company sites and boards | Returns 403 to bots — must be opened manually in browser |
| **WorkingNomads** | Remote jobs board | Clean remote-only listings with UK filter | Smaller volume than Reed/CWJobs |
| **RemoteOK** | Remote jobs board | Global remote roles; filter for UK timezone | Global-first, UK roles need filtering |
| **TotalJobs** ★ | High-volume UK jobs board | 162+ Angular roles in London, 501+ in Europe; strong contract section with real day rates; confirmed fetchable | Mix of Angular-primary and Angular-secondary roles — apply title filter |

---

## 🔁 REFRESH CADENCE RECOMMENDATION

| Board | Alert Setup | Frequency |
|-------|-------------|-----------|
| Reed | Job alert: Angular – Remote / London – posted today | Daily |
| CWJobs | Alert: Angular Developer – Contract / Perm – Remote | Daily |
| LinkedIn | Job alert: Senior Angular Developer – UK – Remote | Daily |
| ZipRecruiter | Alert: Angular – Remote England | Daily |
| JobServe ★ | Search Agent: Angular + Contract + London/Remote | Daily |
| TotalJobs ★ | Alert: Senior Angular Developer – London/Remote – Contract/Perm | Daily |
| CareerHound ★ | Browse direct company postings: Angular UK | Weekly |
| Hiring.cafe ★ | Manual search: "Angular Developer UK Remote" | Weekly |
| Indeed | Alert: Angular Developer – Remote – UK | Daily |
| Google | Search alert: `"angular developer" "remote UK" "TypeScript"` | Daily |