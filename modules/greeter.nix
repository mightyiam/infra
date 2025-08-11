{ lib, config, ... }:
{
  flake.modules.nixos.workstation =
    nixosArgs@{ pkgs, ... }:
    let
      hyprlandPkg =
        nixosArgs.config.home-manager.users.${config.flake.meta.owner.username}.wayland.windowManager.hyprland.package;
    in
    {
      services = {
        greetd = {
          enable = true;
          settings = {
            default_session = {
              command =
                [
                  (lib.getExe pkgs.tuigreet)
                  "--cmd ${lib.getExe hyprlandPkg}"
                  "--remember"
                ]
                |> lib.concatStringsSep " ";
            };
            initial_session = lib.mkDefault {
              command = lib.getExe hyprlandPkg;
              user = config.flake.meta.owner.username;
            };
          };
        };
      };
    };
}
