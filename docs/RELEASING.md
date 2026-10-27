# Release Plan

The sampled expansion will be distributed through **GitHub Releases**, never committed to git. Nothing is released until every item in the gate below is done.

## Why GitHub Releases

- Each release asset can be up to 2 GiB. The packaged expansion is about 950 MB, so one zip file fits.
- There is no limit on total release size or download bandwidth.
- Assets live outside the git history, so the repository stays small, and an asset can be deleted later if terms change. Anything committed to git stays in its history.
- Git LFS isn't suitable: its free quota is too small, and files in it are effectively part of the repository.

## Gate: required before any public download

- [ ] Written permission from Legowelt to redistribute his recordings, and material derived from them, inside a free sampled instrument. Keep the email or message on file.
- [ ] Origin and terms confirmed for the Kawai recordings, the Cassette Sounds, and every file under `Sources/`. Replace or remove anything that can't be cleared.
- [ ] Artwork rights confirmed (original, commissioned, or AI tool with commercial-use terms).
- [ ] Monoliths exported for the 10 sample maps that don't have one yet. `package-release.sh` lists them, and their presets will be silent without them.
- [ ] Audio license terms written into `LICENSING.md` and the release notes.

## Building the archive

```sh
scripts/package-release.sh "/path/to/Expansions/Synth-Archive" 0.1.0
```

The script:

1. Refuses to continue if any sample map lacks a `.ch1` monolith (the `Empty Layer` placeholder is skipped).
2. Copies only the playable assets: `expansion_info.xml`, `Images/`, `SampleMaps/`, `Samples/*.ch1`, `AudioFiles/`, `UserPresets/`.
3. Leaves out WAV masters outside `AudioFiles/`, `.DS_Store`, the macOS `Icon\r` file, backups, and empty dev folders.
4. Writes `dist/Synth-Archive-<version>.zip` and a `.sha256` checksum.

It only reads the live expansion and never modifies it.

## Publishing (once the gate is clear)

```sh
gh release create v0.1.0 dist/Synth-Archive-0.1.0.zip dist/Synth-Archive-0.1.0.zip.sha256 \
  --title "Synth-Archive 0.1.0" --notes-file release-notes.md
```

Then update the README's Availability section to link to the release.
