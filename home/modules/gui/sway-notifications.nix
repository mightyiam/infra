{pkgs, ...}: let
  font = (import ../../fonts.nix).notifications;
  mode = "screen-capture";
in {
  services.mako = {
    enable = true;
    anchor = "top-right";
    defaultTimeout = 3000;
    ignoreTimeout = true;
    font = with font; "${family} ${toString size}";
    extraConfig = ''
      [mode=${mode}]
      invisible=1
    '';
  };
  xdg.configFile."xdg-desktop-portal-wlr/config".text = ''
    [screencast]
    exec_before=${pkgs.mako}/bin/makoctl mode -a ${mode}
    exec_after=${pkgs.mako}/bin/makoctl mode -r ${mode}
  '';
}
