{
  flake.modules.nixos.swap =
    { config, ... }:
    {
      swapDevices =
        config.storage.redundancy.range
        |> map (n: {
          device = "/dev/disk/by-partlabel/swap${n}";
          randomEncryption.enable = true;
        });
    };
}
