#!/usr/bin/env Rscript
# Synchronisiert die Aufgaben aus diesem Repo (Master) in den Blog ../07_datenwerk/posts.
#
# Regel: Ein Ordner posts/<slug> kommt in den Blog, es sei denn, die Tabelle
# aufgaben_tabelle.tsv markiert ihn in der Spalte `blog` mit "nein".
# Ordner ohne Tabellenzeile gelten als freigegeben (Warnung).
# 07_datenwerk/posts wird als generiert behandelt: Ordner, die nicht freigegeben
# sind, werden dort entfernt. Build-Artefakte (_cache, _files, ...) bleiben
# unangetastet bzw. werden nicht ueberschrieben.
#
# Nach --apply ruft das Skript ../07_datenwerk/scripts/make-quiz-posts.R auf,
# damit die exams2forms-Quiz-Posts (Wrapper + _<name>) wieder entstehen.
#
# Aufruf:  Rscript sync_datenwerk.R            # Trockenlauf (zeigt nur an)
#          Rscript sync_datenwerk.R --apply    # fuehrt aus

args  <- commandArgs(trailingOnly = TRUE)
apply <- "--apply" %in% args
quelle <- normalizePath("posts")
ziel   <- normalizePath("../07_datenwerk/posts")

tab <- read.delim("aufgaben_tabelle.tsv", quote = "", stringsAsFactors = FALSE)
tab$slug <- sub("^posts(_buggy)?/([^/]+)/.*$", "\\2", tab$pfad)
tab$ordner <- sub("/[^/]+$", "", sub("^(posts(_buggy)?/[^/]+)/.*$", "\\1", tab$pfad))

ordner <- list.dirs(quelle, full.names = FALSE, recursive = FALSE)
gesperrt <- tab$slug[tab$blog == "nein" & startsWith(tab$pfad, "posts/")]
unbekannt <- setdiff(ordner, tab$slug[startsWith(tab$pfad, "posts/")])
if (length(unbekannt)) message("Warnung: nicht in der Tabelle (gelten als freigegeben): ",
                               paste(unbekannt, collapse = ", "))
frei <- setdiff(ordner, gesperrt)

vorhanden <- list.dirs(ziel, full.names = FALSE, recursive = FALSE)
zu_loeschen <- setdiff(vorhanden, frei)
message(sprintf("Freigegeben: %d | im Blog vorhanden: %d | zu entfernen: %d",
                length(frei), length(vorhanden), length(zu_loeschen)))
if (length(zu_loeschen)) message("Entfernen: ", paste(head(zu_loeschen, 50), collapse = ", "))

# Dateien direkt im Blog-posts-Ordner (z.B. Listen) werden nicht angefasst.
excl <- c("--exclude=*_cache/", "--exclude=*_files/", "--exclude=.Rhistory",
          "--exclude=.quarto/", "--exclude=.DS_Store",
          "--exclude=/cache/")  # knitr-Cache von quiz() (07_datenwerk)
for (s in frei) {
  a <- c("-a", if (!apply) "--dry-run", "--itemize-changes", "--delete", excl,
         paste0(quelle, "/", s, "/"), paste0(ziel, "/", s, "/"))
  out <- system2("rsync", a, stdout = TRUE)
  if (length(out)) cat(paste0(s, ": ", out), sep = "\n")
}
for (s in zu_loeschen) if (apply) unlink(file.path(ziel, s), recursive = TRUE)

# Quiz-Posts wiederherstellen: rsync ersetzt die Wrapper der exams2forms-Posts
# (07_datenwerk/scripts/make-quiz-posts.R) durch die Originalaufgaben und
# loescht die _<name>-Dateien. Das Skript erzeugt beides identisch neu.
if (apply) {
  blog <- dirname(ziel)
  quiz_skript <- file.path(blog, "scripts", "make-quiz-posts.R")
  if (file.exists(quiz_skript)) {
    message("Quiz-Posts in 07_datenwerk neu erzeugen ...")
    status <- withr::with_dir(blog, system2("Rscript", "scripts/make-quiz-posts.R"))
    if (status != 0) warning("make-quiz-posts.R fehlgeschlagen (Status ", status, ")")
  } else {
    message("Hinweis: ", quiz_skript, " fehlt (anderer Branch in 07?), Quiz-Posts nicht erzeugt.")
  }
}

message(if (apply) "Fertig (angewendet)." else "Trockenlauf beendet. Mit --apply ausfuehren.")
