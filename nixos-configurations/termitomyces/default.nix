{ self, ... }:
{
  imports = with self.nixosModules; [
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
