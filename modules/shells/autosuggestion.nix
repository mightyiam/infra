{
  flake.modules.homeManager.base.programs.zsh = {
    autosuggestion.enable = true;
    initContent = ''
      bindkey '^[^M' autosuggest-execute
    '';
  };
}
