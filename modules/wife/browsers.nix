{
  flake.modules.homeManager.wife =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        brave
        firefox
        chromium
      ];
    };
}
