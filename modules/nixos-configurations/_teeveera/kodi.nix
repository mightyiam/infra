{ pkgs, ... }:
let
  media = import ./media.nix;
in
{
  users.extraUsers.kodi.isNormalUser = true;
  users.extraUsers.kodi.group = media.group;
  services.cage.user = "kodi";
  services.cage.program = "${pkgs.kodi-wayland}/bin/kodi-standalone";
  services.cage.enable = true;
  specialisation.no_kodi.configuration.boot.kernelParams = [ "systemd.mask=cage-tty1.service" ];
}
