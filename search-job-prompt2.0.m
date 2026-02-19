# 🔍 Technical Job Search Prompt — Senior Angular / Front-End Developer
> Version 2.0 | Improved for accuracy, real links, and tighter role targeting

---

## ⚙️ AGENT RULES (Read First — Apply to Every Section)

1. **Only include roles you can verify with a real, fetchable URL.** If you cannot retrieve the job page or confirm the listing exists, do not include it.
2. **Flag unverified roles** with ⚠️ if a URL was found in a search snippet but the page could not be fully fetched.
3. **Never fabricate, infer, or estimate job details** (title, rate, company, IR35 status) unless the source page explicitly states it. Use `—` for unknown fields.
4. **Do not include pipeline ads**, speculative CV collections, "register your interest" pages, or roles with no application mechanism.
5. **Deduplicate aggressively** — if the same role appears on multiple boards, list it once in the most authoritative source and note duplicates in the `Also Listed On` column.
6. **Validate posting date** — if a role is older than 14 days, flag it with 🕐 but still include it if the listing is confirmed open.
7. **For each role, attempt to fetch the direct job page URL** using web_fetch before including it. If the fetch fails, mark with ⚠️ and use the search result URL as fallback.

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
| ✅ Secondary | Remote EU | Must explicitly accept UK candidates; no relocation required |
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

### Step 1 — Adzuna (Most Reliable Fetchable Source)
Use these URL patterns and fetch each one:

```
https://www.adzuna.co.uk/jobs/search?q=senior+angular+developer&w=London&sort_by=date&days_old=14
https://www.adzuna.co.uk/jobs/search?q=angular+developer+remote&w=UK&sort_by=date&days_old=14
https://www.adzuna.co.uk/jobs/search?q=senior+front+end+developer+angular&w=UK&sort_by=date&days_old=14
```

### Step 2 — Reed
Search and fetch results from:
```
https://www.reed.co.uk/jobs/angular-developer-jobs?locationName=London&proximity=15&contract=true&permanent=true
https://www.reed.co.uk/jobs/angular-developer-jobs?locationName=Remote&contract=true
```

### Step 3 — CWJobs
```
https://www.cwjobs.co.uk/jobs/angular-developer/in-london
https://www.cwjobs.co.uk/jobs/contract/angular-developer
```

### Step 4 — JobServe (Contract-Focused)
```
https://www.jobserve.com/gb/en/JobSearch.aspx?shid=angular-developer-london-contract
```

### Step 5 — LinkedIn Jobs (Public Listings Only)
Use web_search with these queries to surface LinkedIn job URLs:
```
site:linkedin.com/jobs "senior angular developer" "remote" OR "london" "TypeScript"
site:linkedin.com/jobs "front end developer" "angular" "contract" "outside IR35" UK
site:linkedin.com/jobs "angular architect" OR "senior angular" "hybrid" "london"
```
Then fetch any LinkedIn job URLs returned to verify they are live.

### Step 6 — Google Jobs Queries
Run web_search with each query:
```
"senior angular developer" "outside IR35" "remote" site:uk.indeed.com OR site:reed.co.uk OR site:cwjobs.co.uk
"senior angular developer" "hybrid london" "£" -junior -graduate
"angular developer" "remote UK" "TypeScript" "RxJS" contract permanent 2025 OR 2026
```

### Step 7 — Government / SC-Cleared Roles (Dedicated Search)
```
"angular developer" "SC cleared" OR "SC eligible" contract OR permanent London OR remote
site:cwjobs.co.uk "angular" "SC cleared" OR "security clearance"
"angular developer" "public sector" OR "central government" OR "DWP" OR "MOD" OR "NHS"
```

---

## 📊 OUTPUT FORMAT

Produce **one table per section**. Use landscape orientation. Do not merge sections.  
Every row must have a valid, working URL in the Apply Link column.  
If a field is unknown, use `—`. Never guess.

---

### SECTION 1 — 🟢 Commercial Sector (Remote UK / Hybrid London)

**Focus:** Private sector only. FinTech, SaaS, Retail, Media, Startups, Consultancies.  
**Exclude:** Any role labelled Public Sector, Government, Central Government, Defence.

| # | Job Title | Company | Salary / Day Rate | Work Mode | IR35 Status | Tech Highlights | Contract Type | Source Board | Apply Link | Also Listed On |
|---|-----------|---------|-------------------|-----------|-------------|-----------------|---------------|-------------|--------------|------------|----------------|
| 1 | | | | | | | | | | | |

