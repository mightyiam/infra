with builtins; { pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableVteIntegration = true;
    autocd = true;
    defaultKeymap = "viins";
    history.ignorePatterns = ["rm *"];
    initExtraFirst = readFile ./tmux-init.sh;
    initExtra = ''
      bindkey '^P' up-history
      bindkey '^N' down-history
      bindkey '^w' backward-kill-word
      bindkey '^r' history-incremental-search-backward
      bindkey '^[^M' autosuggest-execute
    '';
    initExtraBeforeCompInit = ''
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    '';
  };
  programs.tmux.shell = "${pkgs.zsh}/bin/zsh";
  programs.alacritty.settings.shell = {
    program = "${pkgs.zsh}/bin/zsh";
    args = ["--login"];
  };
}
