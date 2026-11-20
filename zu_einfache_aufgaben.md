# Zu einfache Aufgaben

Geprüft wurden alle Aufgaben aus `aufgaben_tabelle.tsv` (ca. 1185 Dateien), jeweils Aufgabentext, Optionen und Lösung.

"Zu einfach" = ohne Nachdenken lösbar: Die Lösung steht im Text, oder sie ist auch ohne Statistikwissen sofort klar (Alltagslogik, absurde Distraktoren, richtige Option fällt durch Länge/Formulierung auf).
Aufgaben, die Rechnen, R, Diagramm-/Datenlesen oder Fachbegriffe brauchen, sind nicht aufgenommen, auch wenn sie leicht sind.

## Trivial

| Aufgabe | Warum |
|---|---|
| `achsen_trick` | Der Satz „Manipulieren Sie die Wahrnehmung durch Achsenwahl“ verrät die Lösung, und nur Option 1 handelt von der Achse. |
| `anscombe_logik` | Der Hinweis „Grenzen rein numerischer Kennzahlen“ entspricht Option 1. Die Distraktoren sind absurd. |
| `balken_normierung` | Der Hinweis „Vergleichbarkeit bei unterschiedlichen Gruppengrößen“ steht fast wörtlich in Option 1. |
| `bayesmod-bestimmen01-schoice` | Die Antwort `b1 ~ Normal(0, 1.5)` folgt durch reinen Textabgleich. |
| `bedingte-wahrscheinlichkeit-hintergrundwissen-schoice` | Die Frage setzt „kein Widerspruch“ voraus. Zwei Optionen behaupten einen Widerspruch, zwei sind sachfremd. |
| `causal_err` | Die Antwort ist die Alltagsweisheit „Korrelation ≠ Kausalität“. Die übrigen Optionen sind absurd. |
| `corona-todesfaelle1` | Kumulierte Todesfälle können nicht sinken, die Daten muss man dafür nicht ansehen. |
| `dag-aequivalenzklasse-schoice` | Die Antwort folgt direkt aus dem Fragetext. Die richtige Option ist die längste, die anderen sagen „immer“ oder „automatisch“. |
| `def_datenjudo` | Die Distraktoren sind unsinnig (Kampfsportstatistik, Verschlüsselung). |
| `def-statistik01`, `def-statistik01-schoice` | Die längste, alles umfassende Option ist richtig. „Statistik vervielfacht Daten“ ist absurd. |
| `definition_dataframe` | „Tabelle“ ergibt sich aus dem Wort. Die Distraktoren sind erkennbar falsch. |
| `definition_punktmodell` | Das Wort „Punkt“ und der Hinweis im Text verraten die Antwort. |
| `effekt-definition-nicht-kausal-schoice` | Nur die richtige Option ist abwägend formuliert, alle anderen sind absolut. |
| `epistemologische-zielrichtung-schoice` | Lang und abgewogen gegen pauschal absurde Distraktoren. |
| `expgruppe-vs-kontrollgruppe` | Mit Alltagslogik lösbar: Die Gruppen sind gleich bis auf die Intervention. |
| `experiment-vs-beobachtung-konfundierung-schoice` | Die richtige Option fällt durch ihre Länge auf, die Distraktoren sind unsinnig. |
| `file_drawer_problem` | Der Hinweis „selektives Berichten“ verrät die Lösung. Die Distraktoren sind absurd. |
| `filter_logik` | Die richtige Option wiederholt das Wort „gleichzeitig“ aus der Frage. |
| `funktionsargumente` | Die Distraktoren sind absurd („niemals mehr als ein Argument“). |
| `groupby` | Der Name verrät die Antwort, die übrigen Optionen sind absurd. |
| `gruppen_modell_vorteil` | Der Text verlangt „Beziehen Sie sich auf die Residuen“, und nur Option 1 nennt Residuen. |
| `inferenz-ungewissheit-notwendig-schoice` | Die Distraktoren sind mit Alltagslogik widerlegbar („durch Runden vermeidbar“). |
| `intercept_m` | Der Text sagt „Modell auch bei x = 0 gültig“, und nur Option 1 nennt „Lernzeit genau Null“. |
| `kausal-einfach` | Das Beispiel Haiangriffe/Eisverkauf ist mit Alltagsverstand lösbar. |
| `kochrezept-forschungsfrage-phasen-schoice` | Die richtige Option zählt die im Text genannten Phasen auf. |
| `kolmogorov` | „P(A) kann negativ sein“ ist auch für Laien offensichtlich falsch. |
| `kuehne-hypothesen-forschungsfeld-schoice` | Das Beispiel im Text zeigt die Antwort direkt. |
| `lego_prinzip_logik` | Alltagslogik, die übrigen Optionen sind absurd. |
| `linearer-zshg-nicht-kausal-schoice` | Allgemeinwissen. Die Distraktoren sagen „beweist immer“ oder „niemals“. |
| `logikpruefung_anwendung` | Bei `x <- 5; x == 6` ist FALSE ohne R-Kenntnis klar. |
| `minimale-adjustierungsmenge-definition-schoice` | Der Begriff „minimal“ verrät die Option „kleinstmögliche Menge“. |
| `modell-definition-schoice` | „Vereinfachtes Abbild der Wirklichkeit“ ist Allgemeinwissen. |
| `modellvergleich_mae` | Kleinerer Fehler = besseres Modell ist Alltagslogik. |
| `na_bedeutung` | „Not Available“ ist Allgemeinwissen, die Alternativen sind erfunden. |
| `neg_slope` | Mehr Fehlstunden bringen weniger Punkte, das ist sofort klar. |
| `nullhypothesen-kritik-schoice` | Die einzige differenzierte Option gegen absurde Extreme. |
| `nutzen_modelle` | Nur „Verständnis durch Vereinfachung“ ist plausibel. |
| `okabe_ito` | Nur „Barrierefreiheit“ ist sinnvoll. |
| `pfade_reproduzierbarkeit` | Der absolute Pfad als Problem liegt auf der Hand. |
| `pfeife` | Nur „und dann / Fließband“ passt zum Bild der Pfeife. |
| `popper-falsifikation-schoice` | Das Schwan-Beispiel ist Allgemeinwissen. |
| `post-verteilung-vollstaendig-zusammenfassen-schoice` | Der Text nennt den Informationsverlust schon. |
| `ppdac_modell` | Nur eine Auflösung passt zur Datenanalyse, der Rest ist Unsinn („Power, Point …“). |
| `ppv-post-verwechslung-schoice` | Der Text beschreibt beide Funktionen schon, die Option wiederholt das. |
| `praxis_datenjudo` | „Rohdaten sind unordentlich“ ist Alltagswissen. |
| `prob-disjunkt2` | Eine Karte kann nicht König und Dame zugleich sein. |
| `prob-ereignisraum` | Ω = {1,…,6} steht im Text, man muss nur abzählen. |
| `prob-sicher-unmoeglich` | Ein Würfel zeigt immer < 7 und nie > 6. |
| `regebene` | Der Hinweis „Vorhersagefläche“ verrät „Ebene“. |
| `regressionsgleichung-berechnen-schoice` | Option 1 setzt die Werte wörtlich ein (20 + 1,5·40). |
| `residuum_definition` | Der Text sagt „Residuum (Abweichung)“, und nur eine Option nennt eine Differenz. |
| `rope-default-grenze-rechnung-schoice` | Die Rechnung 0,10·800 = 80 steht fertig in der Option. |
| `rstudio_gui_view` | Ein Klick auf das Tabellensymbol öffnet eine Tabelle, das ist Alltagslogik. |
| `schein_korr` | Der Hinweis „Drittvariable“ steht wörtlich in der richtigen Option. |
| `scheinkorrelation_glatze` | Der Text erklärt den Störfaktor Alter schon. |
| `simpson-paradox-schoice` | Die richtige Option wiederholt den Fragetext, die anderen widersprechen ihm. |
| `simpson-paradox-vorzeichenwechsel-schoice` | Der Text beschreibt den Vorzeichenwechsel selbst. |
| `statistischer-vs-kausaler-effekt-schoice` | Die einzige abwägende Option, die anderen sind absurd. |
| `stichprobengroesse_genauigkeit` | Größere Stichprobe = genauer ist Allgemeinwissen. |
| `stochastisch-vs-kausal-unabhaengig-schoice` | Die richtige Option ist lang und vorsichtig, der Rest pauschal. |
| `streuung-vs-intervall-schoice` | Die lange Option mit Beispiel gegen „grundsätzlich“-Distraktoren. |
| `studie-a-oestrogen-stratifizieren-schoice` | Der Fragetext nennt das Kausalmodell schon. |
| `torten_kritik` | Der Hinweis „menschliche Wahrnehmung von Geometrie“ verrät die Antwort. |
| `typ-fehler-r-04` | Die geforderte Lösung ist die gezeigte Syntax. Siehe auch Fehler unten. |
| `typ-fehler-r-07` | Das fehlende Anführungszeichen sieht man ohne R, die übrigen Optionen sind absurd. |
| `vage-priori-gefahr-schoice` | Die Option wiederholt die Beobachtung aus dem Text (negative Körpergrößen). |
| `verteilungen-quiz-01` | Ist sich das Modell „sicher“, dass π = .7? „Nein“ ist offensichtlich. |
| `vorhersageintervall1` | Eine gegen zwei Unsicherheitsquellen: Dass das zweite Intervall größer ist, steht im Text. |
| `vorteil_skripte` | Nur „Reproduzierbarkeit“ ist plausibel. |
| `vorteil-parameterschaetzung-schoice` | Die Distraktoren sind absurd („benötigt keine Daten“). |
| `z-standardisierung-vergleich-schoice` | Die richtige Option ist doppelt so lang, die Distraktoren sind absolut formuliert. |
| `zentrieren-mit-interaktion-schoice` | Auffällig lang gegen Absolutaussagen. |
| `zentrierung` | Die Option wiederholt „am Mittelwert zentriert“ aus dem Text. |
| `zielart-beschreiben-definition-schoice` | Zwei Optionen widersprechen dem Wort „anwesenden“, und die richtige ist die längste. |
| `zielart-vorhersagen-punkt-bereich-schoice` | Der Text sagt „sagt … voraus“, und die einzige Alternative ist absurd. |
| `zwei-arten-ungewissheit-schoice` | Mit Abstand die längste Option, alle Distraktoren enthalten Absolutwörter. |