**Salary guidance:** Permanent £60k–£100k+ | Contract £400–£700/day  
**IR35 note:** State `Inside`, `Outside`, `TBC`, or `N/A – Perm`

---

### SECTION 2 — 🔴 Government / Public Sector (SC Cleared or Eligible)

**Focus:** Roles requiring or compatible with SC, DV, BPSS, or UKSV clearance.  
**Includes:** GDS, NHS, MOD, DWP, HMRC, Home Office, Police, Local Government, and contractors to these bodies.  
**Note:** WCAG 2.1/2.2 experience flagged where mentioned.

| # | Job Title | Company / Department | Salary / Day Rate | Work Mode | Clearance Required | Contract Type | IR35 Status | WCAG Required | Date Posted | Source Board | Apply Link |
|---|-----------|---------------------|-------------------|-----------|-------------------|---------------|-------------|---------------|-------------|--------------|------------|
| 1 | | | | | | | | | | | |

---

### SECTION 3 — 🟦 Remote EU Roles (UK Candidates Accepted)

**Focus:** Roles based in EU but explicitly open to UK-based remote workers.  
**Condition:** Must state "UK candidates welcome", "UK timezone", or "EU/UK remote" — do not infer.  
**Exclude:** Roles requiring EU residency, work permits, or relocation.

| # | Job Title | Company | Salary / Day Rate | Time Zone Requirement | Contract Type | UK Tax Compliant? | Tech Highlights | Date Posted | Source | Apply Link |
|---|-----------|---------|-------------------|-----------------------|---------------|-------------------|-----------------|-------------|--------|------------|
| 1 | | | | | | | | | | |

---

### SECTION 4 — 🟡 LinkedIn Spotted Roles (Recruiter & Agency Posts)

**Focus:** Roles posted by recruiters or agencies on LinkedIn — not formal job ads.  
**Source:** LinkedIn post search using Boolean:  
`("Angular" AND "Senior") AND ("hiring" OR "my client" OR "urgent") AND ("London" OR "Remote UK") AND ("contract" OR "day rate" OR "salary")`

**Rules:**
- Only include if a direct contact name, apply link, or LinkedIn post URL is available
- Exclude automated reposts and vague "we're always looking for…" posts
- Flag exclusive roles with 🔒

| # | Job Title | Agency / Recruiter | Salary / Rate | Work Mode | IR35 | Contact / Post Link | Date Spotted |
|---|-----------|-------------------|---------------|-----------|------|---------------------|--------------|
| 1 | | | | | | | |

---

## 🚫 QUALITY CONTROL CHECKLIST

Before outputting any row, confirm:

- [ ] Job title contains "Angular" OR JD explicitly mentions Angular v12+
- [ ] Location matches: Remote UK, Hybrid London (≤3 days), or Remote EU (UK-accepted)
- [ ] Role is Senior level (no junior/grad language)
- [ ] Apply link is a real URL (not a homepage or search page)
- [ ] Posting date is within 14 days OR flagged with 🕐 if older
- [ ] IR35 status is stated or marked TBC — never assumed
- [ ] Salary/rate is real data from the listing OR marked `—`

---

## 📌 SEARCH HASHTAGS (for LinkedIn Post Discovery)

**Commercial:**  
`#Angular` `#AngularDeveloper` `#FrontEndDeveloper` `#HiringNow` `#OutsideIR35` `#InsideIR35` `#ContractJobs` `#JobsInLondon` `#RemoteWork` `#UKTech` `#FinTechJobs` `#SaaSJobs` `#TechJobs`

**Government / Cleared:**  
`#SCCleared` `#UKSecurityClearance` `#PublicSectorJobs` `#GDS` `#GovernmentJobs` `#CivilService` `#DefenceJobs` `#NHSJobs` `#Angular`

---

## 🔁 REFRESH CADENCE RECOMMENDATION

| Board | Alert Setup | Frequency |
|-------|-------------|-----------|
| Adzuna | Email alert: "Senior Angular Developer" – London + Remote | Daily |
| Reed | Job alert: Angular – Remote / London – posted today | Daily |
| CWJobs | Alert: Angular Developer – Contract / Perm – Remote | Daily |
| LinkedIn | Job alert: Senior Angular Developer – UK – Remote | Daily |
| Google | Search alert: `"angular developer" "remote UK" "TypeScript"` | Daily |
| JobServe | Agent: Angular – Contract – London / Remote | Daily |

