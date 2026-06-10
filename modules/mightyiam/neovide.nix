{lib, ...}: {
  home.gui = hmArgs @ {pkgs, ...}: {
    home.packages = [pkgs.neovide hmArgs.config.fonts.bitmapEmojiFont.package];

    gui.editor.command = lib.getExe pkgs.neovide;
    home.sessionVariables.VISUAL = lib.getExe pkgs.neovide;

    xdg.configFile."neovide/config.toml".source = pkgs.writers.writeTOML "neovide/config.toml" {
      box-drawing.mode = "native";
      cursor_animation_length = 8.0e-2;
      cursor_vfx_mode = "railgun";
      cursor_vfx_particle_density = 20;
      fork = true;
      font = {
        normal = ["monospace" hmArgs.config.fonts.bitmapEmojiFont.name];
        size = hmArgs.config.stylix.fonts.sizes.applications;
      };
    };
  };
}
