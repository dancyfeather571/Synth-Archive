#!/bin/sh
# Build a release zip of the Synth-Archive expansion. Reads the source folder only.
# Usage: scripts/package-release.sh <path-to-Expansions/Synth-Archive> <version>
set -eu

src=${1:?usage: $0 <expansion-dir> <version>}
ver=${2:?usage: $0 <expansion-dir> <version>}
[ -f "$src/expansion_info.xml" ] || { echo "not an expansion: $src" >&2; exit 1; }

# Every sample map needs its compiled monolith, or its presets play silence.
missing=0
for map in "$src"/SampleMaps/*.xml; do
  name=$(basename "$map" .xml)
  [ "$name" = "Empty Layer" ] && continue
  [ -f "$src/Samples/$name.ch1" ] || { echo "missing monolith: $name" >&2; missing=1; }
done
[ "$missing" -eq 0 ] || { echo "export the monoliths above first" >&2; exit 1; }

out=$(cd "$(dirname "$0")/.." && pwd)/dist
stage=$(mktemp -d)
trap 'rm -rf "$stage"' EXIT
dst="$stage/Synth-Archive"
mkdir -p "$dst/Samples"

cp "$src/expansion_info.xml" "$dst/"
for d in Images SampleMaps AudioFiles UserPresets; do
  [ -d "$src/$d" ] && cp -R "$src/$d" "$dst/"
done
cp "$src"/Samples/*.ch1 "$dst/Samples/"
find "$dst" \( -name '.DS_Store' -o -name 'Icon?' -o -name '*.bak' -o -name '*~' \) -delete

mkdir -p "$out"
zip="$out/Synth-Archive-$ver.zip"
rm -f "$zip"
(cd "$stage" && zip -rqX "$zip" Synth-Archive)
(cd "$out" && shasum -a 256 "$(basename "$zip")" > "$(basename "$zip").sha256")
echo "wrote $zip"
