# Exportiert eine Klausurliste (klausuren/*.txt) als Moodle-XML zum Import
# in die Moodle-Fragensammlung (Fragensammlung > Import > Format "Moodle XML").
#
# Aufruf aus einem beliebigen Ordner, z. B.:
#   Rscript klausuren/klausur_moodle.R klausuren/probeklausur-start-bayes-2026.txt
#   Rscript klausuren/klausur_moodle.R probeklausur-start-bayes-2026 --n=5
# (die Liste wird relativ zum aktuellen Ordner oder in klausuren/ gesucht,
# die Endung .txt ist optional)
#
# Optionen:
#   --n=<zahl>  Varianten pro Aufgabe (Standard: 10). Jede Variante mischt die
#               Antwortoptionen neu (exshuffle) bzw. zieht bei dynamischen
#               Aufgaben neue Zahlen. Moodle wählt pro Person eine Variante.
#   --seed=<zahl>  Zufallsstart (Standard: 1), für reproduzierbaren Export.
#
# Ergebnis: klausuren/moodle/<liste>.xml (der Ordner ist in .gitignore).
#
# Aufbau in Moodle: Jede Aufgabe bekommt eine eigene Unterkategorie
# "<liste>/<Nr> <Aufgabenname>" mit ihren n Varianten. Im Test fügt man pro
# Kategorie eine "Zufallsfrage" hinzu. Gemischt wird nur durch R/exams, nicht
# durch Moodle, damit Aufgaben mit exshuffle: false (z. B. mit "keine der
# genannten Alternativen" am Ende) ihre Reihenfolge behalten.
#
# Vor dem Export wird jede Aufgabe einzeln geprüft; scheitert eine, bricht
# das Skript mit einer Liste der fehlerhaften Aufgaben ab, ohne XML zu schreiben.

args <- commandArgs(trailingOnly = TRUE)
opt_wert <- function(name, standard) {
  treffer <- grep(paste0("^--", name, "="), args, value = TRUE)
  if (length(treffer)) as.integer(sub(paste0("^--", name, "="), "", treffer[1])) else standard
}
n_var <- opt_wert("n", 10L)
seed <- opt_wert("seed", 1L)
args <- args[!grepl("^--", args)]
if (length(args) != 1 || is.na(n_var) || n_var < 1 || is.na(seed)) {
  stop("Aufruf: Rscript klausuren/klausur_moodle.R <klausurliste.txt> [--n=10] [--seed=1]",
       call. = FALSE)
}

# Repo-Wurzel aus dem Ort dieses Skripts (klausuren/ liegt darin)
skript <- sub("^--file=", "", grep("^--file=", commandArgs(FALSE), value = TRUE))
repo <- if (length(skript) == 1) dirname(dirname(normalizePath(skript))) else getwd()
source(file.path(repo, "klausuren", "klausur_aufgaben.R"))

liste <- klausur_finden(args[1], repo)
setwd(repo)  # Aufgabenpfade in der Liste sind relativ zur Repo-Wurzel
pfade <- klausur_aufgaben(liste)  # prüft fehlende/doppelte/buggy Aufgaben
titel <- sub("\\.txt$", "", basename(liste))
namen <- sub("^posts/([^/]+)/.*$", "\\1", pfade)

# --- Vorab jede Aufgabe einzeln prüfen -------------------------------------

message("Prüfe ", length(pfade), " Aufgaben ...")
fehler <- character()
for (p in pfade) {
  e <- tryCatch({
    suppressWarnings(exams::xexams(p, driver = list(sweave = list(quiet = TRUE),
                                                     read = NULL)))
    NULL
  }, error = function(e) conditionMessage(e))
  if (!is.null(e)) fehler <- c(fehler, sprintf("  %s: %s", p, e))
}
if (length(fehler)) {
  stop("Diese Aufgaben lassen sich nicht verarbeiten, kein Export:\n",
       paste(fehler, collapse = "\n"), call. = FALSE)
}

# --- Export ------------------------------------------------------------------

ziel_dir <- file.path(repo, "klausuren", "moodle")
dir.create(ziel_dir, showWarnings = FALSE)

message("Exportiere mit ", n_var, " Variante(n) pro Aufgabe ...")
set.seed(seed)
exams::exams2moodle(
  pfade,
  n = n_var,
  name = titel,
  dir = ziel_dir,
  stitle = sprintf("%02d %s", seq_along(namen), namen),
  converter = "pandoc-mathjax",
  schoice = list(shuffle = FALSE, answernumbering = "abc", penalty = 0),
  mchoice = list(shuffle = FALSE, answernumbering = "abc", penalty = 0),
  verbose = FALSE
)

ziel <- file.path(ziel_dir, paste0(titel, ".xml"))

# Fragenamen kürzen: exams2moodle bildet sie aus dem Pfad
# ("R1 Q26 : posts_<name>_<name>" bzw. "..._index"); übrig bleibt "<name>"
xml <- readLines(ziel, warn = FALSE, encoding = "UTF-8")
xml <- gsub("posts_([^<]+?)_(\\1|index)(\\.[A-Za-z]+)?\\b", "\\1", xml, perl = TRUE)
writeLines(xml, ziel, useBytes = TRUE)

message("\nGeschrieben: ", normalizePath(ziel), "  (", length(pfade),
        " Aufgaben x ", n_var, " Varianten)")
