{
  lib,
  inputs,
  ...
}:
{
  flake.modules = {
    nixos.desktop = {
      security.rtkit.enable = true;

      services = {
        pulseaudio.enable = false;
        pipewire = {
          enable = true;
          alsa = {
            enable = true;
            support32Bit = true;
          };
          pulse.enable = true;
        };
      };
    };

    homeManager = {
      base =
        { pkgs, config, ... }:
        let
          sink-rotate = inputs.sink-rotate.packages.${pkgs.system}.default;
          mod = config.wayland.windowManager.sway.config.modifier;
        in
        {
          home.packages = [ sink-rotate ];
          wayland.windowManager.sway.config.keybindings = {
            "--no-repeat ${mod}+c" = "exec ${sink-rotate}/bin/sink-rotate";
          };
        };

      gui =
        { pkgs, config, ... }:
        let
          step = 5;
          pactl = lib.getExe' pkgs.pulseaudio "pactl";
          mod = config.wayland.windowManager.sway.config.modifier;

          incVol =
            d:
            lib.concatStringsSep " " [
              "exec ${pactl}"
              "set-sink-volume @DEFAULT_SINK@ ${d}${toString step}%"
            ];

          toggleMuteSources = lib.concatStringsSep " " [
            "exec ${pkgs.zsh + /bin/zsh} -c '"
            "for source in $(${pactl} list short sources | ${pkgs.gawk + /bin/awk} \"{print \\$2}\");"
            "do ${pactl} set-source-mute \"$source\" toggle;"
            "done'"
          ];
        in
        {
          wayland.windowManager.sway.config.keybindings = {
            "--no-repeat ${mod}+x" = incVol "-";
            "--no-repeat ${mod}+Shift+x" = incVol "+";
            "--no-repeat ${mod}+z" = toggleMuteSources;
          };
          home.packages = with pkgs; [
            pavucontrol
            qpwgraph
          ];
        };
    };
  };
}
