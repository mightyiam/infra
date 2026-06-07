{
  home.base = {pkgs, ...}: {
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

  nixos.modules.pc = {
    programs.wireshark.enable = true;
  };
}
