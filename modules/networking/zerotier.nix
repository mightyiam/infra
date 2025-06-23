{
  nixpkgs.allowedUnfreePackages = [ "zerotierone" ];

  flake.modules.nixos.pc = {
    services.zerotierone = {
      enable = true;
      joinNetworks = [ "af415e486fc17ea5" ];
    };
  };
}
