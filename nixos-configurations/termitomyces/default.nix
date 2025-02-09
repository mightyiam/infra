{ self, ... }:
{
  imports = with self.modules.nixos; [
    ./sshd.nix
    ./mobo.nix
    ./networking.nix
    ./gpu.nix
    ./cpu.nix
    ./docker.nix
    ./state-version.nix
    desktop
    facter
  ];

  networking.hostId = "6b5dea2a";

  facter.reportPath = ./facter.json;
}
