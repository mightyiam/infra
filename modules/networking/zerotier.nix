{
  nixpkgs.allowedUnfreePackages = [ "zerotierone" ];

  flake.modules.nixos.base = {
    services.zerotierone.enable = true;
  };
}
