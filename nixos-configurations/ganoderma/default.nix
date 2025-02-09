{ self, ... }:
{
  imports = with self.modules.nixos; [
    desktop
    facter
    swap
    ./networking.nix
    ./state-version.nix
  ];

  networking.hostId = "0e8e163d";

  facter.reportPath = ./facter.json;
}
