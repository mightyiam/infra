{
  nixos.modules.base = {
    services.fwupd.enable = true;
    hardware.enableAllFirmware = true;
  };

  nixpkgs.config.allowUnfreePackages = [
    "b43-firmware"
    "broadcom-bt-firmware"
    "facetimehd-calibration"
    "xone-dongle-firmware"
    "facetimehd-firmware"
  ];
}
