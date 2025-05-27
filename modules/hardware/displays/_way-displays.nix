{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.services.way-displays-stateful;
in
{
  meta.maintainers = [ lib.hm.maintainers.mightyiam ];

  options.services.way-displays-stateful = {
    enable = lib.mkEnableOption ''
      A stateful way-displays setup where the configuration file is not linked to the store.
      This allows using `way-displays --set <arguments>` and then `way-displays --write`.

      A way-displays service is _not_ started automatically. Instead, a window manager should execute `systemctl --user start "way-displays@$XDG_VTNR".service` on startup.
    '';
    package = lib.mkPackageOption pkgs "way-displays" { };
  };

  config = {
    assertions = [
      (lib.hm.assertions.assertPlatform "services.way-displays-stateful" pkgs lib.platforms.linux)
    ];

    home.packages = [ cfg.package ];

    systemd.user.services."way-displays@" = {
      Unit.Description = "way-displays XDG_VTNR=%i";

      Service = {
        Environment = "XDG_VTNR=%i";
        ExecStart = lib.getExe cfg.package;
        Restart = "on-failure";
        RestartSec = "10";
      };
    };
  };
}
