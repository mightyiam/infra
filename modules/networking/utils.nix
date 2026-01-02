{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        bandwhich
        bind # for dig
        curl
        ethtool
        gping
        inetutils
        socat
        wifite2
      ];
    };
}
