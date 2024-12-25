{ self, ... }:
{
  imports = with self.modules.nixos; [
    desktop
    swap
    ./mobo.nix
    ./state-version.nix
  ];

  networking.hostId = "0e8e163d";
}
