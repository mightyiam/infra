let
  incompleteDir = "${dir}/.transmission-incomplete";
  dir = "/media";
  group = "media";
  mode = {
    inherit mode;
    mask = 7;
  };
in
  nixosArgs @ {pkgs, ...}: {
    users = {
      groups.media.members = ["mightyiam"];
      extraUsers.kodi = {
        isNormalUser = true;
        inherit group;
      };
    };
    services = {
      cage = {
        user = "kodi";
        program = "${pkgs.kodi-wayland}/bin/kodi-standalone";
        enable = true;
      };

      transmission = {
        inherit group;
        enable = true;
        settings = {
          download-dir = dir;
          incomplete-dir-enabled = true;
          incomplete-dir = incompleteDir;
          upload-slots-per-torrent = 14;
          preallocation = 2;
          start-added-torrents = true;
          umask = mode.mask;
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
    };
    specialisation.no_kodi.configuration.boot.kernelParams = ["systemd.mask=cage-tty1.service"];

    system = {
      activationScripts = {
        media.text = ''
          mkdir --parents ${dir}
          chown root:${group} ${dir}
          chmod ${toString mode.mode} ${dir}
        '';
        transmission.text = ''
          mkdir -p ${incompleteDir}
          chown ${nixosArgs.config.services.transmission.user}:root ${incompleteDir}
          chmod ${toString mode.mode} ${incompleteDir}
        '';
      };
    };

    boot.loader.grub = {
      grub.splashImage = ./teeveera-splash-screen-1920x1080.png;
      grub.extraConfig = ''
        set color_normal=black/black
        set color_highlight=black/magenta
      '';
    };
  }
