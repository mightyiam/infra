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
    config = {
      services.greetd = {
        enable = true;
        useTextGreeter = true;
        settings.default_session.command = lib.getExe pkgs.tuigreet;
      };

      environment = {
        systemPackages = [pkgs.tuigreet];

        etc."tuigreet/config.toml".source = pkgs.writers.writeTOML "config.toml" {
          user_menu.enabled = true;
          secret = {
            mode = "characters";
            characters = "♥";
          };
          remember = {
            username = true;
            user_session = true;
          };
          sessions.sessions_dirs = nixosArgs.config.users.wayland.sessions |> map (pkg: "${pkg}/share/wayland-sessions");
        };
      };
    };
  };
}
