# Rendert eine Klausurliste (klausuren/*.txt) als HTML-Prüfansicht.
#
# Aufruf aus dem Repo-Wurzelordner:
#   Rscript klausuren/klausur_html.R klausuren/probeklausur-start-bayes-2026.txt
#   Rscript klausuren/klausur_html.R klausuren/probeklausur-start-bayes-2026.txt --open
#
# Ergebnis: klausuren/html/<liste>.html, eine einzige Datei (Bilder eingebettet,
# Formeln als MathML). Der Ordner klausuren/html/ ist in .gitignore.
#
# Pro Aufgabe zeigt die Ansicht Nummer, Name, Pfad und Kapitel (aus den
# Abschnittskommentaren der Liste), die Frage, die Antwortoptionen in der
# Originalreihenfolge (ohne exshuffle) mit markierter richtiger Option bzw.
# den Lösungswert, und die Lösung. Aufgaben, die nicht rendern, erscheinen
# als rot markierter Fehlerkasten; das Skript bricht dann nicht ab.

args <- commandArgs(trailingOnly = TRUE)
oeffnen <- "--open" %in% args
args <- setdiff(args, "--open")
if (length(args) != 1) {
  stop("Aufruf: Rscript klausuren/klausur_html.R <klausurliste.txt> [--open]",
       call. = FALSE)
}
liste <- args[1]

source("klausuren/klausur_aufgaben.R")
pfade <- klausur_aufgaben(liste)  # prüft fehlende/doppelte/buggy Aufgaben

# --- Liste lesen: Kopfkommentar, Abschnitte, Zeilenkommentare -------------

zeilen <- readLines(liste, warn = FALSE, encoding = "UTF-8")
ist_pfad <- trimws(sub("#.*$", "", zeilen)) != ""
ist_komm <- grepl("^\\s*#", zeilen)
erste_aufgabe <- which(ist_pfad)[1]

# Kopfkommentar: Kommentare bis zur letzten Leerzeile vor der ersten Aufgabe
# (danach folgt ggf. schon der erste Abschnittskommentar)
leer_davor <- which(trimws(zeilen[seq_len(erste_aufgabe - 1)]) == "")
kopf_ende <- if (length(leer_davor)) max(leer_davor) - 1 else 0
kopf <- zeilen[seq_len(kopf_ende)]
kopf <- sub("^\\s*# ?", "", kopf[ist_komm[seq_len(kopf_ende)]])

# Abschnittskommentar: Kommentarzeile mit Leerzeile davor und Pfad danach
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

# --- Aufgaben einzeln verarbeiten ------------------------------------------

esc <- function(x) {
  x <- gsub("&", "&amp;", x, fixed = TRUE)
  x <- gsub("<", "&lt;", x, fixed = TRUE)
  gsub(">", "&gt;", x, fixed = TRUE)
}

trafo <- exams::make_exercise_transform_html(converter = "pandoc-mathml",
                                             base64 = TRUE)

verarbeite <- function(pfad) {
  tryCatch({
    x <- suppressWarnings(exams::xexams(
      pfad, n = 1L, dir = tempfile("klausur_html_"),
      driver = list(sweave = list(quiet = TRUE),
                    read = list(exshuffle = FALSE),
                    transform = trafo, write = NULL)
    ))[[1]][[1]]
    list(ok = TRUE, x = x)
  }, error = function(e) list(ok = FALSE, fehler = conditionMessage(e)))
}

set.seed(1)
ergebnisse <- lapply(info$pfad, function(p) {
  message("Rendere ", p)
  verarbeite(p)
})

loesung_kurz <- function(x) {
  m <- x$metainfo
  if (m$type %in% c("schoice", "mchoice")) {
    paste(LETTERS[which(m$solution)], collapse = ", ")
  } else if (m$type == "num") {
    paste0(format(m$solution, big.mark = " ", scientific = FALSE),
           if (any(m$tolerance > 0)) paste0(" (Toleranz ", m$tolerance, ")"))
  } else {
    paste(m$solution, collapse = "; ")
  }
}

