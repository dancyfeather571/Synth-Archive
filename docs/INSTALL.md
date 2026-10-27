# Installation

> The expansion download is **not available yet** (see [LICENSING.md](../LICENSING.md)). These steps describe how it will be installed once released.

## Requirements

- The **Fraction** plugin (built against Fraction 1.2.0)
- About 1 GB of free disk space

## Steps

1. Download `Synth-Archive-<version>.zip` from this repository's **Releases** page.
2. Check the download against the `.sha256` file published with the release:
   ```sh
   shasum -a 256 -c Synth-Archive-<version>.zip.sha256
   ```
3. Unzip it. You get one folder named `Synth-Archive`.
4. Move that folder into Fraction's `Expansions` folder, next to your other expansions. Keep the folder name exactly `Synth-Archive`; presets and sample maps refer to it as `{EXP::Synth-Archive}`.
5. Restart Fraction. **Synth-Archive** appears in the expansion browser with 60 presets in eight categories.

## Troubleshooting

- **Silent preset or missing-sample warning:** the folder was probably renamed or nested (`Synth-Archive/Synth-Archive`). Move the inner folder up so `expansion_info.xml` sits directly inside `Expansions/Synth-Archive/`.
- **Expansion not listed:** make sure `expansion_info.xml` is in the folder, then restart the host.
