{ config, lib, ... }:
{
  flake.modules = {
    nixos.base =
      nixosArgs@{ pkgs, ... }:
      {
        programs.zsh.enable = true;
        users.defaultUserShell = pkgs.zsh;
        users.users.${config.flake.meta.owner.username}.shell =
          nixosArgs.config.home-manager.users.${config.flake.meta.owner.username}.programs.nushell.package;
      };

    nixOnDroid.base =
      { pkgs, ... }:
      {
        user.shell = lib.getExe pkgs.zsh;
      };
  };
}
