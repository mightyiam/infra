{ self, ... }:
{
  imports = [ self.inputs.nix-index-database.nixosModules.nix-index ];
  programs.nix-index-database.comma.enable = true;
}
