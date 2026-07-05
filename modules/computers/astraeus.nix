{
  config,
  lib,
  ...
}: {
  nixos.configurations.astraeus = {
    module = {
      networking.hostId = "5ddc3c42";
      system.stateVersion = "25.11";
      services.openssh.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIYvXn67X8v5UbC1STan+yUVC7xoCPuYn0V/m8qgt4hy root@astraeus";
      boot.partlabels = ["boot0"];

      home-manager.users.mightyiam.audio.sinkNameMap =
        {
          "Speaker" = "SPEAKER";
          "Headphones" = "JACK";
          "HDMI1" = "HDMI";
        }
        |> lib.mapAttrs' (substr: value: {
          name = "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__${substr}__sink";
          inherit value;
        });

      imports = with config.nixos.modules; [
        efi
        pc
      ];
    };

    facter.reportPath = ./astraeus.facter.json;
  };
}
