# Shahar "Dawn" Or (mightyiam)'s personal Nix-powered IT infrastructure repository

## Every Nix file is a flake-parts module

File paths convey what the contents mean to me, as opposed to adhering to a mechanism's design.
Because each file, being a flake-parts module, can declare any number of nested modules (e.g. NixOS, home-manager, nixvim).
Thus, a single file can implement cross-cutting concerns.
For example, see the [`time`](modules/time.nix), [`ssh`](modules/nix.nix), [`rust`](modules/rust.nix), [`catppuccin`](modules.catppuccin.nix) and [`nix`](modules/nix.nix) modules.

I have previously threaded `self` once from the flake-parts evaluation through to NixOS evaluation and a second time deeper into home-manager evaluation.
Instead, in this pattern, the flake-parts `config` can always be in scope when needed.

## Configurations are declared by prefixing a module's name

This spares me of some boilerplate.
For example, see [`termitomyces/imports`](modules/termitomyces/imports.nix) module.

## Automatic import

All Nix files (they're all flake-part modules) are automatically imported.
No literal path imports are used.
This means files can be moved around and nested in directories freely.
