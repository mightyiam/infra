{
  nixos.modules.base = {
    security.sudo-rs.enable = true;
    users.users.mightyiam.extraGroups = [
      "wheel"
      "systemd-journal"
      "input"
    ];
    nix.settings.trusted-users = ["mightyiam"];
  };
}
