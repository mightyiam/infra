{ self, ... }:
{
  imports = with self.nixosModules; [
    desktop
    swap
    ./mobo.nix
    ./state-version.nix
  ];

  networking.hostId = "0e8e163d";
}
