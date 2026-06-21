inputs: let
  inherit (inputs.nixpkgs) lib;

  evaluation = inputs.flake-parts.lib.evalFlakeModule {inherit inputs;} {
    imports = [((import inputs.import-tree).filterNot (lib.hasSuffix ".pkg.nix") ./modules)];

    _module.args.rootPath = ./.;
  };
in
  {inherit evaluation;} // evaluation.config.processedFlake
