{pkgs, ...}: let
  media = import ./media.nix;
in {
  users.extraUsers.kodi = {
    isNormalUser = true;
    group = media.group;
  };
  services.cage = {
    user = "kodi";
    program = "${pkgs.kodi-wayland}/bin/kodi-standalone";
    enable = true;
  };
  specialisation.no_kodi.configuration.boot.kernelParams = [
    "systemd.mask=cage-tty1.service"
  ];
}
