{
  nixpkgs.config.allowUnfreePackages = [
    "steam"
    "steam-unwrapped"
  ];
  flake.modules.nixos.pc = {
    programs.steam = {
      enable = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}
