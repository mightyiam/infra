{inputs, ...}: {
  flake-file.inputs.nix-index-database = {
    url = "github:nix-community/nix-index-database";
    flake = false;
  };

  homeManager.modules.base = {
    imports = ["${inputs.nix-index-database}/home-manager-module.nix"];
    programs = {
      nix-index.enable = true;
      nix-index-database.comma.enable = true;
    };
  };
}
