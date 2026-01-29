{
  nixpkgs.config.allowUnfreePackages = [ "zerotierone" ];

  flake.modules.nixos.base = {
    services.zerotierone.enable = true;
  };
}
