{
  programs.steam.enable = true;
  nixpkgs.allowUnfreePackages = [
    "steam"
    "steam-unwrapped"
  ];
}
