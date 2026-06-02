{ lib, ... }:
{
  flake.modules.homeManager.gui =
    hmArgs@{ pkgs, ... }:
    {
      config = {
        home.packages = [ pkgs.neovide ];

        gui.editor.command = lib.getExe pkgs.neovide;

        xdg.configFile."neovide/config.toml".source = pkgs.writers.writeTOML "neovide/config.toml" {
          box-drawing.mode = "native";
          cursor_animation_length = 8.0e-2;
          cursor_vfx_mode = "railgun";
          cursor_vfx_particle_density = 20;
          fork = true;
          font = {
            normal = [ hmArgs.config.stylix.fonts.monospace.name ];
            size = hmArgs.config.stylix.fonts.sizes.applications;
          };
        };
      };
    };
}
