# Heya! Actually, this `flake.nix` file is auto-generated.
# The source of truth for its content is merged from across any number of files.
# Each input is declared in the module where it belongs.
# Same goes for the `nixConfig`, as well, of course.
# https://flake-file.denful.dev/
{
  outputs = inputs: import ./outputs.nix inputs;

  nixConfig = {
    abort-on-warn = true;
    allow-import-from-derivation = false;
    extra-experimental-features = ["pipe-operators"];
  };

  inputs = {
    autoreload-nvim = {
      url = "github:ccntrq/autoreload.nvim";
      flake = false;
    };
    files = {
      url = "github:mightyiam/files";
      flake = false;
    };
    flake-file.url = "github:denful/flake-file";
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
    nvim-genghis = {
      url = "github:chrisgrieser/nvim-genghis";
      flake = false;
    };
    refjump-nvim = {
      url = "github:mawkler/refjump.nvim";
      flake = false;
    };
    smart-scrolloff-nvim = {
      url = "github:tonymajestro/smart-scrolloff.nvim";
      flake = false;
    };
    stylix = {
      url = "github:nix-community/stylix";
      flake = false;
    };
    tinted-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      flake = false;
    };
    treesitter-modules-nvim = {
      url = "github:MeanderingProgrammer/treesitter-modules.nvim";
      flake = false;
    };
    ucodenix.url = "github:e-tho/ucodenix";
  };
}
