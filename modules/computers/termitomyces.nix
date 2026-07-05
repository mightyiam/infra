{
  config,
  lib,
  ...
}: {
  nixos.configurations.termitomyces = {
    module = {
      networking = {
        hostId = "6b5dea2a";
        domain = "local";
      };

      imports = with config.nixos.modules; [
        efi
        pc
      ];

      boot.partlabels = [
        "boot0"
        "boot1"
      ];
      system.stateVersion = "24.11";
      services.openssh.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB7usI+3jiHKYtWD7XAO8gWXKHJN4VZ67dh5x9oPvsQk";
      environment.variables.DXVK_FILTER_DEVICE_NAME = "RX 6600";

      home-manager.users.mightyiam.audio.deviceNameMaps =
        {
          "SPDIF" = "SPDIF";
          "Speaker" = "SPEAKERS";
        }
        |> lib.mapAttrs' (substr: value: {
          name = "alsa_output.usb-Generic_USB_Audio-00.HiFi__${substr}__sink";
          inherit value;
        })
        |> lib.mergeAttrs {
          "alsa_output.usb-R__DE_Microphones_R__DE_NT-USB_Mini_31FBD749-00.analog-stereo" = "HEADPHONES";
        };

      # https://www.reddit.com/r/buildapc/comments/xypn1m/network_card_intel_ethernet_controller_i225v_igc/
      boot.kernelParams = [
        "pcie_port_pm=off"
        "pcie_aspm.policy=performance"
        "microcode.amd_sha_check=off"
      ];
    };

    facter.reportPath = ./termitomyces.facter.json;
  };
}
