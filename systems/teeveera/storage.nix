let
  media = import ./media.nix;
  boot = n: {
    "/boot${toString n}" = {
      device = "/dev/disk/by-partlabel/boot${toString n}";
      fsType = "vfat";
    };
  };
  zfs = mountPath: let
    zfsNameSuffix =
      if mountPath == "/"
      then ""
      else mountPath;
  in {
    "${mountPath}" = {
      device = "storage/root${zfsNameSuffix}";
      fsType = "zfs";
    };
  };
in {
  fileSystems =
    zfs "/"
    // boot 0
    // boot 1
    // zfs media.dir;
  system.activationScripts.media.text = ''
    chown root:${media.group} ${media.dir}
    chmod ${toString media.mode.mode} ${media.dir}
  '';
}
