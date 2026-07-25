inputs:
inputs.flake-parts.lib.mkFlake {inherit inputs;} {
  debug = true;
  imports = [((import inputs.import-tree).filterNot (inputs.nixpkgs.lib.hasSuffix ".pkg.nix") ./modules)];
  _module.args.rootPath = ./.;
}
