{
  nixConfig = {
    abort-on-warn = true;
    extra-experimental-features = [ "pipe-operators" ];
    allow-import-from-derivation = false;
  };

  inputs = {
    catppuccin = {
      # https://github.com/catppuccin/nix/issues/289
      url = "github:catppuccin/nix/58d020d4c85416e2a75ec820e290d3d5b13b3427";
    };

    catppuccin-qutebrowser = {
      flake = false;
      url = "github:catppuccin/qutebrowser";
    };

    cpu-microcodes = {
      flake = false;
      url = "github:platomav/CPUMicrocodes";
    };

    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-compat.url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs-docs.follows = "nixpkgs";
        nixpkgs-for-bootstrap.follows = "nixpkgs";
        nixpkgs.follows = "nixpkgs";
      };
    };

    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";

    nixpkgs.url = "nixpkgs/nixpkgs-unstable";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        nuschtosSearch.follows = "nuschtos-search";
      };
    };

    nuschtos-search = {
      url = "github:NuschtOS/search";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    refjump-nvim = {
      flake = false;
      url = "github:mawkler/refjump.nvim";
    };

    sink-rotate = {
      url = "github:mightyiam/sink-rotate";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
        devshell.follows = "devshell";
      };
    };

    smart-scrolloff-nvim = {
      flake = false;
      url = "github:tonymajestro/smart-scrolloff.nvim";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ucodenix = {
      url = "github:e-tho/ucodenix";
      inputs.cpu-microcodes.follows = "cpu-microcodes";
    };

    vim-autoread = {
      flake = false;
      url = "github:djoshea/vim-autoread/24061f84652d768bfb85d222c88580b3af138dab";
    };

    zsh-auto-notify = {
      flake = false;
      url = "github:MichaelAquilina/zsh-auto-notify";
    };
  };

  outputs =
    inputs:
    let
      lib = inputs.nixpkgs.lib;
      modulesPath = ./modules;
    in
    inputs.flake-parts.lib.mkFlake
      {
        inherit inputs;
        specialArgs = {
          lib = lib // {
            inherit (inputs.nixvim.lib) nixvim;
          };
        };
      }
      {
        imports =
          modulesPath
          |> lib.filesystem.listFilesRecursive
          |> lib.filter (lib.hasSuffix ".nix")
          |> lib.filter (
            path:
            path
            |> lib.path.removePrefix modulesPath
            |> lib.path.subpath.components
            |> lib.all (component: !(lib.hasPrefix "_" component))
          );

        systems = [
          "x86_64-linux"
          "aarch64-linux"
        ];
      };
}
