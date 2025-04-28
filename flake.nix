{
  nixConfig = {
    abort-on-warn = true;
    extra-experimental-features = [ "pipe-operators" ];
    allow-import-from-derivation = false;
  };

  inputs = {
    cpu-microcodes = {
      flake = false;
      url = "github:platomav/CPUMicrocodes";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        flake-compat.follows = "dedupe_flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    import-tree.url = "github:vic/import-tree";

    make-shell = {
      url = "github:nicknovitski/make-shell";
      inputs.flake-compat.follows = "dedupe_flake-compat";
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
        nuschtosSearch.follows = "dedupe_nuschtos-search";
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
        systems.follows = "dedupe_systems";
        treefmt-nix.follows = "treefmt-nix";
      };
    };

    smart-scrolloff-nvim = {
      flake = false;
      url = "github:tonymajestro/smart-scrolloff.nvim";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs = {
        flake-compat.follows = "dedupe_flake-compat";
        flake-utils.follows = "dedupe_flake-utils";
        git-hooks.follows = "git-hooks";
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
        nur.follows = "dedupe_nur";
        systems.follows = "dedupe_systems";
        tinted-schemes.follows = "tinted-schemes";
      };
    };

    tinted-schemes = {
      flake = false;
      url = "github:tinted-theming/schemes";
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

  # _additional_ `inputs` only for deduplication
  inputs = {
    dedupe_flake-compat.url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";

    dedupe_flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "dedupe_systems";
    };

    dedupe_nur = {
      url = "github:nix-community/NUR";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
    };

    dedupe_nuschtos-search = {
      url = "github:NuschtOS/search";
      inputs = {
        flake-utils.follows = "dedupe_flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };

    dedupe_systems.url = "github:nix-systems/default";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake {
      inherit inputs;
      specialArgs = {
        lib = inputs.nixpkgs.lib // {
          inherit (inputs.nixvim.lib) nixvim;
        };
      };
    } (inputs.import-tree ./modules);
}
