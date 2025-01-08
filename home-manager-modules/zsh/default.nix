{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting = {
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
    autocd = true;
    defaultKeymap = "viins";
    history.ignorePatterns = [ "rm *" ];
    initExtra = ''
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
    initExtraBeforeCompInit = ''
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    '';
    shellAliases.nix-shell = "nix-shell --run zsh";
  };
}
