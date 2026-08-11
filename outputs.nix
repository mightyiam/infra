inputs: let
  lib = import "${inputs.nixpkgs}/lib";
in
  inputs.flake-parts.lib.mkFlake {inherit inputs;} {
    debug = true;
    imports = [((import inputs.import-tree).filterNot (lib.hasSuffix ".pkg.nix") ./modules)];
    _module.args.rootPath = ./.;
  }
