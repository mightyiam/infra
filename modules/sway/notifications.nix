{ lib, ... }:
{
  flake.modules.homeManager.home =
    {
      pkgs,
      config,
      ...
    }:
    let
      mode = "screen-capture";
    in
    lib.mkIf config.gui.enable {
      services.mako = {
        enable = true;
        anchor = "top-right";
        defaultTimeout = 3000;
        ignoreTimeout = true;
        font = "sans-serif 12.0";
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
      services.systembus-notify.enable = true;
    };
}
