{ lib, ... }:
{
  flake.modules.homeManager.base.programs.zsh = {
    enableCompletion = true;
    initContent = lib.mkOrder 550 ''
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    '';
  };
}
