---
name: kompetansematrise-filler
description: Fill out competancy matrices (erfarings- og kompetansematriser / egenerklæringer) for IT consultancy tenders using consultant CV data from FlowCase. Use when: (1) User provides a competancy matrix as Excel (.xlsx), Word (.docx), PDF, image/screenshot, or pasted text and wants it scored for consultants, (2) User mentions "kompetansematrise", "egenerklæring", "erfaringsmatrise", "kvalifikasjonskrav", "selvdeklarasjon", or similar, (3) User asks to score, evaluate, or match a consultant against a list of technologies, methods, or competancies for a tender (anbud/tilbud/anskaffelse), (4) User wants to find the best-matching consultant for a set of required competancies.
---

# Kompetansematrise Filler

## Workflow

### 1. Parse the matrix

Extract every competancy row (technology/method/skill name, score column, description column) and the scoring scale (Poengskala) from the input. If no scale is present, ask the user for one.

Detect the matrix language — all descriptions must be written in that same language.

Confirm the extracted competancy list with the user.

### 2. Identify priorities

Check the matrix for weighting (percentage columns, priority markers, groupings). Present any detected weights.

Ask: *"Er noen av kompetansene viktigere enn andre? Jeg ser [detected weights if any]. Bekreft eller juster."*

### 3. Select consultant(s)

Ask: *"Har du en spesifikk konsulent i tankene, eller skal jeg finne den best egnede?"*

**Named consultant:** Get name → `./scripts/get-consultant.sh "<name>"`

**Find best match:** Extract key skills (prioritize weighted ones) → `./scripts/search-consultant.sh "<skill1>" "<skill2>" ...` → present candidates → user selects → `./scripts/get-consultant.sh "<name>"` for each.

### 4. Fill every row

For each consultant and **every row**, produce a score and description.

Load [references/examples.md](references/examples.md) for tone, structure, and scoring calibration across all levels (0–10).

**Scoring:** Apply the matrix's Poengskala. Assign the highest score the CV data honestly supports.

**Descriptions:** 2–4 sentences per row. Third person, consultant's first name. Reference specific projects, clients, roles, and durations from the CV. For high-priority competancies, include more project references.

#### Truthfulness — non-negotiable

Every claim must come directly from the CV data returned by the scripts. **Never invent projects, clients, roles, or durations.** Fabricated claims disqualify entire tenders.

- No CV mention → score 0, state honestly
- Ambiguous → ask the user rather than assume

#### Transferable experience

When CV shows strong experience with a closely related technology (e.g., PostgreSQL when MSSQL is asked, React when Angular is asked), describe it honestly as adjacent and transferable. See the adjacency table in [references/examples.md](references/examples.md). Score at midpoint (~5), never at expert level. Always make the adjacency explicit — never present related experience as direct experience.

### 5. Review

Present the complete matrix — every row, every consultant. Iterate on feedback until approved.

### 6. Export

Ask: *"Skal jeg eksportere i Excel- eller Word-format?"*

Produce the final document matching the original matrix structure.