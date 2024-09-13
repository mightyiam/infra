{
  swapDevices =
    map
      (n: {
        device = "/dev/disk/by-partlabel/swap${n}";
        randomEncryption.enable = true;
      })
      [
        "0"
        "1"
      ];
}
