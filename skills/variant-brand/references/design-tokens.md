# Variant Design Tokens

Extracted from the live variant.no CSS (April 2026). These are the authoritative tokens from the production codebase.

## Font

**Family:** `Britti Sans` — a custom variable font (weights 100–900, supports italic)
- CSS declaration: `font-family: "fontBrittiSans", "fontBrittiSans Fallback", Arial, sans-serif`
- The font is a variable font — use numeric weights (300, 400, 450, 500, 600, 700)
- Fallback metrics: ascent-override 87.90%, descent-override 21.97%, size-adjust 91.01%
- Web fallback stack: `system-ui, "Segoe UI", Roboto, Helvetica, Arial, sans-serif`

**Root size:** `clamp(1rem, .9rem + .5vw, 1.2rem)` (~16px–19.2px fluid)

## Type Scale

| Name       | CSS value                                  | Use                  |
|------------|--------------------------------------------|----------------------|
| titleXL    | `clamp(2.5rem, 6vw + 1rem, 4.5rem)`        | Hero headings        |
| titleL     | `clamp(2rem, 4vw + 1rem, 3.5rem)`          | Section headings     |
| titleM     | `clamp(1.5rem, 3vw + .5rem, 2rem)`         | Sub-section headings |
| titleS     | `1.5rem`                                   | Card headings        |
| titleXS    | `1.25rem`                                  | Small headings       |
| subtitle   | `clamp(2rem, 3vw + 1rem, 2.5rem)`          | Hero subtitles       |
| lead       | `clamp(1.125rem, 1.75vw + .5rem, 1.5rem)`  | Lead paragraphs      |
| normal     | `clamp(.875rem, 2vw + .35rem, 1.125rem)`   | Body text            |
| description| `clamp(.875rem, 2vw + .35rem, 1rem)`       | Captions, meta       |
| labelL     | `clamp(1.125rem, 2vw + .5rem, 1.25rem)`    | Large labels         |
| bodyXS     | `clamp(.75rem, 1vw + .5rem, .875rem)`      | Fine print           |

Line heights: 1.1–1.6 (tighter on headings, 1.5–1.6 on body).

## Color Palette — Primitives

### Blue
| Token        | Hex       |
|--------------|-----------|
| `--Blue-50`  | `#f2f3fd` |
| `--Blue-200` | `#bee0ff` |
| `--Blue-300` | `#c3c8f6` |
| `--Blue-400` | `#788aea` |
| `--Blue-500` | `#3840ff` |
| `--Blue-700` | `#0014cd` |

### Green
| Token         | Hex       |
|---------------|-----------|
| `--Green-50`  | `#e6f5e7` |
| `--Green-100` | `#b2e0b3` |
| `--Green-200` | `#8cd18f` |
| `--Green-300` | `#58bb5c` |
| `--Green-400` | `#37ae3c` |
| `--Green-500` | `#059a0b` |
| `--Green-600` | `#058c0a` |
| `--Green-700` | `#046d08` |
| `--Green-800` | `#035506` |
| `--Green-900` | `#024105` |

### Red
| Token        | Hex       |
|--------------|-----------|
| `--Red-50`   | `#fdedec` |
| `--Red-100`  | `#fabbb4` |
| `--Red-300`  | `#f3948f` |
| `--Red-500`  | `#f0503f` |
| `--Red-600`  | `#b63729` |
| `--Red-700`  | `#7c2318` |
| `--Red-900`  | `#46100a` |

### Yellow
| Token          | Hex       |
|----------------|-----------|
| `--Yellow-50`  | `#fffbf6` |
| `--Yellow-100` | `#fdefbb` |
| `--Yellow-300` | `#fbe186` |
| `--Yellow-400` | `#ffd02f` |
| `--Yellow-500` | `#edad08` |
| `--Yellow-600` | `#bd8905` |
| `--Yellow-700` | `#8e6703` |
| `--Yellow-800` | `#634601` |
| `--Yellow-900` | `#3b2800` |

### Violet
| Token          | Hex       |
|----------------|-----------|
| `--Violet-50`  | `#f0ebfe` |
| `--Violet-200` | `#e8c8f0` |
| `--Violet-300` | `#cdbdfa` |
| `--Violet-400` | `#ac8df7` |
| `--Violet-500` | `#a160f6` |
| `--Violet-700` | `#7022d6` |
| `--Violet-800` | `#47128c` |
| `--Violet-900` | `#220548` |

### Light (near-white scale)
| Token          | Hex       |
|----------------|-----------|
| `--Light-50`   | `#fefefe` |
| `--Light-100`  | `#fafafa` |
| `--Light-200`  | `#f9f9f9` |
| `--Light-300`  | `#f6f6f6` |
| `--Light-400`  | `#f5f5f5` |
| `--Light-500`  | `#eaeaea` |
| `--Light-600`  | `#dcdcdc` |
| `--Light-700`  | `#acacac` |
| `--Light-800`  | `#858585` |
| `--Light-900`  | `#666666` |

