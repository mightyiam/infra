{
  nixpkgs.allowedUnfreePackages = [
    "steam"
    "steam-unwrapped"
  ];
  flake.modules.nixos.pc = {
    programs.steam.enable = true;
  };
}
