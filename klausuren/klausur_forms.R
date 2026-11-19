# Rendert eine Klausurliste (klausuren/*.txt) als interaktives Quiz im
# exams2forms-Format, so wie die Probeklausuren in den Büchern erscheinen:
# Antwort auswählen, prüfen lassen, Lösung aufklappen.
#
# Aufruf aus einem beliebigen Ordner, z. B.:
#   Rscript klausuren/klausur_forms.R klausuren/probeklausur-start-bayes-2026.txt
#   Rscript klausuren/klausur_forms.R probeklausur-start-bayes-2026 --open
# (die Liste wird relativ zum aktuellen Ordner oder in klausuren/ gesucht,
# die Endung .txt ist optional)
#
# Ergebnis: klausuren/html/<liste>-forms.html, eine einzige Datei
# (HTML-Dateien sind in .gitignore).
#
# Die Antwortoptionen werden wie in der Klausur gemischt (exshuffle); die
# Zufallsziehung ist über set.seed(1) reproduzierbar. Zwischenüberschriften
# kommen aus den Abschnittskommentaren der Liste. Eine Aufgabe, die nicht
# rendert, erscheint als Fehlermeldung; das Skript bricht dann nicht ab.
# Jede Aufgabe wird per edir aus ihrem eigenen Ordner geladen, damit
# exams2forms die Bilder findet und einbettet.
# Für eine Prüfansicht mit markierter richtiger Option s. klausur_html.R.

args <- commandArgs(trailingOnly = TRUE)
oeffnen <- "--open" %in% args
args <- setdiff(args, "--open")
if (length(args) != 1) {
  stop("Aufruf: Rscript klausuren/klausur_forms.R <klausurliste.txt> [--open]",
       call. = FALSE)
}

# Repo-Wurzel aus dem Ort dieses Skripts (klausuren/ liegt darin)
skript <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
repo <- if (length(skript) == 1) dirname(dirname(normalizePath(skript))) else getwd()
source(file.path(repo, "klausuren", "klausur_aufgaben.R"))

liste <- klausur_finden(args[1], repo)
setwd(repo)  # Aufgabenpfade in der Liste sind relativ zur Repo-Wurzel
invisible(klausur_aufgaben(liste))  # prüft fehlende/doppelte/buggy Aufgaben

struktur <- klausur_struktur(liste)
struktur$info$pfad_abs <- normalizePath(struktur$info$pfad)
titel <- sub("\\.txt$", "", basename(liste))

# --- Rmd-Dokument im Temp-Ordner bauen und rendern -------------------------

bau <- tempfile("klausur_forms_")
dir.create(bau)
saveRDS(struktur, file.path(bau, "struktur.rds"))

rmd <- c(
  "---",
  sprintf('title: "%s"', titel),
  "lang: de",
  "---",
  "",
  "```{r setup, include = FALSE}",
  "library(exams2forms)",
  sprintf("struktur <- readRDS('%s')", file.path(bau, "struktur.rds")),
  "info <- struktur$info",
  "set.seed(1)",
  "```",
  "",
  sprintf("%d Aufgaben &middot; erstellt %s", nrow(struktur$info),
          format(Sys.time(), "%Y-%m-%d %H:%M")),
  "",
  if (length(struktur$kopf)) c("```", struktur$kopf, "```", "") else "",
  "```{r quiz, echo = FALSE, message = FALSE, warning = FALSE, results = 'asis'}",
  "abschnitt <- ''",
  "for (i in seq_len(nrow(info))) {",
  "  if (info$abschnitt[i] != '' && info$abschnitt[i] != abschnitt) {",
  "    abschnitt <- info$abschnitt[i]",
  "    cat('\\n\\n## ', abschnitt, '\\n\\n', sep = '')",
  "  }",
  "  cat('\\n\\n### Aufgabe ', i, '\\n\\n', sep = '')",
  "  ok <- tryCatch({",
  "    # edir: Bilder werden gefunden; findet aber z. B. keine .qmd-Dateien,",
  "    # dann Rückfall auf den absoluten Pfad",
  "    out <- tryCatch(",
  "      capture.output(exams2forms(basename(info$pfad_abs[i]), n = 1L, base64 = TRUE,",
  "                                 edir = dirname(info$pfad_abs[i]))),",
  "      error = function(e) capture.output(exams2forms(info$pfad_abs[i], n = 1L, base64 = TRUE)))",
  "    cat(out, sep = '\\n')",
  "    TRUE",
  "  }, error = function(e) {",
  "    cat('\\n\\n**Fehler beim Rendern von `', info$pfad[i], '`:** ',",
  "        conditionMessage(e), '\\n\\n', sep = '')",
  "    FALSE",
  "  })",
  "  if (!ok) message('FEHLER: ', info$pfad[i])",
  "}",
  "```"
)
writeLines(rmd, file.path(bau, "quiz.Rmd"), useBytes = TRUE)

dir.create(file.path(repo, "klausuren", "html"), showWarnings = FALSE)
ziel <- file.path(repo, "klausuren", "html", paste0(titel, "-forms.html"))

rmarkdown::render(
  file.path(bau, "quiz.Rmd"),
  output_format = exams2forms::webquiz(toc = TRUE, toc_depth = 2),
  output_file = basename(ziel),
  output_dir = dirname(ziel),
  intermediates_dir = bau,
  knit_root_dir = bau,
  quiet = TRUE
)
unlink(bau, recursive = TRUE)

message("\nGeschrieben: ", normalizePath(ziel), "  (", nrow(struktur$info),
        " Aufgaben)")
if (oeffnen) utils::browseURL(normalizePath(ziel))
