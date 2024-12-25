{ self, ... }:
{
  imports = with self.modules.nixos; [
    ./sshd.nix
    ./mobo.nix
    ./gpu.nix
    ./cpu.nix
    ./docker.nix
    ./state-version.nix
    desktop
  ];

  networking.hostId = "6b5dea2a";
}
