![Sci-fi looking server room](./modules/logo/logo.jpg)

<a href="https://github.com/mightyiam/infra/actions/workflows/check.yaml?query=branch%3Amain">
<img
  alt="CI status"
  src="https://img.shields.io/github/actions/workflow/status/mightyiam/infra/check.yaml?style=for-the-badge&branch=main&label=Check"
>
</a>

# mightyiam/infra

Shahar "Dawn" Or's [Nix](https://nix.dev)-powered "IT infrastructure" repository

> [!NOTE]
> I hope you find this helpful.
> If you have any questions or suggestions for me, feel free to use the discussions feature or contact me.

## Origin of the dendritic pattern

This repository follows [the dendritic pattern](https://github.com/mightyiam/dendritic)
and happens to be the place in which it was discovered by its author.

## Automatic import

Nix files (they're all flake-parts modules) are automatically imported.
Nix files prefixed with an underscore are ignored.
No literal path imports are used.
This means files can be moved around and nested in directories freely.

> [!NOTE]
> This pattern has been the inspiration of [an auto-imports library, import-tree](https://github.com/vic/import-tree).

## Generated files

The following files in this repository are generated and checked
using [the _files_ flake-parts module](https://github.com/mightyiam/files):

- `.github/workflows/check.yaml`
- `.gitignore`
- `LICENSE`
- `README.md`

## Patching of inputs

I attempt to maintain an upstream-first approach.
While collaborating with upstream on the refinement and merge of those changes
I maintain a branch of that input with those changes cherry-picked.

This repository is the origin of the
[_input branches_](https://github.com/mightyiam/input-branches)
project
which is used here.

## Refactoring

To help determine whether a Nix change results in changes to derivations,
a package `.#all-check-store-paths` builds a TOML file that maps from `.#checks`:

```toml
default-shell = "/nix/store/9nx7s96vwz2h384zm8las332cbkqdszf-nix-shell"
"nixosConfigurations/termitomyces" = "/nix/store/33iv0fagxiwfbzb81ixypn14vxl6s468-nixos-system-termitomyces-25.05.20250417.ebe4301"
"packages/nixvim" = "/nix/store/p2rrqir5ig2v4wb3whvb8y0fmdc0kmhk-nixvim"
```

> [!NOTE]
> Implemented in [`meta/all-check-store-paths`](modules/meta/all-check-store-paths.nix)

## Running checks on GitHub Actions

Running this repository's flake checks on GitHub Actions is merely a bonus
and possibly more of a liability.

Workflow files are generated using
[the _files_ flake-parts module](https://github.com/mightyiam/files).

For better visibility, a job is spawned for each flake check.
This is done dynamically.

To prevent runners from running out of space,
The action [Nothing but Nix](https://github.com/marketplace/actions/nothing-but-nix)
is used.

See [`modules/meta/ci.nix`](modules/meta/ci.nix).

## Flake inputs for deduplication are prefixed

Some explicit flake inputs exist solely for the purpose of deduplication.
They are the target of at least one `<input>.inputs.<input>.follows`.
But what if in the future all of those targeting `follows` are removed?
Ideally, Nix would detect that and warn.
Until that feature is available those inputs are prefixed with `dedupe_`
and placed in an additional separate `inputs` attribute literal
for easy identification.

## Trying to disallow warnings

This at the top level of the `flake.nix` file:

```nix
nixConfig.abort-on-warn = true;
```

> [!NOTE]
> It does not currently catch all warnings Nix can produce, but perhaps only evaluation warnings.
