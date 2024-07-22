{
  imports = [
    ../../nixos-modules/types/desktop.nix
    ./mobo.nix
    ./state-version.nix
    ./gdm.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  networking.hostName = "wingardiumleviosa";
  networking.hostId = "abf835ae";
}
