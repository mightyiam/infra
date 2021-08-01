{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableVteIntegration = true;
    autocd = true;
    defaultKeymap = "viins";
    history.ignorePatterns = ["rm *"];
    initExtraFirst = builtins.readFile ./tmux-init.sh;
    initExtra = ''
      bindkey '^P' up-history
      bindkey '^N' down-history
      bindkey '^w' backward-kill-word
      bindkey '^r' history-incremental-search-backward
      bindkey '^[^M' autosuggest-execute

      eval "$(direnv hook zsh)"

      alias ls='${pkgs.exa}/bin/exa --icons --git --header --all'
      alias du='${pkgs.du-dust}/bin/dust'
      alias grep='${pkgs.ripgrep}/bin/rg'
      alias top='${pkgs.bottom}/bin/btm'
    '';
    initExtraBeforeCompInit = ''
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    '';
  };
  programs.tmux.shell = "${pkgs.zsh}/bin/zsh";
}
