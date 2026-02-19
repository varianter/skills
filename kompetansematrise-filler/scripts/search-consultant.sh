#!/usr/bin/env bash
# search-consultant.sh — Search FlowCase for consultants matching skill keywords.
#
# Usage: ./scripts/search-consultant.sh "React" "Kubernetes" "PostgreSQL"
#
# Searches for each skill individually and ranks consultants by how many
# of the requested skills they appear in. Outputs a ranked JSON summary.
#
# Prerequisites: curl, jq
# Configuration: Set FLOWCASE_API_KEY and FLOWCASE_ORG below or as environment variables.

set -euo pipefail

# ─── Configuration ────────────────────────────────────────────────────────────
FLOWCASE_API_KEY="${FLOWCASE_API_KEY:-YOUR_API_KEY_HERE}"
FLOWCASE_ORG="${FLOWCASE_ORG:-YOUR_ORG_SUBDOMAIN}"
RESULTS_PER_SKILL="${FLOWCASE_RESULTS_PER_SKILL:-20}"
# ──────────────────────────────────────────────────────────────────────────────

BASE_URL="https://${FLOWCASE_ORG}.flowcase.com/api"
AUTH_HEADER="Token token=\"${FLOWCASE_API_KEY}\""

if [ "$#" -eq 0 ]; then
  echo "Usage: $0 \"skill1\" \"skill2\" \"skill3\" ..." >&2
  exit 1
fi

SKILLS=("$@")
TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

echo "Searching for consultants matching ${#SKILLS[@]} skills: ${SKILLS[*]}" >&2

# Step 1: Search for each skill and collect candidate hits
ALL_HITS="${TMPDIR}/all_hits.jsonl"
> "$ALL_HITS"

for SKILL in "${SKILLS[@]}"; do
  echo "  Searching skill: ${SKILL}..." >&2

  # Try technology_skill search first (exact tag match)
  RESPONSE=$(curl -s -X POST "${BASE_URL}/v4/search" \
    -H "Authorization: ${AUTH_HEADER}" \
    -H "Content-Type: application/json" \
    -d "{
      \"must\": [{\"technology_skill\": {\"tag\": \"${SKILL}\"}}],
      \"size\": ${RESULTS_PER_SKILL}
    }")

  NUM=$(echo "$RESPONSE" | jq '.cvs | length')

  # Fall back to free-text search if no technology_skill matches
  if [ "$NUM" -eq 0 ]; then
    RESPONSE=$(curl -s -X POST "${BASE_URL}/v4/search" \
      -H "Authorization: ${AUTH_HEADER}" \
      -H "Content-Type: application/json" \
      -d "{
        \"must\": [{\"query\": {\"value\": \"${SKILL}\"}}],
        \"size\": ${RESULTS_PER_SKILL}
      }")
    NUM=$(echo "$RESPONSE" | jq '.cvs | length')
  fi

  echo "    Found ${NUM} consultants for '${SKILL}'" >&2

  # Append each hit with the skill that matched
  echo "$RESPONSE" | jq -c --arg skill "$SKILL" \
    '.cvs[]? | {user_id, default_cv_id, name, email, title, skill: $skill}' >> "$ALL_HITS"
done

# Step 2: Rank consultants by number of distinct skill matches
echo "" >&2
echo "Ranking consultants by skill coverage..." >&2

RANKED=$(jq -s '
  group_by(.user_id)
  | map({
      user_id: .[0].user_id,
      cv_id: .[0].default_cv_id,
      name: .[0].name,
      email: .[0].email,
      title: .[0].title,
      matched_skills: [.[].skill] | unique,
      match_count: ([.[].skill] | unique | length)
    })
  | sort_by(-.match_count)
  | .[0:15]
' "$ALL_HITS")

NUM_CANDIDATES=$(echo "$RANKED" | jq 'length')
echo "Found ${NUM_CANDIDATES} unique candidates." >&2

# Step 3: Output ranked results to stdout
echo "$RANKED"