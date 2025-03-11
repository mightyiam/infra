{
  flake.modules.homeManager.gui.programs.zsh.initExtra = ''
    precmd() {
      local cwd
      cwd=''${PWD/#$HOME/\~}
      print -Pn "\e]0;zsh ''${cwd}\a"
    }
  '';
}