### Trivial wegen der Form der Optionen

Die richtige Option ist deutlich die längste bzw. als einzige abwägend formuliert, die Distraktoren sind absolut („immer“, „niemals“, „exakt dasselbe“). Man kann sie wählen, ohne den Inhalt zu verstehen.

| Aufgabe | Warum |
|---|---|
| `alternativhypothese-definition-schoice` | Die richtige Option ist lang, die Distraktoren sind teils absurd. |
| `bayes-r2-vs-frequentistisch-schoice` | Längste Option gegen absolute Distraktoren. |
| `blockieren-konzept-schoice` | Die Option ist lang und greift Begriffe aus dem Text auf. |
| `bsp1-hintertuer-schliessen-schoice`, `bsp2-hintertuer-schliessen-schoice` | Die Option ist lang und begründet, der Text nennt den Pfad schon. |
| `dag-bedingte-unabhaengigkeit-pruefen-schoice` | Längste Option gegen absolute Distraktoren. |
| `disjunkt-impliziert-nicht-unabhaengig-schoice` | Die Option ist um ein Vielfaches länger. |
| `drei-verteilungen-vergleich-schoice` | Längste Option, die Distraktoren sind teils absurd. |
| `estimate-expectation-schoice`, `gauss-modell-struktur-schoice`, `gemeinsame-post-verteilung-schoice` | Auffällig lange Option. |
| `gespenster-dag-schoice`, `hintertuer-definition-schoice` | Längste, einzige begründete Option. |
| `interaktion-falsch-interpretiert-schoice`, `interaktion-konzept-schoice` | Auffällig lange Option. |
| `ki-interpretation-bayes-freq-schoice` | Der Text schließt eine Option aus, die richtige ist lang. |
| `kleine-grosse-welt-schoice`, `koeffizienten-kausal-ohne-fundierung-schoice`, `konfundierer-definition-schoice` | Längste Option gegen absolute Distraktoren. |
| `mediator-kontrollieren-fehler-schoice`, `nachfahre-kontrollieren-schoice` | Längste Option gegen absolute Distraktoren. |
| `populationsinferenz-definition-schoice`, `ppv-definition-schoice` | Längste Option. |
| `praediktor-zentrieren-schoice`, `prior-wahl-beta1-vergleich-schoice`, `priori-washed-out-schoice`, `prioris-nicht-zentrieren-interaktion-schoice`, `pruefen-vs-schaetzen-unterschied-schoice`, `quantil-verteilungsfunktion-unterschied-schoice`, `regressionsgeraden-ungewissheit-schoice`, `regr-yb-interpretation-schoice` | Längste Option gegen absolute Distraktoren. |
| `robo-professor-rope-schoice`, `rope-konzept-schoice`, `rope-entscheidungsregel-schoice`, `rope-chinstrap-gentoo-interpretation-schoice` | Längste, einzige vorsichtige Option. |
| `sampling-weight-by-schoice`, `saturiertes-modell-schwaeche-schoice`, `signifikanz-gelman-definition-schoice`, `signifikanz-stichprobengroesse-schoice`, `stan-glm-chains-schoice`, `stan-glm-intercept-schoice`, `select-b` | Längste Option, die Distraktoren sind absurd oder absolut. |
| `stichprobenvert-vs-postvert-schoice`, `studie-b-blutdruck-nicht-stratifizieren-schoice` | Längste Option. |
| `uebergewissheit-punktschaetzer-schoice`, `vier-atome-uebersicht-schoice`, `warum-exponential-fuer-sigma-schoice` | Längste Option. |
| `verschachtelte_funktionen` | Die Option fällt durch ihre Länge auf, „alphabetisch“ ist absurd. |
| `fleiss-macht-bloed-berkson-schoice` | 1,8-mal so lang wie der längste Distraktor; die Distraktoren sind absurd („Fehler in der Simulation“, „Fleiß verringert kausal die Intelligenz“). |
| `regressionsmodell-struktur-schoice` | 2,4-mal so lang; die Distraktoren sind kurz und absolut („exakt“, „ohne jede Streuung“). |
| `kollision-definition-regel-schoice` | 1,9-mal so lang; die Distraktoren sagen „immer“, „exakt dieselbe“, „jede“. |
| `pwert-interpretation-schoice` | 2,0-mal so lang und als einzige vorsichtig formuliert. |
| `kettenregel-papst-fehlschluss-schoice` | Die richtige Option zeigt als einzige die vollständige Rechnung (Bayes-Formel) und ist doppelt so lang. |
| `cv1` | 1,7-mal so lang; die Distraktoren sagen „stets“ oder „sollte vermieden werden“. |
| `hdi-definition-schoice` | 1,6-mal so lang; die Distraktoren sagen „stets“, „immer“, „niemals“, „nur“. |
| `ppv-vs-post-parameterwerte-schoice` | 1,6-mal so lang und als einzige mit Beispielen; die übrigen sind kurz oder absolut. |

