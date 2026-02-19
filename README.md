# AI prompt-engineering

## The Problem It Solves 
frames the three core failure modes of typical AI job searches (too narrow, too noisy, unverifiable) and explains precisely how each guardrail in the prompt addresses them.

## What the Results Show 
broken into four sub-sections: raw market scale (900+ live roles across sources before deduplication), commercial salary banding (£55k perm up to £850/day contract), government sector patterns (clearance tiers, IR35 reality, NPPV3 emergence), and the LinkedIn recruiter layer (roles that fill in 48–72 hours before they hit boards). This is by default, can be customised.

## How to Use the Results 
split by job type (permanent, contract, government, early market) with specific tactical advice for each.

## Refresh Strategy 
a cadence table showing what to run daily vs weekly vs 2–3× per week, with the reasoning behind each frequency.

## Honest Limitations 
five things the prompt cannot do, stated plainly. This section is intentionally included so expectations are calibrated and the gaps (EU Remote, gated portals, LinkedIn post content) are understood rather than discovered by surprise.


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


