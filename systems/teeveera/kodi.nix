{ pkgs, ... }: {
  users.extraUsers.kodi.isNormalUser = true;
  services.cage = {
    user = "kodi";
    program = "${pkgs.kodi-wayland}/bin/kodi-standalone";
    enable = true;
  };
  specialisation.no_kodi.configuration.boot.kernelParams = [
    "systemd.mask=cage-tty1.service"
  ];
}
