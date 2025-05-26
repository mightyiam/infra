{ lib, ... }:
{
  flake.modules.homeManager.gui =
    hmArgs:
    let
      package = hmArgs.config.wayland.windowManager.hyprland.package;
    in
    {
      programs.zsh.initContent = ''
        bindkey -s '^@' '[ -v XDG_CURRENT_DESKTOP ] || exec ${lib.getExe package}\n'
      '';
    };

}