Dazu kommt `warum-bayes`: Im Quelltext steht schon dein Kommentar „DIE FRAGE IST ZU LEICHT“.

## Grenzfälle

Mit Alltagslogik oder über die Form der Optionen weitgehend lösbar, aber nicht ganz ohne Denken.

| Aufgabe | Warum |
|---|---|
| `aprioriwissen` | „Wahr, ohne dass es wahr ist“ ist Unsinn, der Rest ist nicht ganz absurd. |
| `bayesbox2`, `bayesbox3` | 10/10 bzw. 7/14 Treffer: π ist intuitiv klar, das sagt die Lösung selbst. |
| `beta1-interpretation-schoice` | Drei von fünf Optionen sind absurd. |
| `bsps-nullhyp` | Die richtige Option ist als einzige ohne erklärende Klammer formuliert. |
| `count_nominal` | `count()` lässt sich aus dem englischen Wort erraten. |
| `disjunkte-ereignisse-schoice` | Die gemeinsame 6 in {2,4,6} und {5,6} sieht man sofort. |
| `erklaeren-population-vs-kausal-schoice` | „Population“ ↔ hervorgehobene „Grundgesamtheit“. |
| `exp-prior-95quantil-schoice` | Zwei Optionen schließen sich per Klammervermerk selbst aus. |
| `experimente` | Die Distraktoren sind seltsam negiert. |
| `falsifik2` | Die Schwan-Aussagen sind mit Alltagslogik lösbar. |
| `filter_syntax`, `mutate`, `group_summarise`, `summarize` | Der Funktionsname verrät die Antwort. |
| `funktionsargumente_defaults` | `y = 10` legt die Antwort nahe. |
| `gleichverteilung-eigenschaften-schoice` | „Gleich“-verteilung → konstante Dichte. |
| `globus3` | Bei π = 1 ist „6 von 9 Wasser“ unmöglich, also 0. |
| `gruppenvergleich-regression-schoice` | Die Frage nennt schon beide Wege. |
| `guete_streuung` | Geringe Streuung = verlässlicher ist Alltagslogik. |
| `interaktion` | „Nicht parallel“ ≈ „Effekt hängt ab“, die Distraktoren sind unsinnig. |
| `iq03`, `iq03a` | P(IQ ≤ 100) bei N(100, 15) ist 0,5, das sieht man ohne Rechnen. |
| `kauslalinterp` | Nur eine Option nennt Ursache/Wirkung. |
| `kennwert-robust` | „Median“ ist sehr naheliegend. |
| `kolmogorov-axiome-schoice` | Drei Optionen sind für Laien offensichtlich falsch. |
| `korrelation_na_handling` | Drei Distraktoren sind absurd. |
| `korrelation_richtung`, `korrelation_z_logik` | Der Text sagt „je mehr, desto weniger“ bzw. „gemeinsam“. |
| `lageparameter-schiefe-post-schoice` | Der Text nimmt die Antwort vorweg. |
| `laplace-vs-frequentistisch-schoice` | Der Text schließt eine Option aus, der Rest ist Alltagslogik. |
| `lm-standardfehler` | „Größtes n“ ist intuitiv. |
| `logigkodier` | TRUE = 1 ist naheliegend. |
| `median_gerade_n` | Die einzige konkrete Rechenregel unter unplausiblen Optionen. |
| `modell_gleichung` | Lässt sich fast direkt aus y = m + e ablesen. |
| `mw_eigenschaft`, `residuen_summe` | Der Hinweis im Text verrät „Summe = 0“. |
| `na_philosophie` | Nur „rote Fahne“ ist plausibel. |
| `nierenstein-konfundierer-kontrollieren-schoice` | Option A wiederholt den Fragetext. |
| `parameter-genau` | Genaueste Schätzung = schmalstes Intervall. |
| `penguins-postbreite` | Die Regel und das Intervall stehen im Text, man muss nur vergleichen. |
| `pipe_vorteil` | Die Distraktoren sind weitgehend unsinnig. |
| `priori-vs-posterior-praediktiv-schoice` | Priori = vorher, Posterior = nachher. |
| `prob-disjunkt` | „Unvereinbar“ im Text passt zur Lösung. |
| `prob-elementarereignis` | „Elementar“ verrät die Antwort. |
| `probability-of-direction-schoice` | Der Name verrät die Antwort. |
| `punktschaetzer-reicht-nicht` | Weniger Ungewissheit bevorzugen ist Alltagslogik. |
| `quantil-90-interpretation-schoice` | Die Option nimmt 90 % und 0,78 direkt auf. |
| `r_syntax_correlation` | Nur zwei Optionen enthalten `correlation`. |
| `r_vs_rstudio` | Die meisten Distraktoren sind absurd. |
| `rechtschreibung1` | Je nach gezogenem Wort ohne Statistikwissen lösbar. |
| `reproduzierbarkeit` | Drei Distraktoren sind absurd. |
| `residuen_vergleich` | Fehlerbalken werden kürzer, das ist intuitiv. |
| `rope-luecke` | 8 von 10 Optionen sind absurd. |
| `samplesplit` | „Assessment“ = Prüfung. |
| `sd_vs_varianz` | Der Hinweis „Maßeinheit“ führt zur einzigen passenden Option. |
| `simu-unif2` | Bus alle 10 Minuten: > 5 Minuten warten ist intuitiv 50 %. |
| `skalenniveau_intervall` | 0 °C ist kein absoluter Nullpunkt, das ist Allgemeinwissen. |
| `skalenniveau_ordinal` | Ordinal → Ordnung. |
| `stichprobenanteil-vs-popanteil` | Mit Alltagslogik wählbar. |
| `there-is-no-package` | Die Fehlermeldung entspricht fast wörtlich der richtigen Option. |
| `tidy_data` | Mehrere Distraktoren sind absurd. |
| `typ-fehler-r-01`, `typ-fehler-r-06a` | Klammern zählen reicht. |
| `typ-fehler-r-03` | `x` gegen `X` fällt auch Laien auf. |
| `ungewissheit-beta-sigma-schoice` | Die Option formuliert nur den Text um. |
| `uv_av_unterscheidung` | „Ursache“ passt zu „Einfluss“ in der Frage. |
| `verteilungen-quiz-02-b` | „Determiniert“ passt nicht zu „Zufall“. |
| `verteilungen-quiz-17` | Bei einem Mittelwert von 160 kann „95 % > 160“ nicht stimmen. |
| `vier_oder_acht` | 4-mal Kopf ist wahrscheinlicher als 8-mal, das ist intuitiv. |
| `vorhersage-yb-berechnen-schoice` | Die Rechnung steht in der Option. |
| `wskt-schluckspecht2`, `wskt-schluckspecht2a` | Teilfrage 1 beantwortet der Text selbst. |
| `z_transformation_effekt` | „Zentrieren“ legt Mittelwert 0 nahe, drei Distraktoren sind absurd. |
| `z_wert_interpretation` | Das Minuszeichen → „unter dem Durchschnitt“. |
| `zielarten-stat-schoice` | „bewirkt“ im Text verrät „Kausalinferenz“. |
| `struktur_dataframe` | Die richtige Option ist 1,5-mal so lang und die einzige ausführliche; die Distraktoren sind aber für Laien nicht absurd. |
| `diamonds-nullhyp-mws` | Zwei Optionen („Nullhypothese sicher falsch/wahr“) scheiden sofort aus, die richtige ist die längste; man muss aber die Ausgabe lesen. |

