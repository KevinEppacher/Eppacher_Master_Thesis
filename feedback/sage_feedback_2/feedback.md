Hallo Kevin,

anbei ist wie besprochen das Feedback. Grundsätzlich geht die Argumentation in eine gute Richtung; die Struktur leidet aber vor allem in Ch2 unter sehr eingeschränkter Übersicht. Ch2 sollte nicht einfach nur eine Aufzählung von bestehenden Methoden sein, sondern diese in verschiedene Verfahren/Methodengruppen gruppieren. Das macht man, weil durch ähnliche Methodik sich oft ähnliche Vor- und Nachteile ergeben (z.B. nicht-Interpretierbarkeit und schlechter Domänentransfer von RL-Methoden). Diese Muster sind der eigentliche Insight von Ch2 und das fehlt aktuell etwas. Ich habe unten und in der annotierten PDF einige Anmerkungen zur Verbesserung der Übersicht hinterlassen; bitte achte auch auf die Vermeidung von Umgangssprache und Belegung aller Behauptungen durch Quellen (vor allem in Ch1 -> Da musst du auf Basis von Quellen argumentieren).
 
Bitte passe auch bei der PDF-Größe auf; sonst bekommst du Probleme beim CIS-Upload.
 
Schöne Feiertage und einen guten Rutsch!
 
Liebe Grüße,

Simon
 
 
1. Hier einige Quellen zu dieser Forschung angeben (ist quantifizierbarer als das Wort "essential")

2. Hier mit wesentlich mehr Detail anhand von Quellen argumentieren -> Das ist der springende Punkt und kann ruhig einen Absatz lang sein

3. "All of these methods are capable of navigating to a goal described in natural language, however, they differ in zero-shot applicability to new scenes and real-time capability."

4. Hier Kapitel "1.2  Language-Embedded Semantic Mapping" starten. Führe hier den Task von semantischer Kartographierung etwas detaillierter ein und motiviere, warum das wichtig/cool ist. Wenn du hier etwas mehr ausholst, kannst du schöner in der Contribution darauf überführen, dass eine Kombination der beiden Felder Sinn macht

5. Nur ganze Sätze als Abbildungs-/Tabellenbeschreibung. Hier fehlt z.B. das Verb. Bitte mehr ausführen, sodass die Tabelle ohne Fließtext verständlich ist (wichtig für die Masterprüfung)

6. Ich würde diesen Absatz umstrukturieren. Du willst hier auf die Probleme hinaus, also hier nur jedes der Probleme einführen und erklären

7. "The proposed method is evaluated w.r.t."

8. Hier einen Überblick über die anderen Kapitel verschaffen, aber nicht zu "meta" werden. Du kannst davon ausgehen, dass Lesende bereits wissen, was in einem State of the Art Kapitel stehen muss. Deshalb hier an die Contribution anknüpfen. Z.B. so: This work introduces ... , which combines the fields of ... based on the successes encountered by incorporating semantic information from large pretrained foundation models into traditional exploration and mapping pipelines. However, these novel semantic methods still rely on design and data representation patterns derived from classic geometric exploration and mapping methods (e.g., semantic frontier exploration or voxel-based occupancy-grid mapping). -> Dann auf natürliche Weise einführen, was das restliche Kapitel zeigt.

9. 1 Satz, dass Frontier-based Exploration standard ist (mit Quelle)

10. "integrating A with B", ohne konkret zu sagen, was da passiert, ist gefährlich ChatGPT. Bitte präzise Formulieren. Hier Besser: "... deriving navigation policies from semantic visual understanding." 

11. Ein Problem, das ich hier sehe -> Reward (und einige Abkürzungen wie z.B. DRL) wird nie eingeführt. Es fehlen die Grundlagen. Das macht man in Papern nicht, muss aber in einer These inkludiert sein. Ich würde das so machen: 

	* In 2.0 den Unterschied zwischen RL Methoden und Foundation Model Methoden erklären (inkl. Vor- und Nachteile)

	* 2.2. zu RL-based semantic exploration umbenennen

	* Ein 2.3 Kapitel zu "Foundation Model-based Semantic Exploration" einführen. Dann hast du das klarer getrennt und kannst schöner gruppieren

12. Gleiches Problem wie Punkt 11. Bitte hier auch zunächst die Methodik hinter der Gruppierung einführen
 