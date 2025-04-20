# Shahar "Dawn" Or (mightyiam)'s personal Nix-powered IT infrastructure repository

> [!IMPORTANT]
> If you have any questions or suggestions for me, please use the discussions feature or contact me.
> I hope you find this helpful.

## Every Nix file is a [flake-parts](https://flake.parts) module

> [!NOTE]
> This pattern has been the inspiration of [an auto-imports library, import-tree](https://github.com/vic/import-tree).

File paths convey what the contents mean to me, as opposed to adhering to a mechanism's design.
Because each file, being a flake-parts module, can declare any number of nested modules (e.g. NixOS, Home Manager, NixVim).
Thus, a single file can implement cross-cutting concerns.
For example, see the [`time`](modules/time.nix), [`ssh`](modules/ssh.nix), [`languages/rust`](modules/languages/rust.nix), and [`catppuccin`](modules/catppuccin.nix) modules.

I have previously threaded `self` once from the flake-parts evaluation through to NixOS evaluation and a second time deeper into Home Manager evaluation.
Instead, in this pattern, the flake-parts `config` can always be in scope when needed.

> Massive, very interesting!

—[drupol](https://discourse.nixos.org/t/pattern-every-file-is-a-flake-parts-module/61271/2?u=mightyiam)

> I adore this idea by @mightyiam of every file is a flake parts module and I think I will adopt it everywhere.

—[Daniel Firth](https://x.com/locallycompact/status/1909188620038046038)

> I’ve adopted your method. Really preferring it.

—[gerred](https://x.com/devgerred/status/1909206297532117469)

## Configurations are declared by prefixing a module's name

This spares me of some boilerplate.
For example, see [`termitomyces/imports`](modules/termitomyces/imports.nix) module.

## Automatic import

All Nix files (they're all flake-parts modules) are automatically imported.
No literal path imports are used.
This means files can be moved around and nested in directories freely.

> [!NOTE]
> Nix files prefixed with an underscore are ignored.

## Named modules as needed

> [!NOTE]
> Named modules are modules under the [`flake.modules`](https://flake.parts/options/flake-parts-modules.html) option.

I was once tempted to name them with great granularity, as to for example have `flake.modules.nixos.fonts`.
Such granularity would result in a great number of named modules.
One cost of such a pattern is that some `imports` lists would be longer than they need to be.
Another cost is that when a new file is created, some more imports would typically have to be added to some of those lists.

For example, the `flake.modules.nixos.desktop` module would have to import `with config.flake.modules.nixos; [fonts ssh audio <...and many more>]`.
That's redundant; for one, the flake-parts module file in which for example `flake.modules.nixos.fonts` is defined is at `modules/fonts.nix`.
Second, all modules that would import the `flake.modules.nixos.fonts` would also import `flake.modules.nixos.audio`.
The pattern used instead is that `modules/fonts.nix` defines `flake.modules.nixos.desktop`.

So what is the test for whether a certain set of option values deserves a distinct named module?
It is whether that named module will (_today_ not tomorrow) be imported in some modules and not in others.
An example of a set of option values that deserve a distinct named module is `flake.modules.nixos.mobile-device`
because it is imported by laptop configurations and not by desktop configurations.

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
