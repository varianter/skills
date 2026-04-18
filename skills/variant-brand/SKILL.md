---
name: variant-brand
description: >
  Guides building websites, pages, and UI components that match the Variant brand identity.
  Covers the full design system: Britti Sans typography, color palette, spacing, logos, section layouts,
  and the visual style of variant.no. Includes the official Variant logos as SVG assets.

  ALWAYS invoke this skill when the user wants to build something with Variant branding, make a page
  "look like variant.no", use the Variant design system, create a Variant-branded site or component,
  or mentions "Variant brand", "Variant style", or "variant.no design". Ask the user first if they want
  to use the Variant brand before proceeding — this skill should only be used with intent.
---

# Variant Brand Skill

This skill provides everything needed to build web content that matches Variant's brand identity, as used on [variant.no](https://www.variant.no).

## Before Starting — Confirm Intent

Before applying the Variant brand, ask the user:

> "Do you want to use the Variant brand? This will apply Variant's official colors, typography (Britti Sans), logo, and visual style to what we build."

Proceed only if they confirm. If they say yes, use this skill fully.

---

## Quick Reference

**Font:** Britti Sans (variable, weights 100–900). Font is located at `./assets/britti-sans.woff2`
**Primary text color:** `#222424`  
**Background light:** `#fafafa`  
**Background dark:** `#2d2d2d`  
**Primary green:** `#059a0b`  
**Accent violet:** `#7022d6`  
**Accent blue:** `#3840ff`  
**Border radius:** pill `24px` / medium `12px` / small `6px`  
**Logos:** `assets/logo-dark.svg` (on light) · `assets/logo-white.svg` (on dark)

---

## Font Setup

Britti Sans is Variant's custom variable font. If you don't have access to the actual font files, fall back gracefully:

```css
/* If you have the font files */
@font-face {
  font-family: "Britti Sans";
  src: url("/fonts/britti-sans.woff2") format("woff2");
  font-weight: 100 900;
  font-style: normal italic;
  font-display: swap;
}

:root {
  --font-britti:
    "Britti Sans", system-ui, "Segoe UI", Helvetica, Arial, sans-serif;
}

body {
  font-family: var(--font-britti);
  font-size: clamp(1rem, 0.9rem + 0.5vw, 1.2rem);
  color: #222424;
}
```

If Britti Sans is unavailable, use `system-ui` or `"Helvetica Neue"` as fallback — the proportions are similar enough to maintain the brand feel.

---

## Design Tokens — CSS Custom Properties

Paste these into your `:root` to have the full Variant token system available:

```css
:root {
  /* Typography scale */
  --text-titleXL: clamp(2.5rem, 6vw + 1rem, 4.5rem);
  --text-titleL: clamp(2rem, 4vw + 1rem, 3.5rem);
  --text-titleM: clamp(1.5rem, 3vw + 0.5rem, 2rem);
  --text-titleS: 1.5rem;
  --text-titleXS: 1.25rem;
  --text-subtitle: clamp(2rem, 3vw + 1rem, 2.5rem);
  --text-lead: clamp(1.125rem, 1.75vw + 0.5rem, 1.5rem);
  --text-normal: clamp(0.875rem, 2vw + 0.35rem, 1.125rem);
  --text-label: clamp(0.875rem, 2vw + 0.35rem, 1rem);

  /* Colors — Primitives */
  --Green-500: #059a0b;
  --Green-400: #37ae3c;
  --Green-50: #e6f5e7;
  --Violet-700: #7022d6;
  --Violet-50: #f0ebfe;
  --Blue-500: #3840ff;
  --Blue-50: #f2f3fd;
  --Yellow-400: #ffd02f;
  --Yellow-50: #fffbf6;
  --Red-500: #f0503f;
  --Dark-600: #222424;
  --Dark-500: #2d2d2d;
  --Dark-400: #3e3f3f;
  --Dark-300: #5e5e5e;
  --Light-100: #fafafa;
  --Light-500: #eaeaea;
  --Light-700: #acacac;

  /* Semantic text */
  --text-primary: #222424;
  --text-secondary: #3e3f3f;
  --text-tertiary: #5e5e5e;
  --text-light: #fafafa;
  --text-link: #3840ff;

  /* Backgrounds */
  --bg-light: #fafafa;
  --bg-dark: #2d2d2d;
  --bg-green: #059a0b;
  --bg-green-subtle: #dafbdc;
  --bg-blue-subtle: #f2f3fd;
  --bg-violet-subtle: #f0ebfe;
  --bg-yellow-subtle: #fffbf6;

  /* Spacing */
  --space-xs: 0.25rem;
  --space-s: 0.75rem;
  --space-m: 1.5rem;
  --space-l: 3rem;
  --space-xl: 6rem;
  --space-xxl: 9rem;

  /* Radius */
  --radius-s: 6px;
  --radius-m: 12px;
  --radius-l: 24px;

  /* Layout */
  --max-width: 1408px;
  --max-width-md: 1091px;
  --max-width-sm: 869px;
}
```

For the full color palette (all shades), see `references/design-tokens.md`.

---

## Logo

Two SVG logos are bundled in `assets/`:

- **`assets/logo-dark.svg`** — dark wordmark (`#333`), for use on white/light backgrounds
- **`assets/logo-white.svg`** — white wordmark, for use on dark or colored backgrounds

Both are 70×18px. Scale proportionally. Minimum display width ~60px. Use as `<img>` or inline SVG.

```html
<!-- On light backgrounds -->
<header>
  <img src="assets/logo-dark.svg" alt="Variant" width="105" height="27" />
</header>

<!-- On dark backgrounds -->
<footer style="background: #2d2d2d">
  <img src="assets/logo-white.svg" alt="Variant" width="105" height="27" />
</footer>
```

