# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A collection of statistics/data-science exercises (in German) for students, published via [datenwerk.netlify.app](https://datenwerk.netlify.app). Each exercise lives in its own subfolder under `posts/`, with one `.qmd` or `.rmd` file per exercise.

## Exercise file structure

Every exercise file follows this pattern:

**YAML front matter** (R/exams-compatible fields):
- `extype`: `num` (numeric answer), `string` (free text), `schoice` (single choice), `mchoice` (multiple choice), `cloze`
- `exsolution`: the correct answer — a number for `num`, a binary string like `10000` or `00100` for `schoice`/`mchoice` (one `1` per correct option)
- `exshuffle`: whether to shuffle answer options (number = how many to show)
- `extol`: numeric tolerance for `num` answers
- `categories`: topic tags (also repeated at the bottom of the file body)
- `exname`, `slug`, `title`, `date`

**Body sections:**
1. Optional `knitr` options chunk
2. `## Aufgabe` (or `## Exercise`) — the question, optionally with embedded R code
3. Spacer `</br>` lines (visual separation between question and solution when rendered)
4. `## Lösung` (or `## Solution`) — worked solution with R code
5. For `schoice`/`mchoice`: an `Answerlist` block with bullet-point options in the question section, and a second `Answerlist` in the solution section labeling each option `Richtig`/`Falsch` (or `Wahr`/`*Falsch*` etc.)
6. `---` separator followed by `Categories:` list (duplicates front matter categories)

**Example of schoice/mchoice Answerlist structure:**

```
Answerlist
----------

* Option A text
* Option B text
* Option C text

## Lösung

Answerlist
----------
* Falsch
* Richtig
* Falsch
```

The `exsolution` binary string corresponds 1:1 to the order of options in the Answerlist (e.g. `010` means option B is correct).

## Folder layout

- `posts/` — one subfolder per exercise, named by exercise slug; contains the `.qmd` or `.rmd` file (sometimes also an `index.qmd`)
- `posts_buggy/` — 12 exercises with known issues, kept separate
- `liste_aufgaben_datenwerk.txt` — flat list of exercise file paths

## File format notes

- Both `.qmd` (Quarto) and `.rmd` (R Markdown) formats are used; treat them identically
- R code chunks use either `` ```{r} `` style or Quarto `#| option:` style for chunk options
- Some exercises use inline R (`` `r expr` ``) to embed computed values in text
- The `prada` package (github: sebastiansauer/prada) provides helpers like `bayesbox()`
