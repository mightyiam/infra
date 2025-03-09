{ lib, ... }:
{
  flake.modules.homeManager.home =
    { config, ... }:
    {
      programs.zsh.initExtra = lib.mkIf config.gui.enable ''
        precmd() {
          local cwd
          cwd=''${PWD/#$HOME/\~}
          print -Pn "\e]0;zsh ''${cwd}\a"
        }
      '';
    };
}
