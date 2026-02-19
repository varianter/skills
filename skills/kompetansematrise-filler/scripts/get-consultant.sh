#!/usr/bin/env bash
# get-consultant.sh — Retrieve a consultant's full CV from FlowCase by name.
#
# Usage: ./scripts/get-consultant.sh "Firstname Lastname"
#
# Prerequisites: curl, jq
# Configuration: Set FLOWCASE_API_KEY and FLOWCASE_ORG below or as environment variables.

set -euo pipefail

# ─── Configuration ────────────────────────────────────────────────────────────
FLOWCASE_API_KEY="${FLOWCASE_API_KEY}"
FLOWCASE_ORG="${FLOWCASE_ORG}"
# ──────────────────────────────────────────────────────────────────────────────

BASE_URL="https://${FLOWCASE_ORG}.flowcase.com/api"
AUTH_HEADER="Token token=\"${FLOWCASE_API_KEY}\""

if [ -z "${1:-}" ]; then
  echo "Usage: $0 \"Consultant Name\"" >&2
  exit 1
fi

CONSULTANT_NAME="$1"

# Step 1: Search for user by name using v4 search API
echo "Searching for consultant: ${CONSULTANT_NAME}..." >&2

PAYLOAD=$(jq -n --arg name "$CONSULTANT_NAME" '{
  must: [{bool: {should: [{query: {field: "name", value: $name}}]}}],
  size: 5
}')

TMPFILE=$(mktemp)
trap 'rm -f "$TMPFILE"' EXIT

HTTP_STATUS=$(curl -s --connect-timeout 10 --max-time 30 -o "$TMPFILE" -w "%{http_code}" -X POST "${BASE_URL}/v4/search" \
  -H "Authorization: ${AUTH_HEADER}" \
  -H "Content-Type: application/json" \
  -d "$PAYLOAD")

if [ "$HTTP_STATUS" -ne 200 ]; then
  echo "API error searching for consultant (HTTP ${HTTP_STATUS}):" >&2
  cat "$TMPFILE" >&2
  exit 1
fi

SEARCH_RESPONSE=$(cat "$TMPFILE")

# Extract number of results
NUM_RESULTS=$(echo "$SEARCH_RESPONSE" | jq '.cvs | length')

if [ "$NUM_RESULTS" -eq 0 ]; then
  echo "No consultant found matching '${CONSULTANT_NAME}'." >&2
  exit 1
fi

# If multiple matches, list them and pick the first (or exact match)
if [ "$NUM_RESULTS" -gt 1 ]; then
  echo "Found ${NUM_RESULTS} matches:" >&2
  echo "$SEARCH_RESPONSE" | jq -r '.cvs[].cv | "  - \(.name) (\(.email // "no email"))"' >&2
  echo "Using first match." >&2
fi

# Extract user_id and cv_id from the first result
USER_ID=$(echo "$SEARCH_RESPONSE" | jq -r '.cvs[0].cv.user_id')
CV_ID=$(echo "$SEARCH_RESPONSE" | jq -r '.cvs[0].cv.id')
USER_NAME=$(echo "$SEARCH_RESPONSE" | jq -r '.cvs[0].cv.name')

if [ -z "$USER_ID" ] || [ "$USER_ID" = "null" ]; then
  echo "Could not extract user ID from search results." >&2
  exit 1
fi

echo "Found: ${USER_NAME} (user_id: ${USER_ID}, cv_id: ${CV_ID})" >&2

# Step 2: Fetch full CV data using v3 API
HTTP_STATUS=$(curl -s --connect-timeout 10 --max-time 30 -o "$TMPFILE" -w "%{http_code}" -X GET "${BASE_URL}/v3/cvs/${USER_ID}/${CV_ID}" \
  -H "Authorization: ${AUTH_HEADER}" \
  -H "Content-Type: application/json")

if [ "$HTTP_STATUS" -ne 200 ]; then
  echo "API error fetching CV (HTTP ${HTTP_STATUS}):" >&2
  cat "$TMPFILE" >&2
  exit 1
fi

# Step 3: Output the full CV JSON to stdout
cat "$TMPFILE"