## Systematisches Muster

Viele `*-schoice.Rmd`-Dateien (die mit „Warum die Distraktoren falsch sind“) haben die richtige Option auf Position 1. Sie ist meist deutlich die längste und als einzige abwägend formuliert. Die Distraktoren sind absolut formuliert („immer“, „niemals“, „exakt dasselbe“, „automatisch“). Mit `exshuffle` hilft die Position nicht mehr, die Länge und Formulierung aber schon.
Diese Fälle stehen oben unter „Trivial wegen der Form der Optionen“.

Zusätzlich habe ich per Skript bei allen schoice-Aufgaben die Länge der richtigen Option mit der des längsten Distraktors verglichen:

- Ausgewertet: 504 Aufgaben. Nicht messbar waren 90: 71 mit dynamischem `exsolution` (R-Code), 11 mit Inline-R in den Optionen, 8 mit unstimmiger Zahl von Optionen und `exsolution`.
- Bei 214 der 504 Aufgaben ist die richtige Option die längste. Bei 100 ist sie mindestens 1,5-mal so lang wie der längste Distraktor, bei 42 mindestens doppelt so lang.
- Alle Treffer ab 1,5-mal mit mindestens 40 Zeichen habe ich gesichtet. Bis auf 12 standen sie schon in der Liste. Von den 12 sind 8 oben als trivial ergänzt und 2 als Grenzfall. Nicht aufgenommen habe ich `predict_r` (kurze Code-Optionen) und `diamonds-histogramm-vergleich` (man muss das Diagramm lesen), ebenso `nullhyp-korrelation-schoice` (1,46-mal; ρ gegen r braucht Fachwissen).
- Unterhalb von 1,5-mal gibt es weitere schwächere Fälle, die ich nicht einzeln gesichtet habe, z. B. `mediator-vs-confounder-schoice`, `ppv-mixtur-treffer-schoice`, `ppv-mixtur-keine-treffer-schoice`, `interpret-koeff-schoice` und `regr-spezialfaelle-schoice` (je 1,3- bis 1,4-mal).

