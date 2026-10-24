# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A collection of statistics/data-science exercises (in German) for students. Each exercise lives in its own subfolder under `posts/`, with one `.qmd` or `.rmd` file per exercise.

This repo is **not** the source of the blog [datenwerk.netlify.app](https://datenwerk.netlify.app). The blog lives in the separate repo `../07_datenwerk` (github: sebastiansauer/datenwerk) with its own copies of the exercises; the two have diverged. Changes here do not affect the blog.

## YAML header

Every exercise starts with a YAML header holding at least `title` and `categories`. `categories: null` marks an exercise whose categories still have to be added; if such an exercise also gets `paper`, the marker becomes the category `todo`. The category `paper` means the exercise can be solved with pen and paper only (no R, no calculator, no internet).

## schoice exercises: R/exams format

All `schoice` exercises in `posts/` are meant to be readable by the `exams` package (`exams2moodle()` etc.). They use:

- an optional YAML header for title, date, slug and categories, but **without** `ex*` fields
- `Question` / `Solution` headings underlined with `========` (exams does not recognise `## Aufgabe`, `## Lösung`, `## Exercise` or ATX headings)
- `Answerlist` blocks underlined with `----------`
- no `</br>` spacer lines between the question's Answerlist and `Solution` (exams would append them to the last option)
- a `Meta-information` block (underlined with `================`) holding `exname`, `extype`, `exsolution`, `exshuffle` — the only place for these fields; it sits before the `---` / `Categories:` footer

Every exercise names itself at the end of its solution with a line ``Aufgabenname: `<name>` ``. In R/exams files it must sit *before* the solution's `Answerlist`/`Solutionlist` (or the chunk calling `answerlist()`), since exams appends any text after the list to the last item; otherwise it goes right before `Meta-information`. In `## Lösung` files it goes before the `---` / `Categories:` footer.

`exsolution` must be a 0/1 string with exactly one `1` and as many digits as options, or inline R such as `` `r mchoice2string(x, single = TRUE)` ``. Beware: a YAML round trip turned values like `0100` into `64` (octal) or `00001` into `1`; that is why `ex*` fields no longer live in the YAML header.

Check an exercise with `exams::xexams(file, driver = list(sweave = list(quiet = TRUE), read = NULL))`.

## Exercise file structure (other types)

Non-schoice exercises still follow the older pattern:

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
- `liste_schoice_aufgaben.txt`, `liste_mchoice_aufgaben.txt` — exercises by `extype`
- `pruefung_schoice.tsv` — R/exams check report for the schoice exercises
- `import_rexams-entwicklung.tsv` — which exercises from `../11_rexams-entwicklung/exercises/sebastiansauer/de` were imported (and under which name) and which were skipped as duplicates
- `import_statistik1.tsv` — the same for `../01_statistik1/exs`
- `import_start-bayes.tsv` — the same for `../04_start-bayes/exr`
- `aufgaben_tabelle.tsv` — one row per exercise: name, path, extype, dynamic, buggy (+ reason), categories, `Statistik1` (best-fitting chapter of `../01_statistik1` as its qmd file name, or `keines`; taken from `../01_statistik1/quiz-aufgaben.csv` where available, otherwise assigned by content)

## File format notes

- Both `.qmd` (Quarto) and `.rmd` (R Markdown) formats are used; treat them identically
- R code chunks use either `` ```{r} `` style or Quarto `#| option:` style for chunk options
- Some exercises use inline R (`` `r expr` ``) to embed computed values in text
- The `prada` package (github: sebastiansauer/prada) provides helpers like `bayesbox()`
