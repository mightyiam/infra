let
  inherit
    (builtins)
    readFile
    ;
in {
  programs.zsh.enable = true;
  programs.zsh.autosuggestion.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.enableVteIntegration = true;
  programs.zsh.autocd = true;
  programs.zsh.defaultKeymap = "viins";
  programs.zsh.history.ignorePatterns = ["rm *"];
  programs.zsh.initExtraFirst = readFile ./tmux-init.sh;
  programs.zsh.initExtra = ''
    bindkey '^P' up-history
    bindkey '^N' down-history
    bindkey '^w' backward-kill-word
    bindkey '^r' history-incremental-search-backward
    bindkey '^[^M' autosuggest-execute
  '';
  programs.zsh.initExtraBeforeCompInit = ''
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
  '';
  programs.zsh.shellAliases.nix-shell = "nix-shell --run zsh";
}
