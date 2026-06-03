{
  flake.modules.nixos.bow = {
    users.users."1bowapinya" = {
      isNormalUser = true;
      initialPassword = "";
      extraGroups = [ "lpadmin" ];
    };
  };
}
