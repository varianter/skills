---
name: kompetansematrise-filler
description: >
  Fill out competency matrices (erfarings- og kompetansematriser / egenerklæringer)
  for IT consultancy tenders using consultant CV data from FlowCase. Use when: (1)
  User provides a competency matrix as Excel (.xlsx), Word (.docx), PDF,
  image/screenshot, or pasted text and wants it scored for consultants, (2) User
  mentions "kompetansematrise", "egenerklæring", "erfaringsmatrise",
  "kvalifikasjonskrav", "selvdeklarasjon", "fylle ut matrise", "score konsulent", or
  similar, (3) User asks to score, evaluate, or match a consultant against a list of
  technologies, methods, or competencies for a tender (anbud/tilbud/anskaffelse), (4)
  User wants to find the best-matching consultant for a set of required competencies.
compatibility: Requires curl and jq for FlowCase API scripts. FLOWCASE_API_KEY and FLOWCASE_ORG environment variables must be set.
---

# Kompetansematrise Filler

## Workflow

### 1. Parse the matrix

Extract every competency row (technology/method/skill name, score column, description column) and the scoring scale (Poengskala) from the input. If no scale is present, ask the user for one.

Detect the matrix language — all descriptions must be written in that same language.

Confirm the extracted competency list with the user.

### 2. Identify priorities

Check the matrix for weighting (percentage columns, priority markers, groupings). Present any detected weights.

Ask: *"Er noen av kompetansene viktigere enn andre? Jeg ser [detected weights if any]. Bekreft eller juster."*

### 3. Select consultant(s)

Ask: *"Har du en spesifikk konsulent i tankene, eller skal jeg finne den best egnede?"*

**Named consultant:** Get name → `./scripts/get-consultant.sh "<name>"`

**Find best match:** Extract key skills (prioritize weighted ones) → `./scripts/search-consultant.sh "<skill1>" "<skill2>" ...` → present candidates → user selects → `./scripts/get-consultant.sh "<name>"` for each.

**Multiple consultants:** When filling for more than one consultant, produce a separate complete matrix per consultant. Run steps 4–5 for each.

### 4. Fill every row

For each consultant and **every row**, produce a score and description.

Load [references/examples.md](references/examples.md) for tone, structure, and scoring calibration across all levels (0–10).

#### Understanding the CV data

The scripts return FlowCase CV JSON. Key sections to mine for evidence:

- `project_experiences[]` — each has `customer.no` (client name), `description.no`, `year_from`, `year_to`, `roles[].name.no`, and `project_experience_skills[].tags.no` (technologies used)
- `technologies[]` — grouped by `category.no` (e.g. "Frontend", "Backend"), each containing `technology_skills[].tags.no` (skill names)
- `key_qualifications[]`, `educations[]`, `courses[]`, `certifications[]`

Note: text fields are multilingual objects (e.g. `customer.no` for Norwegian, `customer.int` for English).

#### Scoring

Apply the matrix's Poengskala. Assign the highest score the CV data honestly supports.

When the matrix uses a scale other than 0–10, map proportionally. For example on a 1–5 scale: 1 = no relevant experience, 3 = some experience or adjacent technology, 5 = expert. The relative ordering and evidence thresholds from the examples in references/examples.md still apply — a "5 of 5" needs the same depth of evidence as a "10 of 10".

#### Descriptions

2–4 sentences per row. Third person, consultant's first name. Reference specific projects, clients, roles, and durations from the CV. For high-priority competencies, include more project references.

#### Truthfulness — non-negotiable

Every claim must come directly from the CV data returned by the scripts. **Never invent projects, clients, roles, or durations.** Fabricated claims disqualify entire tenders.

- No CV mention → score 0, state honestly
- Ambiguous → ask the user rather than assume

#### Transferable experience

When CV shows strong experience with a closely related technology (e.g., PostgreSQL when MSSQL is asked, React when Angular is asked), describe it honestly as adjacent and transferable. See the adjacency table in [references/examples.md](references/examples.md). Score at midpoint (~5 on 0–10, ~3 on 1–5), never at expert level. Always make the adjacency explicit — never present related experience as direct experience.

#### Large matrices

For matrices with more than ~20 rows, present results in groups (by category or priority tier) rather than one giant table. This lets the user review and give feedback incrementally instead of being overwhelmed by a wall of text.

### 5. Review

Present the complete matrix — every row, every consultant. Iterate on feedback until approved.

### 6. Export

Ask: *"Skal jeg eksportere i Excel- eller Word-format?"*

Use Python with `openpyxl` for Excel (.xlsx) or `python-docx` for Word (.docx). Match the original matrix structure — same columns, same row order, scores and descriptions filled in. If the original was an Excel file, prefer writing back into it to preserve formatting.
