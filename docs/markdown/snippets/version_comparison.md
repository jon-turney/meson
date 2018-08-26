## Version comparison for dependencies

`dependency(version:)` version constraints now handle versions containing
non-numeric characters better, by default comparing versions using the rpmvercmp
algorithm, (as using the `pkg-config` autoconf macro `PKG_CHECK_MODULES` does).

This is a breaking change for exact comparison constraints which rely on the
previous comparison behaviour of extending the compared versions with `'0'`
elements, up to the same length of `'.'`-separated elements.

For example, a version of `'0.11.0'` would previously match a version constraint
of `'==0.11'`, but no longer does, being instead considered strictly greater.

Instead, use a version constraint which exactly compares with the precise
version required, e.g. `'==0.11.0'`.

Alternative version scheme comparison algorithms can be used by prefixing the
constraint with `'scheme:'`. The only currently supported alternative comparison
is [https://semver.org/#spec-item-11](semver), e.g. `'semver:==0.11'`.

## Version comparison for meson versions

`project(meson_version:)` and meson feature checks continue to use the same
version comparison algorithm as before.

Using characters other than digits and `'.'` in the version for a
`project(meson_version:)` version constraint is now an error (previously they
were silently ignored).
