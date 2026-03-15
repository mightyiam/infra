{
  flake.modules.homeManager.wife =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        inkscape
        gimp-with-plugins
      ];
    };
}
