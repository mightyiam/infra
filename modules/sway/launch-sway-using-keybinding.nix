{ lib, ... }:
{
  flake.modules.homeManager.gui =
    hmArgs:
    let
      package = hmArgs.config.wayland.windowManager.sway.package;
    in
    {
      programs.zsh.initContent = ''
        bindkey -s '^@' 'exec ${lib.getExe package}\n'
      '';
    };

}
