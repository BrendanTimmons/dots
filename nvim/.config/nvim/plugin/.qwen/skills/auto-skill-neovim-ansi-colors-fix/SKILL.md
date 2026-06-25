---
name: neovim-ansi-colors-fix
description: Fix invalid "Bright*" highlight color names when termguicolors is disabled — maps them to valid base ANSI equivalents
source: auto-skill
extracted_at: '2026-06-23T11:41:55.700Z'
---

# Fixing Invalid "Bright*" Highlight Colors in Neovim (termguicolors = false)

## Problem

When `vim.opt.termguicolors` is set to `false`, Neovim only supports **8 base ANSI color names** for highlight groups:

> `Black`, `Red`, `Green`, `Yellow`, `Blue`, `Magenta`, `Cyan`, `White`

Any `"Bright*"` color name (e.g. `BrightRed`, `BrightBlack`, `BrightCyan`) will throw:

```
E5113: Lua chunk: ... Invalid highlight color: 'Bright...'
```

This also applies to `"BrightYellow"`, `"BrightBlue"`, etc. — they all fail under non-gui coloring.

## Mapping Table

| Invalid name | Valid replacement | Notes |
|---|---|---|
| `BrightBlack` | `DarkGrey` | This is the special one — Neovim calls ANSI slot 8 "DarkGrey", not "BrightBlack" |
| `BrightRed` | `Red` | Falls back to the base color |
| `BrightGreen` | `Green` | Falls back to the base color |
| `BrightYellow` | `Yellow` | Falls back to the base color |
| `BrightBlue` | `Blue` | Falls back to the base color |
| `BrightMagenta` | `Magenta` | Falls back to the base color |
| `BrightCyan` | `Cyan` | Falls back to the base color |

## How to Apply

1. Search for all occurrences of `"Bright` in the colorscheme/script file:
   ```
   grep -n '"Bright' colorscheme.lua
   ```
2. Replace each invalid name using the mapping table above. `"BrightBlack"` → `"DarkGrey"`; everything else drops the `Bright` prefix.
3. Use bulk replace (e.g. Neovim `:%s/` or sed) for safety.
4. Verify no stragglers remain: re-run the grep — it should return zero matches.

## Root Cause

The colors was likely copied from Vim script (`:hi` commands) or a terminal emulator config where `"BrightRed"` etc. are valid. Neovim's Lua `nvim_set_hl` API with `termguicolors = false` only accepts the 8 base names plus `DarkGrey` — not the X11-style "Bright" prefixes.

## Alternative Fix

Enable true-color support:
```lua
vim.opt.termguicolors = true
```
This unlocks full hex color support and changes how highlight groups resolve, but may break other assumptions in the config (e.g., forcing 256-color palette behavior).
