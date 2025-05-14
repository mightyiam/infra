{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    let
      mode = "screen-capture";
    in
    {
      services.mako = {
        enable = true;
        settings = {
          anchor = "top-right";
          default-timeout = 3000;
          ignore-timeout = 1;
          "mode=${mode}".invisible = 1;
        };
      };
      xdg.configFile."xdg-desktop-portal-wlr/config".text = ''
        [screencast]
        exec_before=${pkgs.mako}/bin/makoctl mode -a ${mode}
        exec_after=${pkgs.mako}/bin/makoctl mode -r ${mode}
      '';
      services.systembus-notify.enable = true;
    };
}
