# AI prompt-engineering. Job Search System

## What This Prompt Does & Why It's Powerful

## Demo

![Demo](./demo/demo.png)

## Overview

This is not a simple job search query. It is a **structured, multi-source intelligence system** designed to surface every active Senior Angular / Front-End Developer opportunity in the UK market — across commercial, government, and remote EU sectors, with a focus on verified, real job links and zero fabricated results.

When executed, it runs **14 sequential search steps** across **13 distinct job platforms**, applies strict quality control to every result, and outputs a fully formatted, horizontally scrollable HTML report with colour-coded badges, live apply links, and deduplication across sources.

---

## The Problem It Solves

Most job searches suffer from three critical failure modes:

1. **Too narrow** — searching one or two boards misses roles posted exclusively elsewhere (e.g. TotalJobs surfaced an investment bank contract at £nnn/day not found on Reed or CWJobs)
2. **Too noisy** — no filtering logic means junior roles, pipeline ads, and speculative CV grabs pollute results
3. **Unverifiable** — AI-assisted searches often return plausible-sounding but fabricated or dead links

> This prompt eliminates all three by enforcing URL verification before any role is included, applying hard exclusion rules for seniority, and separating results into clearly defined sectors and location categories.

---

## What the Results Show

### 📊 Scale of the Market

Each execution of this prompt surfaces the real-time scale of the UK Angular developer market:

| Source | Live Roles Found (Feb 2026) |
|--------|----------------------------|
| LinkedIn | 414 Angular Remote UK roles (57 new that week) |
| Reed | 271 Angular remote/contract roles |
| TotalJobs | 162+ in London alone, 501+ across Europe |
| ZipRecruiter UK | 137 remote England roles |
| CWJobs | 47+ remote Angular roles |
| JobSite, Indeed, SimplyHired | Additional contract and perm listings |

---

### 🟢 Commercial Sector Findings

The commercial results reveal a market split into two distinct hiring patterns:

**Permanent roles** are clustering around:
- £55,000–£65,000 for start-up / scale-up environments (often fully remote, equity potential)
- £70,000–£85,000 for FinTech, InsurTech, and IoT product companies
- Up to £85,000 for unicorn-stage companies with London hybrid arrangements

**Contract roles** span a wide band depending on sector and IR35 treatment:
- £350–£400/day — outside IR35, remote-first scale-ups and 6-month extensions
- £400–£550/day — the dominant market band for most commercial contracts
- £500/day — healthcare, SaaS, and 9-month contracts
- £700–£850/day — investment banking and high-complexity financial systems (Inside IR35, umbrella)

A notable emerging signal: As an example, a **Angular 19/20 experience is already appearing in job descriptions** (sports betting platform, AI/LLM context engineering roles), suggesting employers are pushing ahead of the Angular version curve faster than many candidates anticipate.

---

### 🔴 Government & Public Sector Findings

Government demand for Angular is real but concentrated in specific patterns:

- **BPSS/GDS roles** tend to be hybrid-light (1 day/week on-site) and Inside IR35, often via umbrella, with accessibility (WCAG 2.1/2.2) as a hard requirement
- **SC/DV cleared roles** command a premium: £500–£700/day, but are Inside IR35 in nearly all cases
- **MOD and Defence contracts** often run 12 months with rolling extensions, making them high-value despite IR35 treatment
- **NPPV3 clearance** is emerging alongside SC for certain high-profile policing/justice programmes at £520/day

> The government market is less price-transparent than commercial but offers longer contract durations and greater stability.

---

### 🟦 LinkedIn Recruiter Layer Findings

The LinkedIn spotted section reveals an important market dynamic: **a meaningful proportion of Angular roles never appear on formal job boards**. Recruiters post directly to LinkedIn as organic content, tagging them as client requirements with day rates and contact details.

These roles share common characteristics:
- Often filled faster (48–72 hours from post to placement)
- Sometimes genuinely exclusive to one agency
- Day rates tend to be stated more honestly (no umbrella obfuscation)
- Contact is direct — no ATS or application portal friction

The boolean search string embedded in the prompt is designed to capture these posts at the moment of publication, before they get reposted to boards.

---

### 🔗 Source Intelligence: What Each Board Contributes

One of the most valuable outputs of running this prompt multiple times is understanding **which boards contribute unique roles not found elsewhere**:

| Board | Unique Contribution |
|-------|-------------------|
| **TotalJobs** ★ | Highest-rate contracts (£700–850/day investment bank); Angular 19/20 roles; AI/LLM context engineering — many not on Reed or CWJobs |
| **Reed** | Best for volume permanent roles; start-up and scale-up perm market; clear salary display |
| **CWJobs** | Best for London hybrid contract market; SC/DV cleared listings; FinServ commodities roles |
| **LinkedIn** | Only place for exclusive recruiter-post roles and earliest-to-market opportunities |
| **ZipRecruiter** | Strong for pure remote Outside IR35 contractors; blockchain and niche tech sectors |
| **CareerHound** ★ | Direct company website jobs — zero competition from other applicants; direct hiring team contact |
| **JobServe** ★ | Contract specialist, daily updated; essential for high-frequency contract searchers |
| **Hiring.cafe** ★ | AI-aggregated early-market roles; requires manual browser access but surfaces roles before they reach boards |
| **Indeed / SimplyHired** | Government and public sector listings; FDM and consultancy SC-cleared roles |


