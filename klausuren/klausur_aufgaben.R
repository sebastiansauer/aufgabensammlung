# Liest eine Klausurliste (klausuren/*.txt) ein und prüft sie.
#
# Rückgabe: Vektor der Aufgabenpfade in Klausurreihenfolge, direkt
# verwendbar für exams2moodle(), exams2pdf() usw.
#
# Fehler, wenn eine Datei fehlt oder eine Aufgabe doppelt vorkommt.
# Warnung, wenn eine Aufgabe laut aufgaben_tabelle.tsv buggy ist.
#
# Aufruf aus dem Repo-Wurzelordner:
#   source("klausuren/klausur_aufgaben.R")
#   klausur_aufgaben("klausuren/probeklausur-2026-ws.txt")
#
# Übersicht, welche Aufgabe in welchen Klausuren steckt:
#   klausuren_uebersicht()

klausur_aufgaben <- function(datei, tabelle = "aufgaben_tabelle.tsv") {
  zeilen <- readLines(datei, warn = FALSE, encoding = "UTF-8")
  zeilen <- trimws(sub("#.*$", "", zeilen))  # Kommentare entfernen
  pfade <- zeilen[zeilen != ""]

  fehlend <- pfade[!file.exists(pfade)]
  if (length(fehlend) > 0) {
    stop("Diese Aufgaben gibt es nicht:\n  ",
         paste(fehlend, collapse = "\n  "), call. = FALSE)
  }

  doppelt <- unique(pfade[duplicated(pfade)])
  if (length(doppelt) > 0) {
    stop("Diese Aufgaben stehen mehrfach in der Liste:\n  ",
         paste(doppelt, collapse = "\n  "), call. = FALSE)
  }

  if (file.exists(tabelle)) {
    tab <- utils::read.delim(tabelle, colClasses = "character",
                             encoding = "UTF-8")
    buggy <- pfade[pfade %in% tab$pfad[tab$buggy == "ja"]]
    if (length(buggy) > 0) {
      warning("Diese Aufgaben sind als buggy markiert:\n  ",
              paste(buggy, collapse = "\n  "), call. = FALSE)
    }
  }

  pfade
}

klausuren_uebersicht <- function(ordner = "klausuren") {
  dateien <- list.files(ordner, pattern = "\\.txt$", full.names = TRUE)
  dateien <- dateien[basename(dateien) != "vorlage.txt"]
  teile <- lapply(dateien, function(d) {
    data.frame(pfad = klausur_aufgaben(d),
               klausur = sub("\\.txt$", "", basename(d)))
  })
  do.call(rbind, c(list(data.frame(pfad = character(),
                                   klausur = character())), teile))
}
