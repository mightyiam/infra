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
      nixos.desktop = {
        security.sudo-rs.enable = true;

        users.users.${config.flake.meta.owner.username} = {
          isNormalUser = true;
          initialPassword = "";
          extraGroups = [
            "wheel"
            "input"
          ];
        };

        nix.settings.trusted-users = [ config.flake.meta.owner.username ];
      };
    };
  };
}