** Data mining is not just about finding roles, it's about understanding the ecosystem of where roles appear first and how to leverage each source for maximum efficiency. 

---

## The Structural Advantages of This Prompt

### 1. URL Verification Guardrail
Every role must have a confirmed, fetchable source URL before being included. This single rule eliminates the most damaging flaw in AI-assisted job searches: the confident hallucination of plausible-looking but non-existent roles.

### 2. Hard Seniority Exclusions
Junior, Graduate, Associate, Intern, Trainee, Apprentice, and Entry Level are explicitly excluded at the instruction level — not filtered after the fact. This keeps signal-to-noise extremely high.

### 3. IR35 Integrity
IR35 status is only recorded if it appears verbatim in the source listing. It is never inferred, estimated, or assumed. Ambiguous roles are marked `TBC`. This matters enormously for contractors whose take-home calculation depends entirely on this classification.

### 4. Location Precision
Three tiers of location are accepted — Remote UK (primary), Hybrid London ≤3 days (primary), Remote EU with explicit UK acceptance (secondary) — with hard exclusions for full onsite and relocation requirements. This prevents the common failure mode of surfacing roles that look remote but require daily commuting.

### 5. Deduplication with Attribution
Roles appearing on multiple boards are listed once, with the secondary sources noted in the "Also On" column. This prevents the same role being applied to multiple times via different portals — a common mistake in high-volume job searches.

### 6. Sector Separation
Commercial and Government results are strictly separated. This matters because the application strategy, clearance requirements, IR35 treatment, umbrella company requirements, and salary negotiation dynamics are fundamentally different between the two sectors. Mixing them creates confusion and wasted effort.

---

## How to Use the Results Effectively

### For Permanent Roles
Focus on Section 1 (Commercial) rows marked `N/A – Perm`. Compare salary bands across sectors — IoT and FinTech are paying the most for senior Angular talent at present. Roles marked with "Also On" multiple boards suggest high employer investment in visibility, which signals genuine urgency to hire.

### For Contract Roles
Prioritise Outside IR35 rows first — filter Section 1 by the green `Outside IR35` badge. The £350–£550/day band is the most active. The £700–850/day band exists but is Inside IR35 umbrella, so effective take-home is closer to £420–£500/day equivalent.

### For Government / Cleared Work
Section 2 is your map. If you hold active SC, focus on the £500–£600/day Inside IR35 band — these are the most reliably available and fastest-filling. If you are SC eligible but not currently cleared, BPSS roles offer the entry point while clearance is processed.

### For Early Market Access
Set up the LinkedIn boolean search as a saved alert. Check Hiring.cafe manually weekly. Enable the JobServe Search Agent for daily contract emails. CareerHound weekly browsing surfaces company-direct roles 2–3 weeks before they appear on aggregators.

---

## Refresh Strategy

The market moves quickly. This prompt is designed to be re-run at the following cadence:

| Action | Frequency | Why |
|--------|-----------|-----|
| Re-execute full prompt | Weekly | Full market snapshot; catches new sources |
| Reed + CWJobs + TotalJobs alerts | Daily | Highest volume; fastest-changing |
| LinkedIn job alert (Senior Angular, UK Remote) | Daily | 57 new roles/week — early application advantage |
| JobServe Search Agent | Daily | Contract market moves in 24–48hr cycles |
| LinkedIn boolean post search (manual) | 2–3x per week | Exclusive recruiter posts fill in 48–72hrs |
| CareerHound browse | Weekly | Slow-moving but unique inventory |
| Hiring.cafe manual check | Weekly | Early-market AI aggregation |

---

## What This Prompt Cannot Do (Honest Limitations)

- **It cannot access gated portals** — platforms requiring login (some JobServe pages, Hiring.cafe, internal ATS systems) return 403 errors. These are flagged with ⚠️ and the URL is provided for manual access.
- **It cannot guarantee posting recency** — listings older than 14 days are flagged with 🕐, but job boards do not always remove filled positions promptly. Always verify directly before applying.
- **It cannot fetch LinkedIn individual post content** — the boolean string surfaces posts in search results, but full post content requires a logged-in LinkedIn session. The prompt surfaces the signal; you close the loop manually.
- **It does not negotiate or pre-screen** — it finds and organises opportunities. The application, screening, and negotiation remain human-led.
- **EU Remote Section gaps** — no EU roles explicitly confirming UK candidate acceptance were confirmed in the February 2026 execution. This section is intentionally left empty rather than populated with unverified guesses.

---

## Summary

> This prompt transforms a fragmented, multi-platform job market into a single, structured, verified intelligence report. It finds more roles, from more sources, with higher accuracy and lower noise than any single-board search. It is designed to be run weekly, evolved over time as new sources are added, and used as the foundation for a systematic, high-confidence job search — not a one-time query.

**Current confirmed live market size (UK, Senior Angular, Feb 2026):** 900+ active roles across all sources before deduplication.

