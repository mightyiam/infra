{
  nixos.modules.base = {
    users.users.mightyiam.extraGroups = ["systemd-journal"];
  };
}
