{
  flake.modules.homeManager.base.programs.zsh = {
    enableCompletion = true;
    initExtraBeforeCompInit = ''
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    '';
  };
}
