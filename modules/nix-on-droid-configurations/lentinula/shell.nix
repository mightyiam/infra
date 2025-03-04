{ pkgs, ... }:
{
  user.shell = "${pkgs.zsh}/bin/zsh";
}
