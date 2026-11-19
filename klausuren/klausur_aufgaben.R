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

# --- Hilfen für die Render-Skripte (klausur_html.R, klausur_forms.R) -------

# Klausurliste suchen: relativ zum aktuellen Ordner, sonst in klausuren/;
# die Endung .txt ist optional. Gibt den absoluten Pfad zurück.
klausur_finden <- function(name, repo) {
  kandidaten <- c(name, paste0(name, ".txt"),
                  file.path(repo, "klausuren", name),
                  file.path(repo, "klausuren", paste0(name, ".txt")))
  gefunden <- kandidaten[file.exists(kandidaten) & !dir.exists(kandidaten)]
  if (length(gefunden) == 0) {
    stop("Klausurliste nicht gefunden: ", name, call. = FALSE)
  }
  normalizePath(gefunden[1])
}

# Liest Kopfkommentar, Abschnitte und Zeilenkommentare einer Klausurliste.
# Rückgabe: list(kopf = Zeilen des Kopfkommentars,
#                info = data.frame(pfad, abschnitt, kommentar))
# Kopfkommentar: Kommentare bis zur letzten Leerzeile vor der ersten Aufgabe.
# Abschnitt: Kommentarzeile mit Leerzeile davor und Aufgabenpfad danach.
klausur_struktur <- function(datei) {
  zeilen <- readLines(datei, warn = FALSE, encoding = "UTF-8")
  ist_pfad <- trimws(sub("#.*$", "", zeilen)) != ""
  ist_komm <- grepl("^\\s*#", zeilen)
  erste_aufgabe <- which(ist_pfad)[1]

  leer_davor <- which(trimws(zeilen[seq_len(erste_aufgabe - 1)]) == "")
  kopf_ende <- if (length(leer_davor)) max(leer_davor) - 1 else 0
  kopf <- zeilen[seq_len(kopf_ende)]
  kopf <- sub("^\\s*# ?", "", kopf[ist_komm[seq_len(kopf_ende)]])

  abschnitt <- character(length(zeilen))
  aktuell <- ""
  for (i in seq_along(zeilen)) {
    if (ist_komm[i] && i < length(zeilen) && ist_pfad[i + 1] &&
        (i == 1 || trimws(zeilen[i - 1]) == "")) {
      aktuell <- sub("^\\s*#\\s*", "", zeilen[i])
    }
    abschnitt[i] <- aktuell
  }
  info <- data.frame(
    pfad = trimws(sub("#.*$", "", zeilen))[ist_pfad],
    abschnitt = abschnitt[ist_pfad],
    kommentar = ifelse(grepl("#", zeilen[ist_pfad]),
                       trimws(sub("^[^#]*#", "", zeilen[ist_pfad])), "")
  )
  list(kopf = kopf, info = info)
}
