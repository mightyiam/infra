{ pkgs, lib, config, ... }:
let
  outputs = import ./outputs.nix;
  secrets = (import ./secrets.nix);
  lockCommand = builtins.concatStringsSep " " [
    (pkgs.swaylock + /bin/swaylock)
    "--daemonize"
    "--show-keyboard-layout"
    "--indicator-caps-lock"
    "--color 000000"
    "--indicator-radius 200"
  ];
in
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
      export I3RS_GITHUB_TOKEN=${secrets.I3RS_GITHUB_TOKEN}
      export MOZ_ENABLE_WAYLAND=1
    '';
    config =
      let
        mod-key = "Mod4";
        toSwayConfig = (_: { path, resolution, refreshRate, position, ... }: {
          name = path;
          value = {
            res = with resolution; "${builtins.toString width}x${builtins.toString height}@${builtins.toString refreshRate}Hz";
            pos = with position; "${builtins.toString x} ${builtins.toString y}";
          };
        });
      in
      {
        output = builtins.listToAttrs (builtins.attrValues (builtins.mapAttrs toSwayConfig outputs));
        modifier = mod-key;
        input = {
          "type:keyboard" = {
            xkb_layout = "us,il";
            xkb_options = "grp:lalt_lshift_toggle";
          };
        };
        terminal = "alacritty";
        keybindings =
          let
            step = 5;
            incVol = d: "exec pactl set-sink-volume @DEFAULT_SINK@ ${d}${builtins.toString step}%";
          in
          lib.mkOptionDefault {
            "${mod-key}+Shift+e" = "exec swaymsg exit";
            "${mod-key}+Ctrl+l" = "exec ${lockCommand}";
            "${mod-key}+minus" = incVol "-";
            "${mod-key}+equal" = incVol "+";
          };
        startup = [
          { command = "mako"; }
        ];
      };
  };
  home.packages = [ pkgs.pulseaudio ];
  programs.mako = {
    enable = true;
    anchor = "top-right";
    defaultTimeout = 3000;
    ignoreTimeout = true;
    output = outputs.left.path;
  };
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 60 * 10;
        command = lockCommand;
      }
      {
        timeout = 60 * 11;
        command = "${pkgs.sway + /bin/swaymsg} \"output * dpms off\"";
        resumeCommand = "${pkgs.sway + /bin/swaymsg} \"output * dpms on\"";
      }
    ];
  };
}
