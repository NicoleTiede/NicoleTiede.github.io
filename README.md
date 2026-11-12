# Zumba in Müllheim mit Nicole Tiede

Quelltext der Seite <https://nicoletiede.github.io/>: Zumba® und Zumba® Kids mit Nicole Tiede beim TV Müllheim.

Die Seite besteht aus einfachem HTML und CSS. Es gibt keinen Build-Schritt und keine Abhängigkeiten.

## Aufbau

```
docs/                  wird von GitHub Pages veröffentlicht
  index.html           Startseite
  impressum.html
  datenschutz.html
  404.html             erscheint bei unbekannten Adressen
  robots.txt
  sitemap.xml
  .nojekyll            GitHub Pages liefert die Dateien unverändert aus
  assets/
    css/style.css      Gestaltung; Farben stehen als Variablen am Dateianfang
    js/theme.js        Umschalter hell/dunkel
    img/               Bilder
```

Alles außerhalb von `docs/` wird nicht veröffentlicht.

## Veröffentlichung

GitHub Pages ist auf den Zweig `main` und den Ordner `/docs` eingestellt
(Settings → Pages → Deploy from a branch). Jede Änderung auf `main` ist nach ein bis zwei Minuten online.

## Lokal ansehen

```
python3 -m http.server 8000 --directory docs
```

Danach <http://localhost:8000> im Browser öffnen.

## Inhalte ändern

- Kurszeiten und Preise: `docs/index.html`, Abschnitt „Die Kurse“
- Ausbildungen und Zertifikate: `docs/index.html`, Abschnitt „Über Nicole“
- Farben für hell und dunkel: Variablen am Anfang von `docs/assets/css/style.css`
- Bilder: `docs/assets/img/`. Vor dem Hochladen Standortdaten entfernen und auf höchstens 1200 px Breite verkleinern.

## Rechte

Texte und Fotos gehören Nicole Tiede und stehen unter keiner freien Lizenz.

Zumba®, Zumba® Kids und die Zumba-Fitness-Logos sind Marken der Zumba Fitness, LLC und werden unter Lizenz verwendet.
Die Kurse sind ein Angebot des Turnvereins Müllheim 1863 e.V.
