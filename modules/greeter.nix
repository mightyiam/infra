{
  lib,
  config,
  ...
}: {
  options.users = lib.mkOption {
    type = lib.types.lazyAttrsOf (lib.types.submodule (userArgs: {
      options.wayland.sessions = lib.mkOption {
        type = lib.types.functionTo (lib.types.listOf lib.types.package);
      };
    }));
  };
  config.nixos.modules.pc = {pkgs, ...}: {
    services.greetd = {
      enable = true;
      useTextGreeter = true;
      settings.default_session.command =
        [
          (lib.getExe pkgs.tuigreet)
          "--user-menu"
          "--asterisks"
          "--asterisks-char=♥"
          "--remember"
          "--remember-user-session"
          "--sessions"
          (
            config.users
            |> lib.mapAttrsToList (name: user: user.wayland.sessions pkgs)
            |> lib.flatten
            |> lib.makeSearchPath "share/wayland-sessions"
          )
        ]
        |> lib.concatStringsSep " ";
    };
  };
}
