{
  perSystem = {
    nixpkgs.overlays = [
      (final: prev: {
        heroic = prev.heroic.override {
          extraPkgs = pkgs': [pkgs'.gamemode];
        };
      })
    ];
  };

  nixos.modules.pc = {
    programs.gamemode.enable = true;
  };
}
