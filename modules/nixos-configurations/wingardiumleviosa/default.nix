{ self, ... }:
{
  imports = with self.modules.nixos; [
    bow
    desktop
    ./mobo.nix
    ./state-version.nix
    ./gdm.nix
    ./auto-upgrade.nix
  ];

  networking.hostId = "abf835ae";
}
