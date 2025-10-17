{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        hollywood
        fastfetch
        lolcat
      ];
    };
}