---

## Key Components

### Navigation Header

```html
<header class="site-header">
  <div class="site-header__inner">
    <a href="/" class="site-header__logo">
      <img src="assets/logo-dark.svg" alt="Variant" width="105" height="27" />
    </a>
    <nav class="site-header__nav">
      <a href="/about">About</a>
      <a href="/services">Services</a>
      <a href="/employees">People</a>
      <a href="/jobs">Jobs</a>
    </nav>
    <div class="site-header__lang">
      <a href="/en">EN</a> / <a href="/no">NO</a>
    </div>
  </div>
</header>
```

```css
.site-header {
  position: sticky;
  top: 0;
  z-index: 100;
  background: #fafafabf;
  backdrop-filter: blur(8px);
  border-bottom: 1px solid var(--Light-500);
}
.site-header__inner {
  max-width: var(--max-width);
  margin: 0 auto;
  padding: 1rem 2rem;
  display: flex;
  align-items: center;
  gap: 2rem;
}
.site-header__nav {
  display: flex;
  gap: 1.5rem;
  margin-left: auto;
}
.site-header__nav a {
  color: var(--text-primary);
  text-decoration: none;
  font-weight: 450;
}
```

### Buttons

```html
<a class="btn btn--primary btn--xl">Learn more →</a>
<a class="btn btn--secondary">Read more</a>
```

```css
.btn {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  border-radius: var(--radius-l); /* pill shape */
  font-family: inherit;
  font-weight: 500;
  text-decoration: none;
  cursor: pointer;
  transition: 0.2s ease-in;
}
.btn--primary {
  background: var(--bg-dark);
  color: var(--text-light);
  border: none;
}
.btn--primary:hover {
  background: var(--Dark-700);
}
.btn--secondary {
  background: transparent;
  color: var(--text-primary);
  border: 1.5px solid currentColor;
}
.btn--xl {
  padding: 1rem 2rem;
  font-size: var(--text-label);
}
```

### Hero Section

```html
<section class="hero">
  <div class="hero__inner">
    <h1 class="hero__heading">We build products for the future</h1>
    <p class="hero__sub">
      Together we create digital services that people actually want to use.
    </p>
    <a class="btn btn--primary btn--xl" href="/about">Meet Variant →</a>
  </div>
</section>
```

```css
.hero {
  padding: var(--space-xxl) var(--space-l);
  text-align: center;
  background: var(--bg-light);
}
.hero__heading {
  font-size: var(--text-titleXL);
  font-weight: 700;
  line-height: 1.05;
  color: var(--text-primary);
  margin: 0 0 1rem;
}
.hero__sub {
  font-size: var(--text-lead);
  color: var(--text-secondary);
  max-width: 640px;
  margin: 0 auto 2rem;
}
```

### Split Section

```html
<section class="split-section">
  <div class="split-section__media">
    <img src="photo.jpg" alt="…" />
  </div>
  <div class="split-section__content">
    <h2>Strategy</h2>
    <p class="lead-text">We help teams understand what to build, and why.</p>
    <a class="btn btn--primary" href="/strategy">Read more →</a>
  </div>
</section>
```

```css
.split-section {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: var(--space-l);
  max-width: var(--max-width);
  margin: 0 auto;
  padding: var(--space-xl) var(--space-l);
  align-items: center;
}
.split-section__media img {
  width: 100%;
  border-radius: var(--radius-m);
}
.split-section__content h2 {
  font-size: var(--text-titleM);
  margin: 0 0 1rem;
}
.lead-text {
  font-size: var(--text-lead);
  color: var(--text-secondary);
  margin-bottom: 1.5rem;
}
@media (max-width: 834px) {
  .split-section {
    grid-template-columns: 1fr;
  }
}
```

### Pastel Accent Box

```html
<div class="accent-box accent-box--green">
  <p>
    【Openness】 We share everything — salaries, processes, and what we learn.
  </p>
</div>
```

```css
.accent-box {
  padding: var(--space-m) var(--space-l);
  border-radius: var(--radius-m);
  font-size: var(--text-lead);
}
.accent-box--green {
  background: #dafbdc;
  color: var(--text-primary);
}
.accent-box--blue {
  background: var(--bg-blue-subtle);
  color: var(--text-primary);
}
.accent-box--violet {
  background: var(--bg-violet-subtle);
  color: var(--text-primary);
}
.accent-box--yellow {
  background: var(--bg-yellow-subtle);
  color: var(--text-primary);
}
```

---

## Section Color Coding

Different Variant sections have their own accent colors. Use these consistently:

| Section          | Primary Color        | Subtle Background |
| ---------------- | -------------------- | ----------------- |
| People/Employees | `#059a0b` (green)    | `#dafbdc`         |
| Varianthuset     | `#002c00` (dk green) | —                 |
| Jobs             | `#7022d6` (violet)   | `#f0ebfe`         |
| Tech / AI        | `#3840ff` (blue)     | `#f2f3fd`         |
| Strategy         | white/light          | `#fafafa`         |

---

## Page Layout Example

For a complete page, use this structure:

1. Sticky header with logo + nav
2. Hero with large heading + CTA
3. Alternating split sections (image/text)
4. Pastel accent boxes for values/features
5. Employee or team grid (if relevant)
6. Contact CTA box
7. Dark footer with logo (white version) + links + locations

---

## Reference Files

- **`references/design-tokens.md`** — Complete color palette, full type scale, all spacing/radius/breakpoint tokens
- **`references/patterns.md`** — Visual patterns, component anatomy, accessibility notes, brand personality
- **`assets/logo-dark.svg`** — Variant wordmark for light backgrounds
- **`assets/logo-white.svg`** — Variant wordmark for dark backgrounds
