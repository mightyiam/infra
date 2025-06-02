# Shahar "Dawn" Or (mightyiam)'s personal Nix-powered IT infrastructure repository

> [!NOTE]
> If you have any questions or suggestions for me, please use the discussions feature or contact me.
> I hope you find this helpful.

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

## Integrated flake input forks

- 🕺 no need to use the `--override-input` flag
- 🤔 forks are in the same repository in which they are used
  (whatever that may mean to you)
- 😮‍💨 involvement of submodules may incur operational overhead (e.g. `git submodule update`)

While I attempt to have an upstream-first approach,
There are typically periods in which a branch with changes on top of upstream exists.
I refer to such a branch as an _input fork_.

All my input fork branches are stored in this very repository.
Yes, even though they are branches from disparate repositories,
they are stored in this repository.

They are then checked out locally as git submodules.
Yes, this very repository is a submodule within itself (possibly multiple times).
But the submodules don't typically share any history with the repository itself,
so this is not _that_ weird.

Finally, flake input path URLs are used to refer to them.

### Creating an input fork

An input fork is created by running `nix run .#input-forks-add <input> <upstream-url> <rev> <base-ref>`.

- `input`: name of the flake input
- `upstream-url`: git URL of the upstream repo
- `rev`: upstream rev to fork at
- `base-ref`: base ref for future rebasing, such as `main`

> [!TIP]
> The `rev` should probably be the one to which that input is currently locked.
> Run `nix flake metadata` to see what rev that is.

For example

```console-session
$ nix run .#input-fork-add flake-parts https://github.com/hercules-ci/flake-parts 64b9f2c2df31bb87bdd2360a2feb58c817b4d16c
```

And you end up with a git submodule at `./forks/<input>`.
It can be used this way:

```nix
{
  inputs.flake-parts.url = "./forks/flake-parts";
}
```

### Cherry picking for an input fork

1. `cd forks/<input>`
1. Get on the `forks/<input>` branch.
1. Add a remote for a fork and `git cherry-pick` from it.
1. Make sure to push.

### Rebasing an input fork

To rebase an input fork (or fail to do so):
`nix run .#input-fork-rebase <input>`

For example

```
$ nix run .#input-fork-rebase flake-parts
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
