# Light Mode Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Fix the `.theme-light` CSS block in `theme.css` so Obsidian's "Toggle light/dark mode" command produces a genuine light appearance (purple-tinted background, darkened accent colors, readable text).

**Architecture:** All changes are a single block replacement inside the existing `.theme-light {}` selector in `theme.css` (lines 1406–1509). The dark mode blocks are untouched. The fix works by: (1) correcting `color-scheme` from `dark` to `light`, (2) overriding the `--ap-color-dp*` depth variables with an inverted light scale using hue 249°, and (3) overriding accent/text/tag/scrollbar color variables with values that have sufficient contrast on a light background.

**Tech Stack:** Plain CSS. No build tool — `theme.css` is the compiled output that Obsidian loads directly. Edit the file in place.

---

### Task 1: Replace the `.theme-light {}` block with the corrected version

**Files:**
- Modify: `theme.css:1406-1509`

There are no automated tests for an Obsidian CSS theme — verification is visual and done in Task 2. This task makes the single edit.

- [ ] **Step 1: Open `theme.css` and locate the block**

  Confirm the block starts at line 1406 with `.theme-light {` and ends at line 1509 with `}`. The block currently has `color-scheme: dark` at line 1407 — this is the root cause of the bug.

- [ ] **Step 2: Replace the entire `.theme-light {}` block**

  Use the Edit tool. Replace the old block exactly as it appears (from `.theme-light {` through the closing `}`) with the corrected block below.

  **`old_string`** — the current broken block (lines 1406–1509):

  ```css
  .theme-light {
    color-scheme: dark;
    --highlight-mix-blend-mode: lighten;
    --mono-rgb-0: 0, 0, 0;
    --mono-rgb-100: 255, 255, 255,;
    --color-red-rgb: 251, 70, 76,;
    --color-red: #fb464c;
    --color-green-rgb: 68, 207, 110,;
    --color-green: #44cf6e;
    --color-orange: #e9973f;
    --color-yellow: #e0de71;
    --color-cyan: #53dfdd;
    --color-blue: #027aff;
    --color-purple: #a882ff;
    --color-pink: #fa99cd;
    --color-base-00: var(--ap-color-dp1);
    --color-base-10: var(--ap-color-dp2);
    --color-base-20: var(--ap-color-dp0);
    --color-base-25: var(--ap-color-dp0);
    --color-base-30: var(--ap-color-dp0);
    --color-base-35: var(--ap-color-dp4);
    --color-base-40: var(--ap-color-dp0);
    --color-base-50: var(--ap-color-dp6);
    --color-base-60: var(--ap-color-dp7);
    --color-base-70: var(--ap-color-dp10);
    --color-base-100: var(--ap-color-dp11);
    --color-accent-hsl: var(--accent-h), var(--accent-s), var(--accent-l);
    --color-accent: hsl(var(--accent-h), var(--accent-s), var(--accent-l));
    --color-accent-1: hsl(var(--accent-h), var(--accent-s), calc(var(--accent-l) - 3.8%));
    --color-accent-2: hsl(var(--accent-h), var(--accent-s), calc(var(--accent-l) + 3.8%));
    --background-modifier-form-field: var(--color-base-25);
    --background-secondary-alt: var(--color-base-30);
    --background-modifier-hover: hsla(var(--interactive-accent-hsl), 0.5);
    --interactive-normal: var(--color-base-30);
    --interactive-hover: var(--color-base-35);
    --background-modifier-box-shadow: rgba(0, 0, 0, 0.3);
    --background-modifier-cover: rgba(10, 10, 10, 0.4);
    --text-highlight-bg: rgba(255, 208, 0, 0.4);
    --text-highlight-bg-active: rgba(255, 128, 0, 0.4);
    --text-selection: hsla(var(--interactive-accent-hsl), 0.25);
    --input-shadow: inset 0 0.5px 0.5px 0.5px rgba(255, 255, 255, 0.09),0 2px 4px 0 rgba(0, 0, 0, 0.15), 0 1px 1.5px 0 rgba(0, 0, 0, 0.1),0 1px 2px 0 rgba(0, 0, 0, 0.2), 0 0 0 0 transparent;
    --input-shadow-hover: inset 0 0.5px 1px 0.5px rgba(255, 255, 255, 0.16),0 2px 3px 0 rgba(0, 0, 0, 0.3), 0 1px 1.5px 0 rgba(0, 0, 0, 0.2), 0 1px 2px 0 rgba(0, 0, 0, 0.4), 0 0 0 0 transparent;
    --shadow-s: 0px 1px 2px rgba(0, 0, 0, 0.121), 0px 3.4px 6.7px rgba(0, 0, 0, 0.179), 0px 15px 30px rgba(0, 0, 0, 0.3);
    --shadow-l: 0px 1.8px 7.3px rgba(0, 0, 0, 0.071), 0px 6.3px 24.7px rgba(0, 0, 0, 0.112), 0px 30px 90px rgba(0, 0, 0, 0.2);
    --tag-background: var(--ap-color-tag-background);
    --tag-color: var(--ap-color-tag-text);
    --icon-color-focused: var(--color-accent);
    --text-muted: hsl(var(--base-h), var(--base-s), calc(var(--base-d) + 65%));
    --text-faint: hsl(var(--base-h), var(--base-s), calc(var(--base-d) + 30%));
    --text-accent: hsl(var(--accent-h), var(--accent-s), var(--accent-d));
    --text-accent-hover: hsl(var(--accent-h), var(--accent-s), calc(var(--accent-d) + 12%));
    --h1-color: var(--ap-h1);
    --h2-color: var(--ap-h2);
    --h3-color: var(--ap-h3);
    --h4-color: var(--ap-h4);
    --h5-color: var(--ap-h5);
    --h6-color: var(--ap-h6);
    --strong-color: var(--ap-color-strong);
    --em-color: var(--ap-color-italic);
    --quote-color: var(--ap-color-quote);
    --tag-background-color-l: #bde1d3;
    --tag-font-color-l: #1d694b;
    --tag-background-color-d: #b3e1bd;
    --tag-font-color-d: #ffffff;
    --font-text-theme: var(--ap-font-text);
    --font-editor-theme: var(--ap-font-text);
    --font-monospace-theme: var(--ap-font-monospace);
    --font-interface-theme: var(--ap-font-interface);
    --checkbox-radius: 30%;
    --link-external-decoration: underline;
    --link-decoration: underline;
    --scrollbar-bg: hsla(var(--base-h), var(--base-s), calc(var(--base-l) + 15%), 1);
    --scrollbar-thumb-bg: hsla(var(--base-h), var(--base-s), calc(var(--base-l) + 15%), 1);
    --scrollbar-active-thumb-bg: hsla(var(--accent-h), var(--accent-s), var(--accent-l), 0.4);
    --base-h: var(--ap-base0-h);
    --base-s: var(--ap-base0-s);
    --base-l: var(--ap-base0-l);
    --base-d: var(--ap-base0-d);
    --accent-h: var(--ap-primary-h);
    --accent-s: var(--ap-primary-s);
    --accent-l: var(--ap-primary-l);
    --accent-d: var(--ap-primary-d);
    --blue: #2e80f2;
    --pink: #ff82b2;
    --green: #3eb4bf;
    --yellow: #e5b567;
    --orange: #e87d3e;
    --red: #e83e3e;
    --purple: #9e86c8;
    --tab-divider-color: var(--color-base-10);
    --tab-text-color: var(--color-base-70);
    --radius-s: var(--ap-radius-s);
    --radius-m: var(--ap-radius-m);
    --radius-l: var(--ap-radius-l);
    --radius-xl: var(--ap-radius-xl);
    --graph-controls-width: 240px;
    --graph-text: var(--text-normal);
    --graph-line: var(--color-base-35, var(--background-modifier-border-focus));
    --graph-node: var(--text-muted);
    --graph-node-unresolved: var(--text-faint);
    --graph-node-focused: var(--text-accent);
    --graph-node-tag: var(--ap-secondary);
    --graph-node-attachment: var(--color-yellow);
  }
  ```

  **`new_string`** — the corrected block:

  ```css
  .theme-light {
    /* Light palette: inverted depth scale, purple-tint hue 249° */
    --ap-color-dp0: hsl(249, 20%, 97%);
    --ap-color-dp1: hsl(249, 20%, 93%);
    --ap-color-dp2: hsl(249, 20%, 89%);
    --ap-color-dp3: hsl(249, 18%, 85%);
    --ap-color-dp4: hsl(249, 18%, 80%);
    --ap-color-dp5: hsl(249, 15%, 65%);
    --ap-color-dp6: hsl(249, 12%, 52%);
    --ap-color-dp7: hsl(249, 12%, 40%);
    --ap-color-dp8: hsl(249, 12%, 28%);
    --ap-color-dp9: hsl(249, 12%, 20%);
    --ap-color-dp10: hsl(249, 15%, 12%);
    --ap-color-dp11: hsl(249, 18%, 8%);
    /* Accent colors darkened to ~38% lightness for contrast on light bg */
    --ap-red: hsl(342, 55%, 38%);
    --ap-green: hsl(108, 22%, 36%);
    --ap-blue: hsl(210, 45%, 35%);
    --ap-purple: hsl(294, 35%, 38%);
    --ap-aqua: hsl(181, 40%, 35%);
    --ap-yellow: hsl(46, 50%, 35%);
    --ap-orange: hsl(12, 45%, 40%);
    /* These are hardcoded in :root (not var refs), so must be overridden here */
    --ap-color-strong: hsl(342, 55%, 38%);
    --ap-color-quote: hsl(342, 55%, 38%);
    --ap-color-italic: hsl(342, 55%, 38%);
    /* Tag colors for light bg */
    --ap-color-tag-background: hsl(249, 30%, 83%);
    --ap-color-tag-text: hsl(249, 30%, 22%);
    color-scheme: light;
    --highlight-mix-blend-mode: multiply;
    --mono-rgb-0: 255, 255, 255;
    --mono-rgb-100: 0, 0, 0;
    --color-red-rgb: 251, 70, 76,;
    --color-red: #fb464c;
    --color-green-rgb: 68, 207, 110,;
    --color-green: #44cf6e;
    --color-orange: #e9973f;
    --color-yellow: #e0de71;
    --color-cyan: #53dfdd;
    --color-blue: #027aff;
    --color-purple: #a882ff;
    --color-pink: #fa99cd;
    --color-base-00: var(--ap-color-dp1);
    --color-base-10: var(--ap-color-dp2);
    --color-base-20: var(--ap-color-dp0);
    --color-base-25: var(--ap-color-dp0);
    --color-base-30: var(--ap-color-dp0);
    --color-base-35: var(--ap-color-dp4);
    --color-base-40: var(--ap-color-dp0);
    --color-base-50: var(--ap-color-dp6);
    --color-base-60: var(--ap-color-dp7);
    --color-base-70: var(--ap-color-dp10);
    --color-base-100: var(--ap-color-dp11);
    --color-accent-hsl: var(--accent-h), var(--accent-s), var(--accent-l);
    --color-accent: hsl(var(--accent-h), var(--accent-s), var(--accent-l));
    --color-accent-1: hsl(var(--accent-h), var(--accent-s), calc(var(--accent-l) - 3.8%));
    --color-accent-2: hsl(var(--accent-h), var(--accent-s), calc(var(--accent-l) + 3.8%));
    --background-modifier-form-field: var(--color-base-25);
    --background-secondary-alt: var(--color-base-30);
    --background-modifier-hover: hsla(var(--interactive-accent-hsl), 0.5);
    --interactive-normal: var(--color-base-30);
    --interactive-hover: var(--color-base-35);
    --background-modifier-box-shadow: rgba(0, 0, 0, 0.3);
    --background-modifier-cover: rgba(10, 10, 10, 0.4);
    --text-highlight-bg: rgba(255, 208, 0, 0.4);
    --text-highlight-bg-active: rgba(255, 128, 0, 0.4);
    --text-selection: hsla(var(--interactive-accent-hsl), 0.25);
    --input-shadow: inset 0 0.5px 0.5px 0.5px rgba(255, 255, 255, 0.09),0 2px 4px 0 rgba(0, 0, 0, 0.15), 0 1px 1.5px 0 rgba(0, 0, 0, 0.1),0 1px 2px 0 rgba(0, 0, 0, 0.2), 0 0 0 0 transparent;
    --input-shadow-hover: inset 0 0.5px 1px 0.5px rgba(255, 255, 255, 0.16),0 2px 3px 0 rgba(0, 0, 0, 0.3), 0 1px 1.5px 0 rgba(0, 0, 0, 0.2), 0 1px 2px 0 rgba(0, 0, 0, 0.4), 0 0 0 0 transparent;
    --shadow-s: 0px 1px 2px rgba(0, 0, 0, 0.121), 0px 3.4px 6.7px rgba(0, 0, 0, 0.179), 0px 15px 30px rgba(0, 0, 0, 0.3);
    --shadow-l: 0px 1.8px 7.3px rgba(0, 0, 0, 0.071), 0px 6.3px 24.7px rgba(0, 0, 0, 0.112), 0px 30px 90px rgba(0, 0, 0, 0.2);
    --tag-background: var(--ap-color-tag-background);
    --tag-color: var(--ap-color-tag-text);
    --icon-color-focused: var(--color-accent);
    --text-normal: hsl(249, 20%, 10%);
    --text-muted: hsl(249, 15%, 40%);
    --text-faint: hsl(249, 12%, 60%);
    --text-accent: hsl(var(--accent-h), var(--accent-s), var(--accent-d));
    --text-accent-hover: hsl(var(--accent-h), var(--accent-s), calc(var(--accent-d) + 12%));
    --h1-color: var(--ap-h1);
    --h2-color: var(--ap-h2);
    --h3-color: var(--ap-h3);
    --h4-color: var(--ap-h4);
    --h5-color: var(--ap-h5);
    --h6-color: var(--ap-h6);
    --strong-color: var(--ap-color-strong);
    --em-color: var(--ap-color-italic);
    --quote-color: var(--ap-color-quote);
    --tag-background-color-l: #bde1d3;
    --tag-font-color-l: #1d694b;
    --tag-background-color-d: #b3e1bd;
    --tag-font-color-d: #ffffff;
    --font-text-theme: var(--ap-font-text);
    --font-editor-theme: var(--ap-font-text);
    --font-monospace-theme: var(--ap-font-monospace);
    --font-interface-theme: var(--ap-font-interface);
    --checkbox-radius: 30%;
    --link-external-decoration: underline;
    --link-decoration: underline;
    --scrollbar-bg: hsl(249, 20%, 89%);
    --scrollbar-thumb-bg: hsl(249, 15%, 76%);
    --scrollbar-active-thumb-bg: hsla(var(--accent-h), var(--accent-s), var(--accent-l), 0.4);
    --base-h: var(--ap-base0-h);
    --base-s: var(--ap-base0-s);
    --base-l: var(--ap-base0-l);
    --base-d: var(--ap-base0-d);
    --accent-h: var(--ap-primary-h);
    --accent-s: var(--ap-primary-s);
    --accent-l: var(--ap-primary-l);
    --accent-d: var(--ap-primary-d);
    --blue: #2e80f2;
    --pink: #ff82b2;
    --green: #3eb4bf;
    --yellow: #e5b567;
    --orange: #e87d3e;
    --red: #e83e3e;
    --purple: #9e86c8;
    --tab-divider-color: var(--color-base-10);
    --tab-text-color: var(--color-base-70);
    --radius-s: var(--ap-radius-s);
    --radius-m: var(--ap-radius-m);
    --radius-l: var(--ap-radius-l);
    --radius-xl: var(--ap-radius-xl);
    --graph-controls-width: 240px;
    --graph-text: var(--text-normal);
    --graph-line: var(--color-base-35, var(--background-modifier-border-focus));
    --graph-node: var(--text-muted);
    --graph-node-unresolved: var(--text-faint);
    --graph-node-focused: var(--text-accent);
    --graph-node-tag: var(--ap-secondary);
    --graph-node-attachment: var(--color-yellow);
  }
  ```

