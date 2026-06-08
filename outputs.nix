inputs: let
  evaluation = inputs.flake-parts.lib.evalFlakeModule {inherit inputs;} {
    imports = [(import inputs.import-tree ./modules)];

    _module.args.rootPath = ./.;
  };
in
  {inherit evaluation;} // evaluation.config.processedFlake
