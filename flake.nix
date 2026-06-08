{
  nixConfig = {
    abort-on-warn = true;
    extra-experimental-features = ["pipe-operators"];
    allow-import-from-derivation = false;
  };

  # TODO flake-file
  inputs = {
    nvim-genghis = {
      url = "github:chrisgrieser/nvim-genghis";
      flake = false;
    };

    files = {
      url = "github:mightyiam/files";
      flake = false;
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      flake = false;
    };

    import-tree = {
      url = "github:vic/import-tree";
      flake = false;
    };

    make-shell = {
      url = "github:nicknovitski/make-shell";
      flake = false;
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      flake = false;
    };

    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";

    nixvim = {
      url = "github:nix-community/nixvim";
      flake = false;
    };

    refjump-nvim = {
      flake = false;
      url = "github:mawkler/refjump.nvim";
    };

    smart-scrolloff-nvim = {
      flake = false;
      url = "github:tonymajestro/smart-scrolloff.nvim";
    };

    stylix = {
      url = "github:nix-community/stylix";
      flake = false;
    };

    systems.url = "github:nix-systems/default-linux";

    tinted-schemes = {
      flake = false;
      url = "github:tinted-theming/schemes";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      flake = false;
    };

    treesitter-modules-nvim = {
      flake = false;
      url = "github:MeanderingProgrammer/treesitter-modules.nvim";
    };

    ucodenix = {
      url = "github:e-tho/ucodenix";
    };

    autoreload-nvim = {
      flake = false;
      url = "github:ccntrq/autoreload.nvim";
    };
  };

  outputs = inputs: let
    evaluation = inputs.flake-parts.lib.evalFlakeModule {inherit inputs;} {
      imports = [(import inputs.import-tree ./modules)];

      _module.args.rootPath = ./.;
    };
  in
    {inherit evaluation;} // evaluation.config.processedFlake;
}
