{
  flake.modules.homeManager.base.programs.zsh = {
    history.ignorePatterns = [ "rm *" ];
    initContent = ''
      bindkey '^[;' up-line-or-search
      bindkey '^r' history-incremental-search-backward
    '';
  };
}
