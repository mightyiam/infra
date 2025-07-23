{
  flake.modules.homeManager.wife =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        inkscape
        # https://github.com/NixOS/nixpkgs/issues/427155
        # gimp-with-plugins
      ];
    };
}
