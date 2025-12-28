{
  flake.modules.homeManager.base = hmArgs: {
    programs.zsh = {
      enable = true;
      dotDir = "${hmArgs.config.xdg.configHome}/zsh";
    };
  };
}
