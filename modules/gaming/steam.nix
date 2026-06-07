{
  nixpkgs.config.allowUnfreePackages = [
    "steam"
    "steam-unwrapped"
  ];
  nixos.modules.pc = {
    programs.steam = {
      enable = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}
