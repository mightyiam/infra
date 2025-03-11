{
  flake.modules.homeManager.base.programs.zsh = {
    autosuggestion.enable = true;
    initExtra = ''
      bindkey '^[^M' autosuggest-execute
    '';
  };
}
