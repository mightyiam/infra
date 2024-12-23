{
  nixConfig.extra-experimental-features = [ "pipe-operators" ];

  inputs = {
    catppuccin.url = "github:catppuccin/nix";

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
        nixpkgs-stable.follows = "nixpkgs";
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

    nixpkgs.url = "nixpkgs/nixpkgs-unstable";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        devshell.follows = "devshell";
        flake-compat.follows = "flake-compat";
        flake-parts.follows = "flake-parts";
        git-hooks.follows = "git-hooks";
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
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

    swayr = {
      flake = false;
      url = "git+https://git.sr.ht/~tsdh/swayr?rev=0512a9fadc43c64f25afbc9db39c1286b4ac1a8c";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ucodenix.url = "github:e-tho/ucodenix";

    vim-autoread = {
      flake = false;
      url = "github:djoshea/vim-autoread/24061f84652d768bfb85d222c88580b3af138dab";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./boot-message.nix
        ./catppuccin.nix
        ./codeberg.nix
        ./drv-paths.nix
        ./fmt.nix
        ./git-hooks.nix
        ./home-manager-modules
        ./lib.nix
        ./meta.nix
        ./nix-on-droid-configurations
        ./nixos-configurations.nix
        ./nixos-modules
        ./nixvim
        inputs.devshell.flakeModule
      ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
    };
}
