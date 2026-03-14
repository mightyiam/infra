{
  flake.modules = {
    # https://github.com/nix-community/stylix/discussions/2232
    nixos.pc = {
      stylix.targets.gtksourceview.enable = false;
    };
    homeManager.gui = {
      stylix.targets.gtksourceview.enable = false;
    };
  };

  nixpkgs.overlays = [
  ];
}
