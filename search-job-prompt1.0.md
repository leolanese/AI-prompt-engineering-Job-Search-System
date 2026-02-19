# Action: Search for active Senior Front-End/Angular Developer roles in the UK, using: Adzuna, LinkedIn, Reed, JobServe, CWJobs, with a dedicated section for LinkedIn discoveries and Post and generate a comprehensive table for each category. Focusing on London and Remote opportunities. Include both formal job board listings and LinkedIn agency/recruiter posts. Categorize results into "Government Sector" and "Commercial Sector" 
# Prompt: Technical Job Search Agent with LinkedIn Post Discovery and Adzuna Integration
# Objective: Find active Senior Front-End/Angular Developer roles from both formal job boards AND LinkedIn agency posts. Categorize results into "Government Sector" and "Commercial Sector".

# Role: Technical Job Search Agent with LinkedIn Post Discovery
# Objective: Find active Senior Front-End/Angular Developer roles from ALL available job markets (job boards, company portals, LinkedIn jobs, AND LinkedIn agency/recruiter posts). Categorize results into "Government Sector" and "Commercial Sector" with a dedicated LinkedIn discovery section.

## 🔹 COMMON CRITERIA (Apply to all sections)
- Role: "Angular Developer" OR "Senior Angular Developer" OR "Angular Architect" OR "Front-End Developer" OR "Senior Front-End Developer" OR "UX Engineer" OR "UI Engineer" OR "Front-End Engineer"
- Location: London (Hybrid/Remote/London) OR Remote UK OR Remote EU (must be open to UK-based candidates with or without sponsorship) OR UK Wide
- Recency: Posted within last 7 days (validate posting date - if older, flag but consider if still open)
- Seniority: Exclude 'Junior', 'Graduate', 'Associate', 'Intern', 'Entry Level', 'Trainee', 'Apprentice'
- Tech Stack: Angular (v12+), TypeScript, RxJS, NgRx/State Management, Signals, Unit Testing (Jest/Vitest/Karma/Cypress), SCSS/Tailwind
- Bonus Skills: NX Monorepos, Micro-frontends, Web Components
- Exclude: Recruitment 'pipeline' ads, speculative CV collections, non-active vacancies, roles requiring relocation outside UK
- Languages: English (primary), Spanish (bonus for bilingual roles)
- Job Types: Contract (Inside/Outside IR35), Permanent, FTC

## 🔹 JOB SOURCES TO SEARCH (Comprehensive List)
1. Job Boards: Indeed, Reed, CV-Library, TotalJobs, CWJobs, Jobsite, Monster, ziprecruiter.co.uk, learn4good.com, devjobsscanner.com, 
2. Tech-Specific: Wellfound (AngelList), StackOverflow Jobs, RemoteOK, WeWorkRemotely
3. Company Portals: Direct career pages of target employers (see lists below)
4. LinkedIn: LinkedIn Jobs (formal ads) AND LinkedIn Posts (agency/recruiter content)
5. Niche: Hackajob, Otta, Cord, Dice
6. Contract-Specific: JobServe, FreelancerMap, InsideIR35, OutsideIR35

---

## 🔹 SECTION 1: Government Sector
### Mandatory Filters:
- Clearance: ('SC Cleared' OR 'SC Clearable' OR 'Eligibility for SC' OR 'Active SC' OR 'UKSV' OR 'BPSS' OR 'DV Cleared')
- Sector Keywords: 'GDS', 'Government Digital Service', 'Public Sector', 'Central Government', 'Defence', 'Civil Service', 'NHS', 'Local Government', 'MoJ', 'Police'
- Target Employers: DWP, MOD, Home Office, HMRC, Deloitte (Public Sector), BAE Systems, Leidos, Sopra Steria, Capita, Atos, Fujitsu, PA Consulting, KPMG (Public Sector), PwC (Public Sector)
- Compliance: WCAG 2.1/2.2 experience preferred, Accessibility standards
- Salary: Include even if band/grade only (e.g., "SEO Band", "Band C", "G7", "HEO", "AO")
### LinkedIn Post Search Tags (Section Government Sector):
`#Angular` `#SCCleared` `#PublicSectorJobs` `#DefenceJobs` `#GDS` `#GovernmentJobs` `#CivilService` `#UKSecurityClearance` `#NHSJobs` `#CentralGovernment`
### Output Table:
| Job Title | Company | Salary/Rate (Perm/Contract) | Work Mode | Clearance Level | Source (Portal/Board) | Date Posted | Apply Link |

---