aufgabe_html <- function(nr, inf, erg) {
  name <- sub("^posts/([^/]+)/.*$", "\\1", inf$pfad)
  kopfzeile <- sprintf(
    '<h2 id="a%d">%d. %s</h2>\n<p class="meta"><code>%s</code>%s%s</p>',
    nr, nr, esc(name), esc(inf$pfad),
    if (inf$abschnitt != "") paste0(" &middot; Kapitel ", esc(inf$abschnitt)) else "",
    if (inf$kommentar != "") paste0(" &middot; <em>", esc(inf$kommentar), "</em>") else ""
  )
  if (!erg$ok) {
    return(paste0('<section class="aufgabe fehler">', kopfzeile,
                  '<p><strong>Fehler beim Rendern:</strong></p><pre>',
                  esc(erg$fehler), "</pre></section>"))
  }
  x <- erg$x
  m <- x$metainfo
  optionen <- ""
  if (length(x$questionlist) > 0) {
    richtig <- if (is.logical(m$solution)) m$solution else rep(FALSE, length(x$questionlist))
    li <- sprintf('<li class="%s">%s%s</li>',
                  ifelse(richtig, "richtig", ""),
                  x$questionlist,
                  ifelse(richtig, ' <span class="haken">&#10004; richtig</span>', ""))
    optionen <- paste0('<ol type="A" class="optionen">', paste(li, collapse = "\n"), "</ol>")
  }
  paste0(
    '<section class="aufgabe">', kopfzeile,
    sprintf('<p class="typ">%s &middot; Punkte: %s &middot; Lösung: <strong>%s</strong></p>',
            esc(m$type), esc(m$points), esc(loesung_kurz(x))),
    '<div class="frage">', paste(x$question, collapse = "\n"), "</div>",
    optionen,
    '<details open><summary>Lösung</summary><div class="loesung">',
    paste(x$solution, collapse = "\n"), "</div></details>",
    "</section>"
  )
}

teile <- vapply(seq_along(ergebnisse), function(i)
  aufgabe_html(i, info[i, ], ergebnisse[[i]]), character(1))

n_fehler <- sum(!vapply(ergebnisse, `[[`, logical(1), "ok"))

uebersicht <- paste0(
  "<table class='uebersicht'><thead><tr><th>Nr.</th><th>Aufgabe</th>",
  "<th>Kapitel</th><th>Typ</th><th>Lösung</th></tr></thead><tbody>",
  paste(vapply(seq_along(ergebnisse), function(i) {
    e <- ergebnisse[[i]]
    sprintf("<tr%s><td>%d</td><td><a href='#a%d'>%s</a></td><td>%s</td><td>%s</td><td>%s</td></tr>",
            if (e$ok) "" else " class='fehler'", i, i,
            esc(sub("^posts/([^/]+)/.*$", "\\1", info$pfad[i])),
            esc(info$abschnitt[i]),
            if (e$ok) esc(e$x$metainfo$type) else "FEHLER",
            if (e$ok) esc(loesung_kurz(e$x)) else "")
  }, character(1)), collapse = "\n"),
  "</tbody></table>"
)

titel <- sub("\\.txt$", "", basename(liste))
html <- paste0(
  '<!DOCTYPE html>\n<html lang="de"><head><meta charset="utf-8">',
  '<meta name="viewport" content="width=device-width, initial-scale=1">',
  "<title>", esc(titel), "</title><style>
body { font-family: system-ui, sans-serif; max-width: 52rem; margin: 2rem auto;
       padding: 0 1rem; line-height: 1.5; color: #222; background: #fff; }
h1 { margin-bottom: .2rem; }
.stand { color: #666; margin-top: 0; }
pre.kopf { background: #f6f6f6; padding: .8rem; white-space: pre-wrap; }
table.uebersicht { border-collapse: collapse; width: 100%; font-size: .9rem; }
table.uebersicht td, table.uebersicht th { border-bottom: 1px solid #ddd;
       padding: .25rem .5rem; text-align: left; vertical-align: top; }
section.aufgabe { border-top: 2px solid #ccc; margin-top: 2.5rem; padding-top: .5rem; }
section.fehler, tr.fehler { background: #fde8e8; }
.meta, .typ { color: #555; font-size: .9rem; margin: .2rem 0; }
ol.optionen li { margin: .3rem 0; padding: .1rem .4rem; }
ol.optionen li.richtig { background: #e3f5e1; border-left: 4px solid #2e8b3d; }
.haken { color: #2e8b3d; font-weight: bold; white-space: nowrap; }
details { margin-top: 1rem; }
summary { cursor: pointer; font-weight: bold; }
.loesung { background: #fafafa; border-left: 4px solid #bbb; padding: .2rem .8rem; }
img { max-width: 100%; height: auto; }
</style></head><body>",
  "<h1>", esc(titel), "</h1>",
  sprintf('<p class="stand">%d Aufgaben%s &middot; erstellt %s &middot; Antwortoptionen in Originalreihenfolge (in der Klausur ggf. gemischt)</p>',
          length(ergebnisse),
          if (n_fehler > 0) sprintf(" &middot; <strong>%d mit Fehler</strong>", n_fehler) else "",
          format(Sys.time(), "%Y-%m-%d %H:%M")),
  if (length(kopf)) paste0('<pre class="kopf">', esc(paste(kopf, collapse = "\n")), "</pre>") else "",
  uebersicht,
  paste(teile, collapse = "\n"),
  "</body></html>"
)

dir.create("klausuren/html", showWarnings = FALSE)
ziel <- file.path("klausuren/html", paste0(titel, ".html"))
writeLines(html, ziel, useBytes = TRUE)
message("\nGeschrieben: ", ziel, "  (", length(ergebnisse), " Aufgaben, ",
        n_fehler, " Fehler)")
if (oeffnen) utils::browseURL(normalizePath(ziel))
