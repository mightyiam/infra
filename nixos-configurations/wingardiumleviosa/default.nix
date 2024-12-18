{ self, ... }:
{
  imports = with self.nixosModules; [
    bow
    desktop
    ./mobo.nix
    ./state-version.nix
    ./gdm.nix
    ./auto-upgrade.nix
  ];

  networking.hostId = "abf835ae";
}
