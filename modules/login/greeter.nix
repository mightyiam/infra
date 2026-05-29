{ lib, ... }:
{
  flake.modules.nixos.pc =
    nixosArgs@{ pkgs, ... }:
    {
      services.greetd = {
        enable = true;
        settings.default_session.command =
          [
            (lib.getExe pkgs.tuigreet)
            "--cmd"
            (lib.getExe' nixosArgs.config.home-manager.users.mightyiam.wayland.windowManager.hyprland.package "start-hyprland")
            "--remember"
          ]
          |> lib.concatStringsSep " ";
      };
    };
}
