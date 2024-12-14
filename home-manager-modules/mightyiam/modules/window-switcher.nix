# icons don't work because arbitrary codepoints cannot be expressed in Nix string literals
{
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.swayr = {
    package =
      let
        src = pkgs.fetchFromSourcehut {
          owner = "~tsdh";
          repo = "swayr";
          rev = "0512a9fadc43c64f25afbc9db39c1286b4ac1a8c";
          sha256 = "sha256-tuqSt85wthhe7ywTjRvXz1vi1/eo9rqm7idecQlycWs=";
        };
      in
      pkgs.swayr.overrideAttrs (orig: {
        version = "unstable-2024-12-04";
        inherit src;
        cargoDeps = orig.cargoDeps.overrideAttrs {
          inherit src;
          outputHash = "sha256-eK9EJjTnjkIeFaWDO2bB3q+1IDu7hzUB44e5ZCmCj8c=";
        };
      });
    enable = true;
    systemd.enable = true;
    # https://sr.ht/~tsdh/swayr/#swayr-configuration
    settings = {
      menu = {
        executable = lib.getExe config.programs.rofi.package;
        args = [
          "-dmenu"
          "-markup-rows"
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
            "${config.home.path}/share/icons/hicolor/${variant}/apps"
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
}