---

## Part 1: AUTOMATIC Prompt search for job hunting +  Aggregator Discovery

⚠️ Tool Requirement Still Applies:<br/>
✅ Works with: Perplexity Pro, Bing Chat/Copilot, ChatGPT + Browsing, Claude + Web Search<br/>
❌ Won't work with: Standard ChatGPT, local LLMs, or any AI without live internet access<br/>
(They will hallucinate job listings — never trust unverified results)<br/><br/>

⚠️ Requires AI with live browsing/search. Standard LLMs will hallucinate (I used Perperxity, Claude and/or Grok)

---

##  Part 2: MANUAL search + LLM Analysis
### Enhanced LinkedIn Search Strategy:

> LinkedIn requires ALL terms to appear in EACH post.

```js
Steps that work:
- Go to LinkedIn.com
- Use search bar with boolean strings (adapted for LinkedIn's syntax)
- Filter by "Posts" (not Jobs)
- Filter by "Past week"
- Copy relevant posts
- Paste into LLM with your prompt to categorize and format
```

```js
// Primary Search String
(Angular OR frontend) AND (contract OR contractor) AND (London)

// Contract Focus
("Angular contractor" OR "Front-End contract") AND ("Outside IR35" OR "day rate" OR "umbrella")

// Agency Signals
("my client" OR "Angular" OR "TypeScript") AND ("UK remote")

// Location Specific
("Angular developer London" OR "Remote UK Angular") AND ("hiring immediately" OR "urgent")
```
---

## 🔹 PRO TIPS FOR EXECUTION

✅ **LinkedIn Post Search Timing**: Agency posts peak Mon-Wed 8-11 AM UK time — schedule searches then  
✅ **Agency Name Boost**: Add known UK tech agencies to Boolean if targeting specific recruiters:  
`("Robert Walters" OR "Hays" OR "Michael Page" OR "Understanding Recruitment" OR "Computer Futures")`  
✅ **Clearance Variants**: Always include: `("SC Cleared" OR "SC Clearable" OR "SC eligibility" OR "UKSV")`  
✅ **IR35 Filtering**: For contract roles, prioritize `#OutsideIR35` posts to avoid inside-IR35 contracts  
✅ **Tool Requirement**: This prompt requires AI with live browsing/search (Perplexity, Bing Chat, ChatGPT+Browsing). Standard LLMs cannot access live LinkedIn/job data.

---

### ⚖️ Legal Disclaimer & Fair Use Notice

#### What This Tool Is
This is a personal, non-commercial AI-assisted job search tool. It instructs an AI model to conduct structured searches across publicly accessible job board URLs, compile results into an organised report, and return direct links to the original source listings — functionally equivalent to a person manually visiting multiple job boards and noting relevant roles in a spreadsheet.
#### Data Sources & How They Are Accessed
All listings surfaced are drawn from **publicly accessible, search-engine-indexed web pages**, published by employers and agencies with the express intent of broad public distribution. No authenticated portals, private databases, or ATS systems are accessed. Where a URL returns an access error (403), the tool flags it with ⚠️ and does not attempt to bypass any access control. Content is retrieved via standard HTTP requests, identical to a web browser visiting a page, and is not stored, cached, or redistributed.
#### Intellectual Property & Fair Use
Job listings remain the intellectual property of the employers, agencies, and platforms that created them. This tool does not reproduce full job descriptions verbatim. Summarised details (title, rate, tech stack) constitute **fair dealing for research and private study** under the Copyright, Designs and Patents Act 1988, s.29. Every result includes a direct hyperlink to the original source, driving attribution and traffic back to the originating platform. This tool does not divert or disintermediate traffic — it directs users to original listings more efficiently:
#### Always Use the Original Source
**The original job board listing is always the authoritative source. This report is a reference index only.**
- Always click through to verify the full job description before applying
- Confirm the role is still active — filled positions are not always removed promptly (roles >14 days old are flagged 🕐)
- Apply only through official channels on the source platform
- Treat salary and rate figures as indicative — actual compensation may differ
#### MIT Limitation of Liability
Results are based on publicly available data at the time of search execution. Accuracy, completeness, and link availability cannot be guaranteed. Users rely on this output at their own discretion.

---

### :100: <i>Thanks!</i>
#### Now, don't be an stranger. Let's stay in touch!

<a href="https://github.com/leolanese" target="_blank" rel="noopener noreferrer">
  <img src="https://scastiel.dev/api/image/leolanese?dark&removeLink" alt="leolanese’s GitHub image" width="600" height="314" />
</a>

##### :radio_button: Portfolio: <a href="https://www.leolanese.com" target="_blank">www.leolanese.com</a>
##### :radio_button: Linkedin: <a href="https://www.linkedin.com/in/leolanese/" target="_blank">LeoLanese</a>
##### :radio_button: Twitter: <a href="https://twitter.com/LeoLanese" target="_blank">@LeoLanese</a>
##### :radio_button: DEV.to: <a href="https://www.dev.to/leolanese" target="_blank">Tech Blog</a>
##### :radio_button: Questions / Suggestion / Recommendation: developer@leolanese.com


