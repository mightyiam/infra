{
  imports = [
    ../../nixos-modules/types/desktop.nix
    ./sshd.nix
    ./mobo.nix
    ./gpu.nix
    ./cpu.nix
    ./docker.nix
    ./state-version.nix
  ];

  networking.hostId = "6b5dea2a";
}
