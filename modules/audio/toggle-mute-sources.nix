{ lib, withSystem, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.toggle-mute-sources = pkgs.writeShellApplication {
        name = "toggle-mute-sources";
        runtimeInputs = with pkgs; [
          pulseaudio
          gawk
        ];
        text = ''
          for source in $(pactl list short sources | awk "{print \$2}");
          do pactl set-source-mute "$source" toggle;
          done
        '';
      };
    };

  flake.modules.homeManager.gui =
    { config, pkgs, ... }:
    let
      mod = config.wayland.windowManager.sway.config.modifier;
      toggle-mute-sources = withSystem pkgs.system (psArgs: psArgs.config.packages.toggle-mute-sources);
    in
    {
      wayland.windowManager = {
        sway.config.keybindings."--no-repeat ${mod}+z" = "exec ${lib.getExe toggle-mute-sources}";
        hyprland.settings.bind = [
          "SUPER, z, exec, ${lib.getExe toggle-mute-sources}"
        ];
      };

      home.packages = [ toggle-mute-sources ];
    };
}
