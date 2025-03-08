{ lib, ... }:
{
  flake.modules = {
    nixos.desktop =
      { pkgs, ... }:
      {
        programs.zsh.enable = true;
        users.defaultUserShell = pkgs.zsh;
      };

    nixOnDroid.base =
      { pkgs, ... }:
      {
        user.shell = lib.getExe pkgs.zsh;
      };
  };
}
