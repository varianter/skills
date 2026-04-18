# Variant Brand Patterns & Components

Visual and structural patterns extracted from variant.no.

## Brand Personality

- **Modern, approachable, human-centered** — generous whitespace, clear hierarchy
- **Playful details** — smiley illustrations, pastel accent boxes, emoji-like elements
- **Open & transparent** — the company openly shares salary, handbook, code
- **Editorial feel** — full-width image sections, large fluid typography, minimal chrome
- Use photography of real people and real office spaces
- Avoid generic stock imagery

## Logo Usage

Two SVG variants are bundled in `assets/`:

- `logo-dark.svg` — `fill="#333"`, use on light/white backgrounds
- `logo-white.svg` — `fill="white"`, use on dark/colored backgrounds

Both are 70×18px wordmark-only (no icon). Scale proportionally; minimum display width ~60px.

```html
<!-- On light background -->
<img src="logo-dark.svg" alt="Variant" width="70" height="18" />

<!-- On dark/colored background -->
<img src="logo-white.svg" alt="Variant" width="70" height="18" />
```

## Navigation

- Sticky header, white/light with slight transparency on scroll
- Logo left, nav links center or right, language toggle (EN/NO) far right
- Clean, minimal — no mega-menus

## Buttons

Variant uses two main button styles, sized in `xl`, `l`, `m`, `s`:

```css
/* Primary button — dark fill */
.btn-primary {
  background: var(--background-bg-dark); /* #2d2d2d */
  color: var(--text-primary-light);
  border-radius: var(--radius-large); /* 24px — pill shape */
  padding: 0.75rem 1.5rem;
  font-family: "fontBrittiSans", sans-serif;
  font-weight: 500;
  transition: 0.2s ease-in;
}

/* Secondary / outline button */
.btn-secondary {
  background: transparent;
  color: var(--text-primary);
  border: 1.5px solid var(--stroke-primary);
  border-radius: var(--radius-large);
  padding: 0.75rem 1.5rem;
}

/* With icon — arrow is common */
.btn-with-icon { display: flex; align-items: center; gap: 0.5rem; }
```

XL buttons use larger padding (~1rem 2rem) and slightly larger font.

## Section Layouts

### Hero
Full-width, centered content, large `titleXL` heading, subtitle in `lead` size, optional CTA button below. Often includes a background image or subtle gradient.

### Split Section (image + text)
Two-column layout: image one side, text the other. Alternates left/right across sections. Common on Services, Strategy, Varianthuset pages.

```html
<section class="split-section">
  <div class="split-section__image"><!-- image --></div>
  <div class="split-section__content">
    <h2><!-- titleM --></h2>
    <p><!-- lead --></p>
    <a class="btn-primary">Read more →</a>
  </div>
</section>
```

### Value/Feature Boxes
Colored accent boxes (pastel backgrounds from surface tokens) containing a short value statement. Often arranged in a 2–3 column grid. Background colors rotate through green-subtle, blue-subtle, violet-light.

### Employee Cards
Grid of cards: circular portrait photo, name, competency tags (Design / Development / Management), email and phone. Uses skeleton loading states.

### Logo Salad / Client Grid
Multi-column grid of client/partner logos, grayscale or lightly colored.

### Contact Box
Light-background CTA box with a contact person's photo, name, and email/phone. Often at the bottom of landing pages.

## Typography in Practice

- Headings: Britti Sans, weight 600–700, tight line-height (~1.1–1.2)
- Body: Britti Sans, weight 400, line-height 1.5–1.6
- Lead paragraphs: weight 400–450, slightly larger, line-height 1.4
- All sizes use `clamp()` for fluid scaling — never fixed px for type

## Pastel Accent Boxes

A distinctive brand pattern: soft-colored boxes used for highlighted content.

Common combinations:
- Light green `#dafbdc` background with dark text — openness/people sections  
- Blue-subtle `#f2f3fd` with dark text — tech/AI sections
- Violet-light `#f0ebfe` with dark text — learning sections
- Yellow-100 `#fdefbb` with dark text — callouts

## Dark Sections

Full-width dark sections (`#2d2d2d` or near-black `#222424`) with white text. Used for visual separation and drama. The footer often has dark background.

## Footer

Multi-column layout with:
- Main navigation links
- Social media icons (LinkedIn, Instagram, GitHub, YouTube, Podcast)
- Office locations: Trondheim, Oslo, Bergen, Stavanger
- Color-coded section widgets (each section has its own accent color)
- Company info / privacy policy links

## Accessibility

- All interactive elements have visible focus states
- Color contrast WCAG AA compliant
- Semantic HTML hierarchy (h1 → h5)
- Images always have descriptive `alt` text
- Language switcher (EN / NO) is visible in navigation
