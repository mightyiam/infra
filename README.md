# Shahar "Dawn" Or (mightyiam)'s personal Nix-powered IT infrastructure repository

- Every Nix file is a flake-parts module
- They're all automatically imported

File paths convey what the contents mean to me, as opposed to adhering to a mechanism's design.
Each file, being a flake-parts module, can declare any number of nested modules (e.g. NixOS, home-manager, nixvim).
Thus, a single file can implement cross-cutting concerns.
For example, see the [`time`](modules/time.nix), [`ssh`](modules/nix.nix), [`rust`](modules/rust.nix), [`catppuccin`](modules.catppuccin.nix) and [`nix`](modules/nix.nix) modules.

- Configurations are declared by prefixing a module's name

For example, see [`termitomyces/imports`](modules/termitomyces/imports.nix) module.

- No literal path imports

Files can be moved around and nested in directories freely.
