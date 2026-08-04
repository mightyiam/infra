{
  nixos.modules.base = {
    security.sudo-rs.enable = true;
    users.users.mightyiam.extraGroups = ["wheel"];
  };
}
