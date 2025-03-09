{
  flake.modules.homeManager.home.programs.zsh = {
    autosuggestion.enable = true;
    initExtra = ''
      bindkey '^[^M' autosuggest-execute
    '';
  };
}
