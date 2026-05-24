{
  nixConfig = {
    abort-on-warn = true;
    extra-experimental-features = [ "pipe-operators" ];
    allow-import-from-derivation = false;
  };

  inputs.self.submodules = true;

  inputs = {
    cpu-microcodes = {
      flake = false;
      url = "github:platomav/CPUMicrocodes";
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
      url = "./inputs/home-manager";
      flake = false;
    };

    import-tree = {
      url = "github:vic/import-tree";
      flake = false;
    };

    input-branches.url = "github:mightyiam/input-branches";

    make-shell = {
      url = "github:nicknovitski/make-shell";
      flake = false;
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      flake = false;
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

    nixpkgs.url = "./inputs/nixpkgs";

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
      url = "./inputs/stylix";
      flake = true;
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        nur.follows = "";
        systems.follows = "systems";
        tinted-schemes.follows = "tinted-schemes";
      };
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
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      text.readme.parts = {
        disallow-warnings =
          # markdown
          ''
            ## Trying to disallow warnings

            This at the top level of the `flake.nix` file:

            ```nix
            nixConfig.abort-on-warn = true;
            ```

            > [!NOTE]
            > It does not currently catch all warnings Nix can produce, but perhaps only evaluation warnings.
          '';

        automatic-import =
          # markdown
          ''
            ## Automatic import

            Nix files (they're all flake-parts modules) are automatically imported.
            Nix files prefixed with an underscore are ignored.
            No literal path imports are used.
            This means files can be moved around and nested in directories freely.

            > [!NOTE]
            > This pattern has been the inspiration of [an auto-imports library, import-tree](https://github.com/vic/import-tree).

          '';
      };

      imports = [ (import inputs.import-tree ./modules) ];

      _module.args.rootPath = ./.;
    };
}
