# icons don't work because arbitrary codepoints cannot be expressed in Nix string literals
{ lib, ... }:
{
  flake.modules.homeManager.base =
    {
      config,
      ...
    }:
    {
      programs.swayr = {
        enable = true;
        systemd.enable = true;
        # https://sr.ht/~tsdh/swayr/#swayr-configuration
        settings = {
          menu = {
            executable = lib.getExe config.programs.rofi.package;
            args = [
              "-dmenu"
              "-markup-rows"
              "-i"
              "-no-case-sensitive"
              "-show-icons"
              "-p"
              "{prompt}"
            ];
          };
          format = {
            window_format = "{indent}{workspace_name}: <i>{app_name}</i> — {urgency_start}<b>“{title}”</b>{urgency_end}<i>{marks}</i>    <span alpha=\"20000\">({id})</span>";
            indent = "  ";
            icon_dirs =
              [
                "scalable"
                "128x128"
              ]
              |> map (variant: [
                "${config.home.homeDirectory}/share/icons/hicolor/${variant}/apps"
                "/run/current-system/sw/share/icons/hicolor/${variant}/apps"
              ])
              |> lib.flatten;
          };
        };
      };
      wayland.windowManager.sway.config.keybindings =
        let
          mod = config.wayland.windowManager.sway.config.modifier;
          swayr = lib.getExe config.programs.swayr.package;
        in
        {
          "--no-repeat ${mod}+semicolon" = "exec ${swayr} switch-window '[workspace=__focused__]'";
          "--no-repeat ${mod}+tab" = "exec ${swayr} switch-to-urgent-or-lru-window";
        };
    };
}
