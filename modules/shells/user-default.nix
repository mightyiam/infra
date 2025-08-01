{ lib, ... }:
{
  flake.modules = {
    nixos.base =
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