## 🔹 SECTION 2: Commercial Sector
### Mandatory Filters:
- Sector: Private Sector only (FinTech, Retail, SaaS, Consultancies, Startups, E-commerce, Media, Telecoms)
- Clearance: Exclude roles requiring SC clearance (focus on open market)
- Salary Transparency: Visible salary range or day rate REQUIRED (if hidden, attempt to estimate from context)
- Contractors: Note IR35 status if mentioned (Inside/Outside)
- Exclude: Any role labeled 'Public Sector', 'Government', 'Central Government', 'Defence'
### Target Employers (Commercial):
- FinTech: Revolut, Monzo, Starling, Wise, Klarna, ClearBank
- Retail: ASOS, Tesco, Sainsbury's, Marks & Spencer, John Lewis
- Media: BBC, Sky, Guardian, Financial Times
- Consultancies: Deloitte (Commercial), Accenture, Capgemini, Cognizant
- Startups: Series A-C funded tech companies
### LinkedIn Post Search Tags (Section Commercial Sector):
`#Angular` `#HiringNow` `#TechJobs` `#AngularDeveloper` `#FrontEndDeveloper` `#ContractJobs` `#OutsideIR35` `#InsideIR35` `#JobsInLondon` `#RemoteWork` `#UKTech` `#FinTechJobs` `#SaaSJobs`
### Output Table:
| Job Title | Company | Salary/Rate (Perm/Contract) | Work Mode | IR35 Status (if contract) | Source | Date Posted | Apply Link |

---

## 🔹 SECTION 3: 🟦 LinkedIn Spotted Roles (Agency/Recruiter Posts)
### Purpose: Capture opportunities NOT listed on formal job boards - often exclusive or early-market roles
### Source Types:
- LinkedIn posts from: Recruitment agencies, Freelance recruiters, Hiring managers, Talent acquisition teams, Tech leads
### Search Strategy:
- Boolean String for LinkedIn Post Search (`https://www.linkedin.com/posts`):
("Angular" OR "FrontEnd") AND ("Senior") AND ("hiring" OR "recruiting" OR "my client" OR "urgent") AND ("London" OR "Remote" OR "RemoteWork") AND ("contract" OR "permanent" OR "day rate" OR "salary") 
## LINKEDIN POST SEARCH STRATEGY
When searching LinkedIn posts:
1. Use Boolean strings combining:
   - Role keywords: ("Angular" AND "Senior" AND ("Developer" OR "Engineer"))
   - Agency signals: ("recruiting" OR "hiring" OR "my client" OR "urgent requirement")
   - Location: ("London" OR "Remote UK" OR "UK Remote")
   - Contract type: ("contract" OR "permanent" OR "day rate" OR "salary")
2. Filter by: Posts from recruitment agencies (exclude company career pages)
3. Prioritize posts with: Direct application links, contact names, or clear next steps
- EXCLUDE: Automated job ad reposts, company career page posts, duplicate of formal listings
### Output Table:
| Job Title | Company/Agency | Salary/Rate (Perm/Contract) | Work Mode | Application Link |
|-----------|---------------|----------------------------|-----------|-----------------|

---

## 🔹 SECTION 4: Aggregator Discovery (Adzuna layer)
Adzuna Primary query example:
https://www.adzuna.co.uk/jobs/search?q=Angular%20Developer&loc=86384&partnerb=1
## Mandatory Filters
Apply all COMMON CRITERIA plus:
Filter by “Last 7 Days” (if filter available)
Must explicitly include Angular in title or stack
Must include salary or day rate
Exclude roles outside UK eligibility
Exclude duplicates already listed other sections
## Output Table
| Job Title | Company | Salary/Rate | Work Mode | Contract Type | Original Source | Date Posted | Apply Link |

---

## 🔹 SECTION 5: Aggregator Discovery (Google Jobs layer)
Google Jobs Primary query example:
https://www.google.co.uk/search?q=angular+developer+london+in+the+last+3+days+in+the+last+3+days&rciv=jb&clksrc=alertsemail&jbr=sep:0
## Search Scope
Use Google Jobs queries with variations:
"Senior Angular contract London"
"Angular contractor Remote UK"
"Angular Outside IR35 last 3 days"
"Senior Front End Angular contract UK"
## Filter by: Date posted: Last 3 days (preferred) or Last 7 days (maximum)
## Location: UK / London / Remote UK
## Output Table
| Job Title | Company | Day Rate / Salary | Work Mode | IR35 Status | Original Source | Date Posted | Apply Link |

