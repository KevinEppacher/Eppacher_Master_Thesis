Hallo Kevin,
anbei ist mein Feedback. Die annotierte PDF ist auf Teams; unten sind die nummerierten Anmerkungen in chronologischer Reihenfolge (Zahl im PDF = Zahl in der Anmerkung unten).

Grundsätzlich passt die Arbeit größtenteils, es gibt aber noch einige sprachliche und Format-Aspekte, die mir aufgefallen sind. Die zwei Wichtigsten: 1) es finden sich einige nicht-quantifizierbare Floskeln (ich nenne sie ganz gerne ChatGPT Floskeln) in der Arbeit. Die dritte Annotation. 2) Ch3 vermischt Methode und Implementierung teilweise. Hier aufpassen; in Ch3 geht es nur um die Methode, da ist noch nicht von ROS 2 oder von Topics die Rede. Hier gibt es nur Mathematik und Algorithmik. Vor allem die Topic-Namen in einigen der Abbildungen vermeiden

Bitte melde dich bei Fragen/Unklarheiten.

Liebe Grüße,
Simon

 

Allgemeine Punkte

* Aufpassen bei der Größe der Arbeit (hauptsächlich durch Abbildungen) -> CIS nimmt nur eine gewisse Größe (ich glaube 80Mb -> Bitte im Tool checken, ich habe da keinen Zugriff darauf)
* Deutsches und Englisches Abstract vertauscht, Keywords auf englisch fehlen
* Aufpassen bei Referenz zu Formeln. Verwendung im Satzbau ist unschön in Thesen, hat sich aber so wie das inoffizielle "we/our" in Engingeering Papern durchgesetzt. Ich würde das aber nicht machen. Bitte auch schauen, dass (see Equation x) und die Verwendung im Satzbau nicht vermischt sind (siehe FOrmel 7).
* Aufpassen, es gibt Phrasen, die sehr nach LLM klingen. Die sind in der Regel sehr schwammig und sollten vermieden werden (egal ob durch LLM generiert oder nicht). Beispiele sind comprehensive, defining, essential, representative, powerful, framework, integrate x with y. Vor allem representative wird in der Arbeit sehr oft verwendet -> Das ist nicht quantifizierbar
* Alle Abkürzungen einführen
* Wenn der Name der Autor*innen angeschrieben wird, dann trotzdem nachher ein normales Zitat einfügen (damit Klarheit bei mehreren gleichen Erstautor*innen). Das ist manchmal so, manchmal so in der Arbeit
* Tabellen/Abbildungen und Text so setzen, dass keine Leerstellen entstehen (z.B. S.26)
* Abbildungen in Ch3 sind teilweise sehr groß -> Nur so groß wie möglich, sonst meinen Lesende, dass die Läng gestreckt wurde
* Odometry in den Abb ausschreiben
* Aufpassen in Literaturverzeichnis -> bereits veröffentlichte Beiträge nicht als Arxiv Preprint zitieren


Nummerierte Punkte

<!-- 1. Hier die drei Kategorien (=die nächsten drei Unterkapitel) jeweils einmal in einem Satz grob definieren -->
<!-- 2. Math. Notation für policy $\pi$ und Loss $\mathcal{L}$ nicht eingeführt -->
<!-- 3. Text in Tabelle left aligned halten, sonst nur schwer lesbar -->
4. In der Tab sind zwei Fehler -> Ich hatte das noch im Kopf vom letzten Paper. Bitte bei den restlichen Tabellen selber checken, dass das eh stimmt. TODO!!!
<!-- 5. Hier mit 1), 2), ... oder a), b), c), ... durchnummerieren und in Tabelle entsprechend beschriften -->
<!-- 6. Hier aufpassen, dass bei der Prüfung nicht angekreidet wird, ob das nur ein Zusammenstöpseln bestehernder Modelle ist. Bitte die konkreten Modellbeschriftungen durch die jeweilige Methode ersetzen. Bitte auch Abb-Beschriftung mind 3 Zeilen kürzen -> Das ist zu lang im Vergleich zur Abbildung -->
7. Kommentare right-aligned, dass die gleichmäßig übereinander sind
7.1. Algorithmen caption
8. Hier geht's um die Methode -> Topicnamen und Nodenamen weglassen. Fokus ist hier Algorithmik
9. Die ganzen Algorithmik-Blöcke konsistent gestalten
<!-- 10. Würde ich similarity score oder nur score oder value signal oder sowas nennen. "Reward" ist in der Domäne reserviert für RL -->
<!-- 11. "Robust" ist gefährlich -> Du kannst das nicht quantifizieren -->
<!-- 12. Das ist interessant -> Ein Satz extra Detail und Begründung hinzufügen -->
<!-- 13. Sehr starke Behauptung. Nur inkludieren, wenn es dazu eine Ablation gibt -->
<!-- 14. "layered costmap planning (Move Base Flex Paper als Quelle)." -->
<!-- 15. Horizontal umformatieren -> Sieht sonst etwas ungeschickt aus -->
<!-- 16. Hier sind viele nicht quantifizierbare Bewertungen (z.B. "robust"). Weglassen, bewertet wird vor den Resultaten nicht und wenn dann nur quantifizierbar -->
17. Nicht die beiden Tabellen direkt hintereinander. Verschieben oder in Eine zusammenfassen
18. Results and Discussion -> Results sind wichtiger und müssen deshalb vorne stehen
19. IQR wirt bei den Metriken nicht eingeführt -> Du musst dort begründen, warum das inkludiert wird (denk daran, was wir beim letzten Meeting besprochen haben)
20. Bestes Ergebnis immer Fett und Zweitbestes Unterstrichen (für jede Metrik einzeln)
21. Das ist viel zu groß -> Text in Abb ca. so groß wie Fließtext
22. Würde ich hier weglassen -> Ist egal für die Summary

SAGE pipeline vergleich fragen
