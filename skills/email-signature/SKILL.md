---
name: email-signature
description: >
  Generate email signatures for Variant employees using the email-signature tool.
  Use this skill whenever a user asks for an email signature, wants to set up their
  email signature, or mentions they work at a Variant company (Variant Oslo, Variant
  Bergen, Variant Trondheim, Variant Stavanger, Variant Stockholm, Variant Linköping,
  Variant Göteborg, or just "Variant"). Even if the user only says "can you make me
  a signature" or "I need a new email signature" — trigger this skill.
---

# Email Signature Generator

Your job is to call the `email-signature` tool with as many pre-filled arguments as possible based on which Variant company the user works at, then let the interactive widget handle the rest.

## Step 1: Gather what you need

You need to know:
- **Company** (e.g. "Variant Bergen", "Variant Stockholm") — this drives address, URL, and greeting
- **Name** — ask if not given
- **Title** — ask if not given (it's optional, but nice to have)
- **Phone** — ask if not given

If the user has already told you their company in the conversation, don't ask again — just use it. Ask only for what's missing.

## Step 2: Look up company data

Read `references/companies.md` to resolve:
- `address_line1` and `address_line2` for the company
- `url` (www.variant.no for Norway, www.variant.se for Sweden)
- `greeting` (Norwegian, Swedish, or English based on company and user preference)

If the user's company name is ambiguous (e.g. they just say "Variant" without a city), ask which one — national/group management in Norway maps to `Variant` with Trondheim address; same pattern in Sweden.

## Step 3: Format the phone number

Format the phone number based on country (see `references/companies.md` for formatting rules). If the user gives a number without a country code, infer country from the company. Don't guess — if genuinely ambiguous, ask.

## Step 4: Call the tool

Call `email-signature` with all resolved fields. Pass everything you know — the tool will open an interactive widget where the user can review, adjust, and copy the final signature.

```
email-signature({
  greeting: <resolved greeting>,
  name: <name>,
  title: <title if given>,
  company: <exact company name>,
  phone: <formatted phone>,
  url: <resolved url>,
  address_line1: <resolved>,
  address_line2: <resolved>
})
```

## Tips

- Prefer pre-filling everything over asking the user to fill it in the widget — the point of this skill is to save them time.
- The greeting should match the company's language by default; only switch to English if the user asks.
- If the user mentions they prefer a different language for the greeting, honor that.
