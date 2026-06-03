{ config, ... }:
{
  configurations.nixos.termitomyces.module = {
    networking = {
      hostName = "termitomyces";
      hostId = "6b5dea2a";
      domain = "local";
    };

    imports = with config.flake.modules.nixos; [
      efi
      pc
    ];

    hardware.facter.reportPath = ./facter.json;

    system.stateVersion = "24.11";

    services = {
      openssh.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB7usI+3jiHKYtWD7XAO8gWXKHJN4VZ67dh5x9oPvsQk";
      ucodenix.enable = true;
    };

    environment.variables.DXVK_FILTER_DEVICE_NAME = "RX 6600";

    # https://www.reddit.com/r/buildapc/comments/xypn1m/network_card_intel_ethernet_controller_i225v_igc/
    boot.kernelParams = [
      "pcie_port_pm=off"
      "pcie_aspm.policy=performance"
    ];
  };
}
