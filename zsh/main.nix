{ sessionVariables, pkgs }: {
  enable = true;
  enableAutosuggestions = true;
  enableCompletion = true;
  enableVteIntegration = true;
  autocd = true;
  defaultKeymap = "viins";
  history.ignorePatterns = ["rm *"];
  inherit sessionVariables;
  initExtraFirst = builtins.readFile ./tmux-init.sh;
  initExtra = ''
    bindkey '^P' up-history
    bindkey '^N' down-history
    bindkey '^w' backward-kill-word
    bindkey '^r' history-incremental-search-backward

    alias ls='${pkgs.exa}/bin/exa --icons --git --header --all'
    alias du='${pkgs.du-dust}/bin/dust'
  '';
}
