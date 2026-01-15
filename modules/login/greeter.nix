{ lib, config, ... }:
{
  flake.modules.nixos.workstation =
    nixosArgs@{ pkgs, ... }:
    {
      services.greetd = {
        enable = true;
        settings.default_session.command =
          [
            (lib.getExe pkgs.tuigreet)
            "--cmd"
            (lib.getExe'
              nixosArgs.config.home-manager.users.${config.flake.meta.owner.username}.wayland.windowManager.hyprland.package
              "start-hyprland"
            )
            "--remember"
          ]
          |> lib.concatStringsSep " ";
      };
    };
}
