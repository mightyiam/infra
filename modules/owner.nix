{ config, ... }:
{
  flake = {
    meta.owner = {
      email = "mightyiampresence@gmail.com";
      name = "Shahar \"Dawn\" Or";
      username = "mightyiam";
      matrix = "@mightyiam:matrix.org";
    };

    modules = {
      nixos.pc = {
        users.users.${config.flake.meta.owner.username} = {
          isNormalUser = true;
          initialPassword = "";
          extraGroups = [ "input" ];
        };

        nix.settings.trusted-users = [ config.flake.meta.owner.username ];
      };
    };
  };
}
