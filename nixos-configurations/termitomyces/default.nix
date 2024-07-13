{
  imports = [
    ../../nixos-modules/types/desktop.nix
    ./mobo.nix
    ./gpu.nix
    ./filesystems.nix
    ./cpu.nix
    ./state-version.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  networking.hostName = "termitomyces";
  networking.hostId = "6b5dea2a";
}
