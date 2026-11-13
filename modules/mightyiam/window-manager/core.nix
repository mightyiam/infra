{lib, ...}: {
  home.gui = {pkgs, ...}: {
    wayland.windowManager.hyprland = {
      enable = true;
      configType = "lua";
      plugins = [pkgs.hyprlandPlugins.hy3];

      settings = {
        config = {
          general = {
            layout = "hy3";
            resize_on_border = true;
          };
          plugin.hy3.tab_first_window = true;
        };

        bind = let
          hjkl = mod: f:
            {
              h = "l";
              j = "d";
              k = "u";
              l = "r";
            }
            |> lib.mapAttrsToList (k: d: {
              _args = [
                "${mod} + ${k}"
                (f d)
              ];
            });
        in
          lib.concatLists [
            [
              {
                _args = [
                  "SUPER + SHIFT + CTRL + q"
                  (lib.generators.mkLuaInline ''hl.dsp.exit()'')
                ];
              }
              {
                _args = [
                  "SUPER + SHIFT + q"
                  (lib.generators.mkLuaInline ''hl.plugin.hy3.kill_active()'')
                ];
              }
              {
                _args = [
                  "SUPER + f"
                  (lib.generators.mkLuaInline ''hl.dsp.window.fullscreen({ mode = "maximized" })'')
                ];
              }
              {
                _args = [
                  "SUPER + SHIFT + f"
                  (lib.generators.mkLuaInline ''hl.dsp.window.fullscreen({ mode = "fullscreen" })'')
                ];
              }
              {
                _args = [
                  "SUPER + tab"
                  (lib.generators.mkLuaInline ''hl.plugin.hy3.toggle_focus_layer()'')
                ];
              }
              {
                _args = [
                  "SUPER + s"
                  (lib.generators.mkLuaInline ''hl.plugin.hy3.make_group("h")'')
                ];
              }
              {
                _args = [
                  "SUPER + v"
                  (lib.generators.mkLuaInline ''hl.plugin.hy3.make_group("v")'')
                ];
              }
              {
                _args = [
                  "SUPER + t"
                  (lib.generators.mkLuaInline ''hl.plugin.hy3.make_group("tab")'')
                ];
              }
              {
                _args = [
                  "SUPER + a"
                  (lib.generators.mkLuaInline ''hl.plugin.hy3.change_focus("raise")'')
                ];
              }
              {
                _args = [
                  "SUPER + SHIFT + a"
                  (lib.generators.mkLuaInline ''hl.plugin.hy3.change_focus("lower")'')
                ];
              }
              {
                _args = [
                  "SUPER + e"
                  (lib.generators.mkLuaInline ''hl.plugin.hy3.expand("expand")'')
                ];
              }
              {
                _args = [
                  "SUPER + SHIFT + e"
                  (lib.generators.mkLuaInline ''hl.plugin.hy3.expand("base")'')
                ];
              }
              {
                _args = [
                  "SUPER + r"
                  (lib.generators.mkLuaInline ''hl.plugin.hy3.change_group("opposite")'')
                ];
              }
              {
                _args = [
                  "SUPER + SHIFT + tab"
                  (lib.generators.mkLuaInline ''hl.dsp.window.float()'')
                ];
              }
              {
                _args = [
                  "mouse_down"
                  (lib.generators.mkLuaInline ''hl.plugin.hy3.focus_tab({ direction = "l", mouse = "require_hovered" })'')
                  {non_consuming = true;}
                ];
              }
              {
                _args = [
                  "mouse_up"
                  (lib.generators.mkLuaInline ''hl.plugin.hy3.focus_tab({ direction = "r", mouse = "require_hovered" })'')
                  {non_consuming = true;}
                ];
              }
            ]

            (hjkl "SUPER" (d: lib.generators.mkLuaInline ''hl.plugin.hy3.move_focus("${d}")''))
            (hjkl "SUPER + CONTROL" (d: lib.generators.mkLuaInline ''hl.plugin.hy3.move_focus("${d}", { visible = true, wrap = false })''))
            (hjkl "SUPER + SHIFT" (d: lib.generators.mkLuaInline ''hl.plugin.hy3.move_window("${d}", { once = true })''))
            (hjkl "SUPER + CONTROL + SHIFT" (d: lib.generators.mkLuaInline ''hl.plugin.hy3.move_window("${d}", { once = true, visible = true })''))

            (
              9
              |> lib.genList (n: n + 1 |> toString)
              |> map (ws: [
                {
                  _args = [
                    "SUPER + ${ws}"
                    (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "${ws}" })'')
                  ];
                }
                {
                  _args = [
                    "SUPER + SHIFT + ${ws}"
                    (lib.generators.mkLuaInline ''
                      function()
                        hl.dispatch(hl.plugin.hy3.move_to_workspace("${ws}"))
                        hl.dispatch(hl.plugin.hy3.change_focus("bottom"))
                      end
                    '')
                  ];
                }
              ])
              |> lib.concatLists
            )
          ];
      };
    };
  };
}
