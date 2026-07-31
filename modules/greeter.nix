{lib, ...}: {
  options.users = lib.mkOption {
    type = lib.types.lazyAttrsOf (lib.types.submodule (userArgs: {
      options.wayland.sessions = lib.mkOption {
        type = lib.types.functionTo (lib.types.listOf lib.types.package);
      };
      config.nixos.pc = {pkgs, ...}: {
        users.wayland.sessions = userArgs.config.wayland.sessions pkgs;
      };
    }));
  };
  config.nixos.modules.pc = nixosArgs @ {pkgs, ...}: {
    options.users.wayland.sessions = lib.mkOption {
      type = lib.types.listOf lib.types.package;
    };
    config.services.greetd = {
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
          (lib.makeSearchPath "share/wayland-sessions" nixosArgs.config.users.wayland.sessions)
        ]
        |> lib.concatStringsSep " ";
    };
  };
}
