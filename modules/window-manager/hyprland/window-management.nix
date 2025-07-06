{ lib, ... }:
{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      wayland.windowManager.hyprland = {
        plugins = [ pkgs.hyprlandPlugins.hy3 ];

        settings = {
          general = {
            layout = "hy3";
            resize_on_border = true;
          };

          plugin.hy3.tab_first_window = true;

          bind =
            let
              hjkl =
                mod: f:
                {
                  h = "l";
                  j = "d";
                  k = "u";
                  l = "r";
                }
                |> lib.mapAttrsToList (k: d: "${mod}, ${k}, ${f d}");
            in
            lib.concatLists [
              [
                "SUPER+SHIFT+CTRL, q , exit"

                "SUPER+SHIFT, q, hy3:killactive"

                "SUPER, f, fullscreen, 1"
                "SUPER+SHIFT, f, fullscreen, 0"

                "SUPER, tab, hy3:togglefocuslayer"

                "SUPER, s, hy3:makegroup, h"
                "SUPER, v, hy3:makegroup, v"

                "SUPER, t, hy3:makegroup, tab"

                "SUPER, a, hy3:changefocus, raise"
                "SUPER+SHIFT, a, hy3:changefocus, lower"

                "SUPER, e, hy3:expand, expand"
                "SUPER+SHIFT, e, hy3:expand, base"

                "SUPER, r, hy3:changegroup, opposite"

                "SUPER+SHIFT, tab, togglefloating"
              ]

              (hjkl "SUPER" (d: "hy3:movefocus, ${d}"))
              (hjkl "SUPER+CONTROL" (d: "hy3:movefocus, ${d}, visible, nowrap"))
              (hjkl "SUPER+SHIFT" (d: "hy3:movewindow, ${d}, once"))
              (hjkl "SUPER+CONTROL+SHIFT" (d: "hy3:movewindow, ${d}, once, visible"))

              (
                9
                |> lib.genList toString
                |> map (ws: [
                  "SUPER, ${ws}, workspace, ${ws}"
                  "SUPER+SHIFT, ${ws}, hy3:movetoworkspace, ${ws}"
                ])
                |> lib.concatLists
              )
            ];

          bindn = [
            ", mouse_down, hy3:focustab, l, require_hovered"
            ", mouse_up, hy3:focustab, r, require_hovered"
          ];

          bindm = [
            "SUPER, mouse:272, movewindow"
            "SUPER, mouse:273, resizewindow"
          ];
        };
      };

    };
}