- [ ] **Step 3: Verify the edit landed correctly**

  Run:
  ```bash
  grep -n "color-scheme" theme.css
  ```
  Expected output — the `.theme-light` entry must say `light`, the `.theme-dark` entry must say `dark`:
  ```
  1299:  color-scheme: dark;
  1407:  color-scheme: light;
  ```
  (Line numbers may shift slightly after the edit due to the added lines — what matters is that `theme-light` block has `light` and `theme-dark` block has `dark`.)

- [ ] **Step 4: Commit**

  ```bash
  git add theme.css
  git commit -m "feat: implement light mode for default Apatheia theme

  Fix .theme-light block: correct color-scheme to light, invert dp scale
  to purple-tint backgrounds (hsl 249°), darken accent colors to ~38%
  lightness, and add explicit text/tag/scrollbar color overrides."
  ```

---

### Task 2: Visual verification in Obsidian

**Files:** None — read-only verification

Obsidian hot-reloads community theme files when they change on disk. If Obsidian is open with the Apatheia theme active, the changes are already live.

- [ ] **Step 1: Load the theme in Obsidian**

  In Obsidian: Settings → Appearance → Themes → select "Apatheia" if not already active.

- [ ] **Step 2: Toggle to light mode**

  Run the command palette command "Toggle light/dark mode" (or Settings → Appearance → Base color scheme → Light).

  **Expected:** The UI switches to a light purple-tinted background. The main workspace should be near-white (~hsl(249,20%,97%)), the sidebar slightly darker (~hsl(249,20%,89%)).

  **Fail condition:** If the background is still dark, the edit did not land. Re-check Step 3 of Task 1.

