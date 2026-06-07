{inputs, ...}: {
  homeManager.modules.base = {
    imports = [(inputs.nix-index-database + "/home-manager-module.nix")];
    programs = {
      nix-index.enable = true;
      nix-index-database.comma.enable = true;
    };
  };
}
