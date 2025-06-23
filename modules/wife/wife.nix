{ config, ... }:
{
  flake = {
    meta.wife.username = "1bowapinya";
    modules.nixos.wife = nixosArgs: {
      users.users.${config.flake.meta.wife.username} = {
        isNormalUser = true;
        initialPassword = "";
        extraGroups = [ nixosArgs.config.services.printing.extraSystemGroup ];
      };
    };
  };
}
