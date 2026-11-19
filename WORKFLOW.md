# Workflow: Aufgaben schreiben, pflegen, synchronisieren, rendern

Aufgaben werden **nur in diesem Repo** (`06_aufgabensammlung`) geschrieben und gepflegt.
`07_datenwerk/posts/` wird daraus erzeugt; Änderungen dort werden beim nächsten Sync überschrieben.

## Überblick

| Repo | Rolle | Hier arbeitest du |
|---|---|---|
| `06_aufgabensammlung` | Master der Aufgaben und der Liste (`aufgaben_tabelle.tsv`) | ja |
| `07_datenwerk` | Blog; `posts/` wird erzeugt | nein, nur rendern, committen, pushen |
| `02_statistik1-aufgabensammlung` | Buch; bindet dieses Repo als Submodul `exrs` ein | nein, nur Referenz nachziehen |

## 1. Neue Aufgabe schreiben (in 06)

1. Ordner `posts/<slug>/` anlegen, darin `<slug>.qmd`, `<slug>.rmd` oder `index.qmd`.
   Dateiformat (u. a. R/exams für schoice) siehe `CLAUDE.md`.
2. Im Aufgaben-Code **alle Pakete selbst laden**, auch `library(exams)` bei `fmt()`,
   `answerlist()`, `mchoice2string()`. Im Blog ist nichts vorgeladen.
3. **Tabellen kürzen**: Data Frames höchstens mit `head(10)` ausgeben; keine Tabelle über 100 Zeilen.
4. Keine absoluten Pfade und keine Dateien außerhalb des Aufgabenordners
   (Daten in den Ordner legen oder per URL laden).
5. Zeile in `aufgaben_tabelle.tsv` ergänzen. Wichtig ist die Spalte `blog` (`ja`/`nein`),
   bei `nein` der Grund in `blog_grund`. Fehlt die Zeile, warnt das Sync-Skript und
   behandelt die Aufgabe als freigegeben.

## 2. Bestehende Aufgabe pflegen

- Datei in `06/posts/<slug>/` bearbeiten, nie in `07/posts/`.
- Soll eine Aufgabe nicht im Blog erscheinen: `blog=nein` setzen, Grund in `blog_grund`.

## 3. Nach 07 synchronisieren

```bash
cd ~/Dokumente/github/06_aufgabensammlung
Rscript sync_datenwerk.R            # Trockenlauf: zeigt nur die Änderungen
Rscript sync_datenwerk.R --apply    # führt aus
```

Das Skript kopiert die freigegebenen Ordner 1:1 nach `07_datenwerk/posts/`
(ohne `_cache` und `_files`) und entfernt dort alles, was nicht mehr freigegeben ist.

## 4. Rendern (in 07)

```bash
cd ~/Dokumente/github/07_datenwerk
quarto render posts/<slug>/<datei> --to html   # eine Aufgabe, zum Testen
quarto render                                  # ganzes Projekt, dauert lange
```

- **Alte Caches löschen**, wenn ein Render mit „Funktion nicht gefunden" scheitert,
  obwohl `library()` im Code steht: knitr überspringt sonst den gecachten Chunk samt `library()`.
  Die `*_cache`-Ordner sind gitignored und können gefahrlos gelöscht werden.
- Ein Gesamt-Render **bricht beim ersten Fehler ab**. Für viele Dateien ist es deutlich schneller,
  getrennte Arbeitskopien des Projekts mit je einem Teil der Aufgaben parallel zu rendern.
- Die Renderliste in `07/_quarto.yml` muss `*.qmd`, `*.rmd` **und** `*.Rmd` enthalten,
  sonst fehlen Aufgaben mit großer Endung.

## 5. Committen und pushen

1. In 06 committen, dann in 07 (`posts/` und ggf. `_quarto.yml`).
2. Pushen, wenn du soweit bist.

## 6. Blog veröffentlichen (GitHub Pages)

Der Blog wird **lokal gerendert** und das fertige `docs/` auf den Branch `gh-pages` gepusht.
Die GitHub-Action (CI) ist abgeschaltet: Sie würde alles von Grund auf mit `renv.lock` neu rendern
und ist damit nicht verlässlich.

```bash
cd ~/Dokumente/github/07_datenwerk
quarto render                                      # alles; Fehler prüfen, Exit-Code muss 0 sein
quarto publish gh-pages --no-render --no-prompt    # veröffentlicht das vorhandene docs/
```

- Voraussetzungen: SSH-Schlüssel im Agent (`ssh-add -l`), Git in 07 sauber, `docs/` vollständig
  (nach einem Gesamt-Render; `quarto publish` spiegelt `docs/` und löscht alles, was dort fehlt).
- Nur kleine Änderungen? Zuerst Einzelaufgaben mit `quarto render posts/<slug>/<datei> --to html`
  testen, aber für die Veröffentlichung braucht es danach trotzdem ein vollständiges `docs/`
  (also einen Gesamt-Render, der dank `freeze` für unveränderte Aufgaben schnell ist).
- Nach dem Push dauert das Deployment von GitHub Pages einige Minuten (Cache: Browser neu laden).
- Prüfen: <https://sebastiansauer.github.io/datenwerk/>, Stichprobe neuer Aufgaben,
  `search.json` und Seitengröße (große Seiten deuten auf zu lange Tabellenausgaben hin).

## 7. Submodul in 02 aktualisieren

Erst nach dem Push von 06, sonst zeigt die Referenz auf einen Commit, den andere nicht haben.

```bash
cd ~/Dokumente/github/02_statistik1-aufgabensammlung/exrs
git fetch origin && git merge --ff-only origin/main
cd .. && git add exrs && git commit -m "exrs aktualisiert"
```

## Bekannte Stolpersteine

- Lokal rendert 07 mit der persönlichen R-Bibliothek (`renv/settings.json`, `external.libraries`).
  `renv.lock` wird für den Build nicht mehr benutzt (CI aus) und ist nur noch eine Versionsdokumentation.
- Der Sync-Dienst (z. B. Dropbox/Syncthing) darf die Repo-Ordner nicht synchronisieren, sonst
  entstehen `*.conflict`-Dateien.
- Das Sync-Skript entfernt auch Duplikate in `07/posts` (z. B. falsche Groß-/Kleinschreibung von Ordnernamen).
