{
  imports = [
    ../../nixos-modules/modules/swap.nix
    ../../nixos-modules/types/desktop.nix
    ./mobo.nix
    ./state-version.nix
  ];

  networking.hostName = "ganoderma";
  networking.hostId = "0e8e163d";
}
