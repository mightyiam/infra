{lib, ...}: {
  home.gui = hmArgs: {
    gui.editor.command = lib.getExe hmArgs.config.programs.neovide.package;

    programs.neovide = {
      enable = true;
      settings = {
        box-drawing.mode = "native";
        cursor_animation_length = 8.0e-2;
        cursor_vfx_mode = "railgun";
        cursor_vfx_particle_density = 20;
        fork = true;
        font.normal = [
          # override stylix not being helpful
          "monospace"
        ];
      };
    };
  };
}
