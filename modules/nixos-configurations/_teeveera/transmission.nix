{ config, ... }:
let
  media = import ./media.nix;
  incompleteDir = "${media.dir}/.transmission-incomplete";
in
{
  services.transmission = {
    inherit (media) group;
    enable = true;
    settings = {
      download-dir = media.dir;
      incomplete-dir-enabled = true;
      incomplete-dir = incompleteDir;
      upload-slots-per-torrent = 14;
      preallocation = 2;
      start-added-torrents = true;
      umask = media.mode.mask;
      cache-size-mb = 16;
      encryption = 2;
      peer-limit-global = 500;
      peer-limit-per-torrent = 500;
      peer-port-random-on-start = true;
      port-forwarding-enabled = true;
      download-queue-enabled = false;
    };
    performanceNetParameters = true;
  };
  system.activationScripts.transmission.text = ''
    mkdir -p ${incompleteDir}
    chown ${config.services.transmission.user}:root ${incompleteDir}
    chmod ${toString media.mode.mode} ${incompleteDir}
  '';
}