### Dark (near-black scale)
| Token         | Hex       |
|---------------|-----------|
| `--Dark-50`   | `#e7e7e7` |
| `--Dark-100`  | `#b4b5b5` |
| `--Dark-200`  | `#909191` |
| `--Dark-300`  | `#5e5e5e` |
| `--Dark-400`  | `#3e3f3f` |
| `--Dark-500`  | `#2d2d2d` |
| `--Dark-600`  | `#222424` |
| `--Dark-700`  | `#0a0b0b` |
| `--Dark-800`  | `#080808` |
| `--Dark-900`  | `#060606` |

## Semantic Color Tokens

### Text
| Token                     | Value              |
|---------------------------|--------------------|
| `--text-primary`          | `#222424`          |
| `--text-secondary`        | `#3e3f3f`          |
| `--text-tertiary`         | `#5e5e5e`          |
| `--text-primary-light`    | `#fafafa`          |
| `--text-secondary-light`  | `#f6f6f6`          |
| `--text-placeholder`      | `#909191`          |
| `--text-disabled`         | `#909191`          |
| `--text-link`             | `#3840ff`          |
| `--text-warning`          | `#edad08`          |
| `--text-error`            | `#f0503f`          |
| `--text-success`          | `#059a0b`          |

### Background
| Token                              | Value       |
|------------------------------------|-------------|
| `--background-bg-dark`             | `#2d2d2d`   |
| `--background-bg-light-primary`    | `#fafafa`   |
| `--background-bg-light-secondary`  | `#eaeaea`   |
| `--background-bg-green`            | `#059a0b`   |
| `--background-bg-red`              | `#f0503f`   |
| `--background-bg-blue`             | `#3840ff`   |
| `--background-bg-yellow`           | `#edad08`   |
| `--background-employees-green`     | `#dafbdc`   |
| `--background-header-transparent`  | `#fafafabf` |

### Surface (for content blocks/cards)
| Token                        | Value       |
|------------------------------|-------------|
| `--surface-yellow`           | `#ffd02f`   |
| `--surface-red`              | `#f0503f`   |
| `--surface-blue`             | `#3840ff`   |
| `--surface-green`            | `#37ae3c`   |
| `--surface-green-light`      | `#b2e0b3`   |
| `--surface-green-subtle`     | `#e6f5e7`   |
| `--surface-blue-light`       | `#bee0ff`   |
| `--surface-blue-subtle`      | `#f2f3fd`   |
| `--surface-red-light`        | `#fabbb4`   |
| `--surface-yellow-light`     | `#fffbf6`   |
| `--surface-white`            | `#fefefe`   |
| `--surface-violet-light`     | `#f0ebfe`   |
| `--surface-violet-accent`    | `#e8c8f0`   |
| `--surface-violet-vivid`     | `#7022d6`   |

## Section Color Coding

Variant uses distinct accent colors for specific site sections:
- **Employees / People:** `#059a0b` (Green-500), subtle bg: `#dafbdc`
- **Varianthuset:** `#002c00` (very dark green)
- **Jobs:** `#7022d6` (Violet-700)
- **Strategy:** white / light backgrounds
- **Generative AI / Tech:** blue tones

## Spacing Scale

| Token           | Value    |
|-----------------|----------|
| `--padding-xs`  | `0.25rem`|
| `--padding-s`   | `0.75rem`|
| `--padding-rem` | `1rem`   |
| `--padding-m`   | `1.5rem` |
| `--padding-l`   | `3rem`   |
| `--padding-xl`  | `6rem`   |
| `--padding-xxl` | `9rem`   |

## Border Radius

| Token             | Value  |
|-------------------|--------|
| `--radius-small`  | `6px`  |
| `--radius-medium` | `12px` |
| `--radius-large`  | `24px` |

## Breakpoints & Layout

| Token                        | Value    |
|------------------------------|----------|
| `--breakpoint-mobile`        | `425px`  |
| `--breakpoint-tablet`        | `834px`  |
| `--breakpoint-large`         | `1024px` |
| `--max-content-width-large`  | `1408px` |
| `--max-content-width-medium` | `1091px` |
| `--max-content-width-small`  | `869px`  |

## Transitions

| Speed    | Value                              |
|----------|------------------------------------|
| Fast     | `0.15s ease-in`                    |
| Standard | `0.2s ease-in`                     |
| Normal   | `0.3s ease`                        |
| Smooth   | `0.5s cubic-bezier(0.4, 0, 0.2, 1)`|
