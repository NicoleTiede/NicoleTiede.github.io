#!/usr/bin/env bash
# Stellt zusammen, was GitHub Pages ausliefert:
#   /                    die Seite aus docs/ (Stand des ausgecheckten Zweigs, also main)
#   /vorschau/pr-<Nr>/   docs/ jedes offenen Pull Requests aus diesem Repository
# Aufruf: seite-bauen.sh <zielordner>   (braucht gh und GITHUB_REPOSITORY)
# Auf der Standardausgabe steht je Vorschau eine Zeile "<Nr> <Commit>", alles andere geht nach stderr.
# Aus Pull Requests werden nur Dateien kopiert, nie Code ausgeführt. Ein fehlerhafter Pull Request
# kostet höchstens seine eigene Vorschau, nie die Veröffentlichung der Seite.
set -euo pipefail

ziel=${1:?Zielordner fehlt}
: "${GITHUB_REPOSITORY:?}"

mkdir -p "$ziel"
cp -R docs/. "$ziel/"

# Pull Requests aus Forks bleiben außen vor: Fremde Inhalte sollen nicht unter dieser Adresse erscheinen.
liste=$(gh pr list --repo "$GITHUB_REPOSITORY" --state open --base main --limit 50 \
  --json number,headRefOid,isCrossRepository \
  --jq '.[] | select(.isCrossRepository | not) | "\(.number) \(.headRefOid)"')

while read -r nr sha; do
  [ -n "$nr" ] || continue
  ordner="$ziel/vorschau/pr-$nr"
  mkdir -p "$ordner"
  if ! git fetch --quiet --depth 1 origin "$sha" >&2 ||
    ! git archive "$sha" docs | tar -x -C "$ordner" --strip-components=1; then
    echo "::warning::Keine Vorschau für Pull Request #$nr: docs/ ließ sich nicht lesen." >&2
    rm -rf "$ordner"
    continue
  fi
  find "$ordner" -type l -delete

  # Vorschauen kennzeichnen, von Suchmaschinen fernhalten und Pfade ab der Wurzel (404.html) umbiegen
  find "$ordner" -name '*.html' -type f -print0 | NR="$nr" REPO="$GITHUB_REPOSITORY" xargs -0 perl -0pi -e '
    my $leiste = qq{<div style="background:#ffd23f;color:#1a1400;font:600 14px/1.5 system-ui,sans-serif;text-align:center;padding:6px 16px">}
      . qq{Vorschau zu <a style="color:inherit" href="https://github.com/$ENV{REPO}/pull/$ENV{NR}">Pull Request #$ENV{NR}</a> – noch nicht veröffentlicht</div>};
    s{<meta name="robots"[^>]*>}{}g;
    s{<head>}{<head>\n  <meta name="robots" content="noindex">};
    s{<body>}{<body>\n$leiste};
    s{\b(href|src)="/(?!/)}{$1="/vorschau/pr-$ENV{NR}/}g;
  '
  rm -f "$ordner/sitemap.xml" "$ordner/robots.txt"
  echo "$nr $sha"
done <<< "$liste"
