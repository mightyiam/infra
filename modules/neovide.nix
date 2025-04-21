{ lib, ... }:
{
  flake.modules.homeManager.gui =
    {
      config,
      pkgs,
      ...
    }:
    let
      package = pkgs.neovide;
    in
    {
      options.guiEditorCommand = lib.mkOption {
        type = with lib.types; nullOr pathInStore;
        default = lib.getExe package;
      };

      config = {
        home.packages = [ package ];

        xdg.configFile."neovide/config.toml".source = pkgs.writers.writeTOML "neovide/config.toml" {
          box-drawing.mode = "native";
          transparency = config.style.windowOpacity;
          cursor_animation_length = 8.0e-2;
          cursor_vfx_mode = "railgun";
          cursor_vfx_particle_density = 20;
          fork = true;
          font = {
            normal = [ "monospace" ];
            inherit (config.fonts.monospace) size;
          };
        };
      };
    };
}
