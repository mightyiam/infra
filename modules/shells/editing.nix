{
  flake.modules.homeManager.base.programs.zsh.initContent = ''
    bindkey '^w' backward-kill-word

    autoload -Uz edit-command-line
    zle -N edit-command-line
    bindkey -M vicmd '^e' edit-command-line
  '';
}
