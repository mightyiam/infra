{
  programs.steam.enable = true;
  nixpkgs.allowUnfreePackages = [
    "steam"
    "steam-original"
    "steam-run"
  ];
}
