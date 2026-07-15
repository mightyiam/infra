{
  perSystem = {
    nixpkgs.config.allowUnfreePackages = ["zerotierone"];
  };

  nixos.modules.base = {
    services.zerotierone.enable = true;
  };
}
