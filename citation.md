Kurz und systematisch, **bezogen auf IEEE mit `biblatex` (z. B. `style=ieee`)**.

Der **Entry-Typ steuert**,

1. **welche Felder erwartet werden**,
2. **in welcher Reihenfolge sie ausgegeben werden**,
3. **welche Satzzeichen / Labels erscheinen** (In:, vol., no., pp., etc.).

---

## 1. `@article` (Journal Paper)

**Verwendet für:**
Zeitschriften, Journals, RA-L, T-RO, Sensors, IJRR, etc.

### Typische Ausgabe (IEEE)

```
A. Author and B. Author, “Title,” Journal Name,
vol. X, no. Y, pp. 123–130, Year.
```

### Wichtige Felder

```bibtex
journal   = {...}
year      = {...}
volume    = {...}
number    = {...}
pages     = {...}
doi       = {...}
```

### Charakteristika

* **Kein „In:“**
* **volume / number zwingend erwartet**
* Sieht *sehr kompakt* aus
* Beste Priorität in IEEE (hochwertigste Kategorie)

---

## 2. `@inproceedings` (Konferenzpaper)

**Verwendet für:**
ICRA, IROS, CVPR, ICCV, NeurIPS, RSS, ICML, etc.

### Typische Ausgabe

```
A. Author, “Title,” in Proc. IEEE Int. Conf. on …,
pp. 123–130, Year.
```

### Wichtige Felder

```bibtex
booktitle = {...}
year      = {...}
pages     = {...}
doi       = {...}
```

### Charakteristika

* **Immer „in Proc. …“**
* `eventtitle`, `booktitleaddon` → *nur Zusatz*
* Sauberer Zeilenumbruch **wenn booktitle nicht zu lang**
* IEEE-Standard für Konferenzen

---

## 3. `@book` (Monographie / Lehrbuch)

**Verwendet für:**
Springer Books, MIT Press, Cambridge, etc.

### Typische Ausgabe

```
A. Author, Book Title. City, Country: Publisher, Year.
```

### Wichtige Felder

```bibtex
publisher = {...}
year      = {...}
location  = {...}
isbn      = {...}
doi       = {...}
```

### Charakteristika

* **Kein Journal, keine Proceedings**
* Titel oft kursiv
* **Untertitel besser mit `subtitle`** (verhindert Overfull hbox)
* Sehr stabiler Umbruch

---

## 4. `@misc` (Preprints, arXiv, Reports, Anything Else)

**Verwendet für:**
arXiv, Technical Reports, unveröffentlichte Arbeiten

### Typische Ausgabe

```
A. Author, “Title,” arXiv preprint arXiv:XXXX.XXXXX, Year.
```

### Wichtige Felder

```bibtex
year
note
eprint
archivePrefix
url
```

### Charakteristika

* **Flexibel, aber minimal**
* Kein „in“, kein Journal
* IEEE behandelt es als „graue Literatur“
* **Best choice für arXiv**

---

## 5. Warum dein Layout „kaputt geht“

Das ist entscheidend:

### ❌ Falscher Typ ⇒ falsche Struktur

| Problem                  | Ursache                                   |
| ------------------------ | ----------------------------------------- |
| Text läuft über den Rand | zu langer `booktitle` + `@inproceedings`  |
| DOI bricht hässlich      | IEEE druckt DOI **inline**, nicht als URL |
| arXiv sieht komisch aus  | `@online` statt `@misc`                   |
| Doppelter Titel          | `title` + `shorttitle` falsch kombiniert  |

---

## 6. **Entscheidungsregel (MERKEN!)**

```text
Journal erschienen?        → @article
Konferenz erschienen?     → @inproceedings
Buch?                      → @book
arXiv / Preprint / unsure? → @misc
```

---

## 7. Konkrete Empfehlung für deine Thesis

Du bist **100 % richtig**, arXiv zu verwenden, **wenn**:

* die offizielle Version schlecht formatiert
* oder noch instabil ist

➡ **Dann aber konsequent:**

* `@misc`
* `note = {arXiv preprint arXiv:...}`
* **kein `@online`**
* **kein ISO-Datum**

---

Wenn du willst, machen wir als nächsten Schritt:

* ✅ **eine Checkliste**, wann ein Eintrag „IEEE-safe“ ist
* oder
* ✅ **automatische Umwandlungsregeln** (z. B. *„alles arXiv → @misc“*)

Sag mir, wie strikt du es willst.
