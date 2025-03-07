{
  flake.modules.homeManager.home =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        neofetch
      ];
    };
}
