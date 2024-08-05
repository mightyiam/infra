{
  imports = [
    ../../nixos-modules/types/desktop.nix
    ./mobo.nix
    ./state-version.nix
    ./gdm.nix
  ];

  networking.hostName = "wingardiumleviosa";
  networking.hostId = "abf835ae";
}
