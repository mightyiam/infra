{ lib, ... }:
{
  flake.modules.homeManager.gui =
    { pkgs, config, ... }:
    let
      pactl = lib.getExe' pkgs.pulseaudio "pactl";
      mod = config.wayland.windowManager.sway.config.modifier;

      toggleMuteSources = lib.concatStringsSep " " [
        "exec ${lib.getExe pkgs.zsh} -c '"
        "for source in $(${pactl} list short sources | ${lib.getExe' pkgs.gawk "awk"} \"{print \\$2}\");"
        "do ${pactl} set-source-mute \"$source\" toggle;"
        "done'"
      ];
    in
    {
      wayland.windowManager.sway.config.keybindings."--no-repeat ${mod}+z" = toggleMuteSources;
    };
}
