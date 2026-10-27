# Technical Overview

Synth-Archive is a file-based expansion for the Fraction sampler (Fraction 1.2.0, expansion version 0.1.0).

## Expansion layout

```
Synth-Archive/
├── expansion_info.xml   Name, version, target project/version, tags
├── Images/artwork.png   2048×2048 cover artwork
├── SampleMaps/*.xml     Key/velocity zones, root notes, loop points
├── Samples/*.ch1        Sample monoliths (compiled audio, one per sample map)
├── AudioFiles/          Auxiliary audio (cassette/tape noise layers)
├── UserPresets/<Category>/*.preset   Fraction interface state (XML)
├── MidiFiles/           (unused)
└── AdditionalSourceCode/ (unused)
```

Total size is about 950 MB, almost all of it in `Samples/`.

## Sample maps

Each `SampleMaps/<Name>.xml` is a `<samplemap>` element with one `<sample>` per zone:

- `Root`, `LoKey`/`HiKey`: root note and key range; together the zones cover the full MIDI keyboard.
- `LoVel`/`HiVel`: velocity layers.
- `LoopEnabled`, `LoopStart`, `LoopEnd`, `LoopXFade`: sustain loops (sample frames).
- `Pitch`, `Volume`: per-zone tuning (cents) and gain (dB).
- `FileName`: an expansion-relative reference such as `{EXP::Synth-Archive}Extended/<Instrument>/<Instrument> 048 C3.wav`.

Source audio lives in these groups. Development masters are not shipped; only the compiled monoliths are.

| Group | Meaning |
|---|---|
| `Extended/` | Zones re-pitched or extended from a source note to fill the keyboard |
| `Resampled/` | Layered or processed resamples |
| `Sources/` | Original source recordings |
| `Legowelt … Sample Pack/` | Unmodified Legowelt pack files |

## Monoliths

When a sample map is exported, Fraction compiles all its referenced WAVs into one `Samples/<Name>.ch1` monolith. The expansion needs **both** the sample map XML and the matching `.ch1` file; the raw WAV masters are not needed at runtime.

## Presets

`.preset` files are XML snapshots of the Fraction interface: knob and button values, plus `presetpath_*` labels that select sample maps by expansion reference (for example `{EXP::Synth-Archive}Ashen Choir`). They are grouped into eight category folders under `UserPresets/`.

## Packaging

`scripts/package-release.sh` checks that every sample map has a monolith, then builds the release archive. See [RELEASING.md](RELEASING.md).
