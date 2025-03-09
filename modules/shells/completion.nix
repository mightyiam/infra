{
  flake.modules.homeManager.home.programs.zsh = {
    enableCompletion = true;
    initExtraBeforeCompInit = ''
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    '';
  };
}
