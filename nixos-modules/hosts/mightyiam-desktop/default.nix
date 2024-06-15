{
  imports = [
    ../../types/desktop.nix
    ./mobo.nix
    ./gpu.nix
    ./filesystems.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  networking.hostName = "mightyiam-desktop";
  networking.hostId = "6b5dea2a";
}
