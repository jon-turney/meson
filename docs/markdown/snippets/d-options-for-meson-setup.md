## Meson now accepts the same form of builtin options at setup time and configure time

Previously meson required that builtin options (like prefix) be passed as
`--prefix` to `meson` and `-Dprefix` to `meson configure`.

`meson` now accepts the `-Dprefix` form like `meson configure` does.

`meson configure` now accepts `--prefix` form like `meson` does.