- [ ] **Step 3: Check headings**

  Open or create a note with H1–H6 headings:
  ```markdown
  # H1 Heading
  ## H2 Heading
  ### H3 Heading
  #### H4 Heading
  ##### H5 Heading
  ###### H6 Heading
  ```
  **Expected:** Each heading is a distinct, clearly visible color (deep rose, deep purple, deep blue, deep green, deep orange, deep gold). None should be washed out or invisible against the background.

- [ ] **Step 4: Check body text contrast**

  **Expected:** Body text is very dark (~hsl(249,20%,10%)) and highly legible. Muted text (file tree, metadata) is mid-dark (~40% lightness). Faint text is a medium gray (~60% lightness).

- [ ] **Step 5: Check tags**

  **Expected:** Tags render with a soft purple-tinted background (~hsl(249,30%,83%)) and dark text (~hsl(249,30%,22%)). They should not be invisible or high-contrast jarring.

- [ ] **Step 6: Check code blocks**

  **Expected:** Inline code and fenced code blocks are readable — dark text on a slightly off-white background. No invisible text.

- [ ] **Step 7: Toggle back to dark mode**

  Run "Toggle light/dark mode" again.

  **Expected:** Dark mode returns to its original deep blue-purple appearance, identical to before this change. If dark mode looks different, something was accidentally changed outside the `.theme-light` block — revert and re-apply Task 1.

- [ ] **Step 8: Commit verification result**

  If all checks pass:
  ```bash
  git add -p  # (no changes expected — this is a read-only verification step)
  # No commit needed; verification is done.
  ```
