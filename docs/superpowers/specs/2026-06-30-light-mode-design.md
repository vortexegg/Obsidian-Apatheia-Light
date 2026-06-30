# Light Mode Design — Apatheia Theme

**Date:** 2026-06-30
**Status:** Approved
**Scope:** Default Apatheia light mode only (no variant light modes)

---

## Problem

When the user runs Obsidian's "Toggle light/dark mode" command, the theme does not switch to a light appearance. The `.theme-light {}` block in `theme.css` exists but is broken: it declares `color-scheme: dark` and references the same dark depth variables as `.theme-dark`, producing an identical dark appearance in both modes.

---

## Approach

Fix the existing `.theme-light {}` block in place (lines 1406–1509 of `theme.css`). All edits are contained within that single block. No other selectors are touched. Dark mode is unaffected.

---

## Design Decisions

### Background palette: Purple Tint

The light mode uses the same hue as the dark mode (249°) but at high lightness — a very subtle purple-tinted white. This makes the light mode feel like a true sibling of the dark mode rather than a generic light theme.

- Editor (dp0): `hsl(249, 20%, 97%)`
- Main background (dp1): `hsl(249, 20%, 93%)`

### Heading colors: Same hues, darkened to ~38% lightness

All six heading color families are preserved (red, purple, blue, green, orange, gold) but shifted from their dark-mode pastel values (which sit at 68–80% lightness) to approximately 38% lightness, ensuring legibility on the light background.

### Scope: Default light only

No light variants for the existing dark variant selectors (`.theme-dark.a-theme-purple`, `.theme-dark.a-catpuccin-mocha`, etc.). Only the base `.theme-light {}` block is modified.

---

## Variable Changes

All changes are overrides inside `.theme-light {}`.

### Color scheme and blend mode

| Variable | Old value | New value |
|---|---|---|
| `color-scheme` | `dark` | `light` |
| `--highlight-mix-blend-mode` | `lighten` | `multiply` |
| `--mono-rgb-0` | `0, 0, 0` | `255, 255, 255` |
| `--mono-rgb-100` | `255, 255, 255` | `0, 0, 0` |

### Depth scale (`--ap-color-dp*`)

Overrides the dark `:root` values with an inverted light scale. All use hue 249°.

| Variable | Lightness | Role |
|---|---|---|
| `--ap-color-dp0` | 97% | Editor / note background |
| `--ap-color-dp1` | 93% | Main background |
| `--ap-color-dp2` | 89% | Sidebar, secondary panels |
| `--ap-color-dp3` | 85% | Hover states, borders |
| `--ap-color-dp4` | 80% | Active/selected items |
| `--ap-color-dp5` | 65% | Mid-range UI elements |
| `--ap-color-dp6` | 52% | Subdued text, icons |
| `--ap-color-dp7` | 40% | Muted text |
| `--ap-color-dp8` | 28% | Secondary text |
| `--ap-color-dp9` | 20% | Emphasis text |
| `--ap-color-dp10` | 12% | Strong text |
| `--ap-color-dp11` | 8% | Primary text / headings base |

dp0–dp4 use saturation 20%; dp5–dp7 use 15%; dp8–dp11 use 12–18%.

### Accent colors

| Variable | Dark value | Light value |
|---|---|---|
| `--ap-red` | `#E97193` | `hsl(342, 55%, 38%)` |
| `--ap-green` | `#AAC5A0` | `hsl(108, 22%, 36%)` |
| `--ap-blue` | `#A8C5E6` | `hsl(210, 45%, 35%)` |
| `--ap-purple` | `#DFA7E7` | `hsl(294, 35%, 38%)` |
| `--ap-aqua` | `#a8e5e6` | `hsl(181, 40%, 35%)` |
| `--ap-yellow` | `#ece0a8` | `hsl(46, 50%, 35%)` |
| `--ap-orange` | `#D1A999` | `hsl(12, 45%, 40%)` |

`--ap-color-strong`, `--ap-color-quote`, `--ap-color-italic` all reference `--ap-red` and update automatically.

### Text colors

Explicitly set to ensure contrast on light backgrounds (the existing calc formulas assume a dark base):

| Variable | Value |
|---|---|
| `--text-normal` | `hsl(249, 20%, 10%)` |
| `--text-muted` | `hsl(249, 15%, 40%)` |
| `--text-faint` | `hsl(249, 12%, 60%)` |

### Tag colors

| Variable | Value |
|---|---|
| `--ap-color-tag-background` | `hsl(249, 30%, 83%)` |
| `--ap-color-tag-text` | `hsl(249, 30%, 22%)` |

### Scrollbar colors

Override the dark base-variable-computed values:

| Variable | Value |
|---|---|
| `--scrollbar-bg` | `hsl(249, 20%, 89%)` |
| `--scrollbar-thumb-bg` | `hsl(249, 15%, 76%)` |

### No change needed

- **Shadows** (`--shadow-s`, `--shadow-l`, `--input-shadow*`, `--background-modifier-box-shadow`): dark `rgba(0,0,0,…)` shadows are correct and expected on light UIs.
- **Code block grays** (`--ap-code-gray-1: #5b5c5f`, `--ap-code-gray-2: #45474c`): mid-dark grays have good contrast on light backgrounds.
- **Highlight bg** (`rgba(255,208,0,0.4)`): yellow highlight works on light backgrounds.
- **`--background-modifier-cover`** (`rgba(10,10,10,0.4)`): modal overlay, correct as-is.
- **All font variables, radii, graph colors, checkbox radius, link decoration**: already wired to the variables being changed and will update automatically.

---

## Files Changed

| File | Change |
|---|---|
| `theme.css` | Edit `.theme-light {}` block only (~40 variable overrides) |

---

## Verification

After implementation:
1. Load the theme in Obsidian
2. Run "Toggle light/dark mode" — the UI should switch to a light purple-tinted background
3. Check headings H1–H6 are legible (colored, not washed out)
4. Check body text, muted text, and faint text all have sufficient contrast
5. Check tags render with light purple background and dark text
6. Check code blocks are readable
7. Toggle back to dark — verify dark mode is unchanged
