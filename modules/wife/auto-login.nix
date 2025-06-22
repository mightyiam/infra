{ config, ... }:
{
  flake.modules.nixos.wife = {
    services.displayManager.autoLogin = {
      enable = true;
      user = config.flake.meta.wife.username;
    };

    # https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
    systemd.services = {
      "getty@tty1".enable = false;
      "autovt@tty1".enable = false;
    };
  };
}
