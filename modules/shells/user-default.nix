{ lib, ... }:
{
  flake.modules = {
    nixos.base =
      nixosArgs@{ pkgs, ... }:
      {
        programs.zsh.enable = true;
        users.defaultUserShell = pkgs.zsh;
        users.users.mightyiam.shell =
          nixosArgs.config.home-manager.users.mightyiam.programs.nushell.package;
      };

    nixOnDroid.base =
      { pkgs, ... }:
      {
        user.shell = lib.getExe pkgs.zsh;
      };
  };
}
