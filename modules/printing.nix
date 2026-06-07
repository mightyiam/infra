{
  config,
  lib,
  ...
}: {
  nixos.modules.pc = {pkgs, ...}: {
    services.printing = {
      enable = true;

      drivers = with pkgs; [
        gutenprint
        hplip
        splix
      ];
    };

    users.groups.lpadmin.members = config.users |> lib.mapAttrsToList (_: {username, ...}: username);
  };
}