## Nebenbei gefundene Fehler (nicht „zu einfach“)

- `modalitaetsspezifisch`: `exsolution: 100000`, aber die Lösungs-Answerlist markiert Option 4 als „Wahr“.
- `wissschreib1`: Die Answerlist der Frage ist leer.
- `korr-ungewiss`: Die Lösung C ist vermutlich falsch, und ein extype fehlt.
- `logression1`: Doppeltes Aufzählungszeichen `* *`.
- `ds-quiz2`: `exsolution: 37385` ist ungültig (vermutlich `0111011`).
- `falsifik1`, `falsifik2`: Beide sind `schoice`, haben aber je drei richtige Optionen.
- `expgruppe-vs-kontrollgruppe`: Die Lösung („UV: Lernen, AV: Energieverbrauch“) gehört zu einer anderen Aufgabe.
- `experimente`: Der Lösungstext widerspricht der richtigen Option.
- `genial`, `genial-schoice`: Post für „nichtgenial“ = .092 statt .917, außerdem „genail“ und der Rest „K: Krebs“.
- `fattails02`: Text `df = 1`, Code `df = 2`, `rt()` doppelt.
- `germeval-sent-wordvec-rf-plain`: Laut Name RF, laut Text XGB.
- `fofrage-regrformel2-schoice`: Die Tabelle zeigt nur den Achsenabschnitt, m5 nutzt nicht standardisierte Variablen.
- `funs-is-binary`: `has_two_values()` gibt die Anzahl statt TRUE/FALSE zurück.
- `effectsize-groups`: Tippfehler, `d_to_cles(1.48)` fest eingetragen.
- `exzessiv1`: Die Lösung ist leer, Option 5 ist grammatisch kaputt.
- `einsamkeit-modellierung`: „verringert die Einsamkeit“ statt vermutlich „erhöht“.
- `exp2`, `exp2-schoice`: λ = 1 ist fest, gefragt wird aber „je größer λ“.
- `ttest-aussagen`: `schoice` mit drei Einsen in `exsolution`, eine Option steht doppelt.
- `typ-fehler-r-04`: Die angeblich fehlerhafte Syntax läuft fehlerfrei.
- `verteilungen-quiz-03-b`: `exsolution: 001‚` ist kaputt (vermutlich `0001`).
- `verteilungen-quiz-09`: `exsolution: 01`, laut Lösung aber `10`. Die Lösungs-Answerlist fehlt.
- `wertzuweisen_mc`: Mehrere Optionen sind syntaktisch korrekt.
- `vorhersageintervall1`: Die Beschreibungen von KI und Vorhersageintervall sind vertauscht, außerdem `mean(147)`.
- `viz-geom-point5`: Die Lösung verweist auf „Diagramm E“.
- `ungewiss-arten-regr_var1`: Der Text nennt fest `carb`, der Prädiktor wird aber zufällig gezogen.
- `verteilungen-quiz-17`, `-18`: Der Hinweis verlangt 10^5 Ziehungen, die Lösung nutzt 10^4.
- `verteilungen-quiz-16`: Tippfehler `N(180,06)`.
- `vis-mtcars`: Der Codebook-Link zeigt auf penguins.
