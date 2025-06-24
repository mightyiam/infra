{
  nixpkgs.allowedUnfreePackages = [ "zerotierone" ];

  flake.modules.nixos.pc = {
    services.zerotierone.enable = true;
  };
}
