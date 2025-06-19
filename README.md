![Sci-fi looking server room](./modules/meta/logo/logo.jpg)

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

## Configurations are declared by prefixing a module's name

This spares me of some boilerplate.
For example, see [`termitomyces/imports`](modules/termitomyces/imports.nix) module.

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

- `README.md`
- `.github/workflows/check.yaml`
- `.gitignore`
- `LICENSE`

## Named modules as needed

> [!NOTE]
> Named modules are modules under the [`flake.modules`](https://flake.parts/options/flake-parts-modules.html) option.

I was once tempted to name them with great granularity, as to for example have `flake.modules.nixos.fonts`.
Such granularity would result in a great number of named modules.
One cost of such a pattern is that some `imports` lists would be longer than they need to be.
Another cost is that when a new file is created, some more imports would typically have to be added to some of those lists.

For example, the `flake.modules.nixos.pc` module would have to import `with config.flake.modules.nixos; [fonts ssh audio <...and many more>]`.
That's redundant; for one, the flake-parts module file in which for example `flake.modules.nixos.fonts` is defined is at `modules/fonts.nix`.
Second, all modules that would import the `flake.modules.nixos.fonts` would also import `flake.modules.nixos.audio`.
The pattern used instead is that `modules/fonts.nix` defines `flake.modules.nixos.pc`.

So what is the test for whether a certain set of option values deserves a distinct named module?
It is whether that set of option values is to be imported in some configurations and not in others.
An example of a set of option values that would deserve a distinct named module is `flake.modules.nixos.laptop`
because it would be imported by laptop configurations and not by desktop configurations.

## Integrated patched flake inputs pattern

- 🪶 edit/patch the repo's inputs without leaving its clone directory
- 🕺 no `--override-input` flag; less typing and avoids confusion in case omitted
- 🐬 single-repo setup; less to keep track of, more self-contained
- ⚡ provided scripts save time and produce consistency
- 😮‍💨 some mental and operational overhead such as an occasional `git submodule update`

I attempt to maintain an upstream-first approach.
That means contributing my changes to inputs upstream.
While collaborating with upstream on the refinement and merge of those changes
I maintain a branch of that input with those changes cherry-picked.
I call these branches _integrated patched flake inputs_ (IPFIs).

IPFIs are stored in this very repository.
Yes, even though they are branches from disparate repositories,
they are stored in the repository in which they are used.
Git doesn't mind.

For each IPFI a git submodule exists.
That submodule is a clone of this very same repository.
The head of that submodule is set to the head of the IPFI branch.

Finally, each `inputs.<name>.url` value is a path to the corresponding IPFI submodule directory.

> [!WARNING]
> There seems to be an issue with Nix that affects the IPFI pattern.
> Workaround: artificially make the repository dirty.

### Creating an IPFI

An IPFI is created by running `ipfi-add <input> <upstream-url> <rev> <base-ref>`.

- `input`: name of the flake input
- `upstream-url`: git URL of the upstream repo
- `rev`: upstream rev to branch from
- `base-ref`: base ref for future rebasing, such as `main`

> [!TIP]
> The `rev` should probably be the one to which that input is currently locked.
> Run `nix flake metadata` to see what rev that is.

For example

```console-session
$ ipfi-add flake-parts https://github.com/hercules-ci/flake-parts 64b9f2c2df31bb87bdd2360a2feb58c817b4d16c
```

And you end up with a git submodule at `./patched-inputs/<input>`.
It can be used this way:

```nix
{
  inputs.flake-parts.url = "./patched-inputs/flake-parts";
}
```

> [!TIP]
> You might need to work around git push limits
> such as [GitHub's](https://docs.github.com/en/get-started/using-git/troubleshooting-the-2-gb-push-limit).

### Cherry picking for an IPFI

1. `cd patched-inputs/<input>`
1. Get on the `patched-inputs/<input>` branch.
1. Add a remote for a fork and cherry-pick from it.
1. Make sure to push.

### Rebasing an IPFI

To rebase an IPFI (or run into a conflict):
`ipfi-rebase <input>`

For example

```
$ ipfi-rebase flake-parts
```

## Unfree packages

What Nixpkgs unfree packages are allowed is configured at the flake level via an option.
That is then used in the configuration of Nixpkgs used in NixOS, Home Manager or elsewhere.
See definition at [`unfree-packages.nix`](modules/unfree-packages.nix).
See usage at [`steam.nix`](modules/steam.nix).
Value of this option available as flake output:

```console
$ nix eval .#meta.nixpkgs.allowedUnfreePackages
[ "steam" "steam-unwrapped" "nvidia-x11" "nvidia-settings" ]
```

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
