# Python Language Server Protocol (LSP) Flatpak

Flathub is the central place for building and hosting Flatpak builds.

## For maintainers

### Python packages with Maturin as build system

Python packages with Maturin as build system need some additional manual steps to get working. You will have to have
Rust enabled for compilation and pull in additional dependencies. See `python3-ruff.json` for example.

You can generate Maturin's dependencies with another generator provided by the Flatpak Builder Tools. Clone
the Maturin repo in the corresponding version you need and run:
`python3 flatpak-builder-tools/cargo/flatpak-cargo-generator.py <...>/Cargo.lock -o modules/cargo-sources-maturin.json`

