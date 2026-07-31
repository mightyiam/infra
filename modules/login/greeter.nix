{lib, ...}: {
  nixos.modules.pc = {pkgs, ...}: {
    services.greetd = {
      enable = true;
      settings.default_session.command =
        [
          (lib.getExe pkgs.tuigreet)
          "--cmd"
          (lib.getExe' pkgs.hyprland "start-hyprland")
          "--remember"
        ]
        |> lib.concatStringsSep " ";

      useTextGreeter = true;
    };
  };
}
