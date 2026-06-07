{
  nixos.modules.base = {
    security.sudo-rs.enable = true;
    users.users.mightyiam.extraGroups = [
      "wheel"
      "systemd-journal"
      "input"
      "wireshark"
      "docker"
      "vboxusers"
    ];
    nix.settings.trusted-users = ["mightyiam"];
  };
}
