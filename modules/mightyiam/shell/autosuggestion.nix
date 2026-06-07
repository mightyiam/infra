{
  home.base = {
    programs.zsh = {
      autosuggestion.enable = true;
      initContent = ''
        bindkey '^[^M' autosuggest-execute
      '';
    };
  };
}
