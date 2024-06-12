{
  imports = [
    ./common.nix
  ];

  # https://www.reddit.com/r/buildapc/comments/xypn1m/network_card_intel_ethernet_controller_i225v_igc/
  boot.kernelParams = ["pcie_port_pm=off" "pcie_aspm.policy=performance"];

  networking.hostName = "mightyiam-desktop";
  networking.hostId = "6b5dea2a";

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "sd_mod"];
  boot.kernelModules = ["kvm-amd"];

  fileSystems."/" = {
    device = "nixos/root";
    fsType = "zfs";
  };

  fileSystems."/etc" = {
    device = "nixos/root/etc";
    fsType = "zfs";
  };

  fileSystems."/nix" = {
    device = "nixos/root/nix";
    fsType = "zfs";
  };

  fileSystems."/var" = {
    device = "nixos/root/var";
    fsType = "zfs";
  };

  fileSystems."/bin" = {
    device = "nixos/root/bin";
    fsType = "zfs";
  };

  fileSystems."/home" = {
    device = "nixos/root/home";
    fsType = "zfs";
  };

  fileSystems."/root" = {
    device = "nixos/root/root";
    fsType = "zfs";
  };

  fileSystems."/sbin" = {
    device = "nixos/root/sbin";
    fsType = "zfs";
  };

  fileSystems."/boot1" = {
    device = "/dev/disk/by-uuid/82EC-9017";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  fileSystems."/boot0" = {
    device = "/dev/disk/by-uuid/816E-3CD9";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };
}
