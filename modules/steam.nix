{
  nixpkgs.allowedUnfreePackages = [
    "steam"
    "steam-unwrapped"
  ];
  flake.modules.nixos.desktop.programs.steam.enable = true;
}
