{
  programs.zsh.enable = true;
  programs.zsh.autosuggestion.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.syntaxHighlighting = {
    enable = true;
    highlighters = [
      "main"
      "brackets"
      "pattern"
      "regexp"
      "cursor"
      "line"
    ];
  };
  programs.zsh.autocd = true;
  programs.zsh.defaultKeymap = "viins";
  programs.zsh.history.ignorePatterns = [ "rm *" ];
  programs.zsh.initExtra = ''
    bindkey '^[;' up-line-or-search
    bindkey '^w' backward-kill-word
    bindkey '^r' history-incremental-search-backward
    bindkey '^[^M' autosuggest-execute

    precmd() {
      local cwd
      cwd=''${PWD/#$HOME/\~}
      print -Pn "\e]0;zsh ''${cwd}\a"
    }
  '';
  programs.zsh.initExtraBeforeCompInit = ''
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
  '';
  programs.zsh.shellAliases.nix-shell = "nix-shell --run zsh";
}
