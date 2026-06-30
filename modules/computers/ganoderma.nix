{config, ...}: {
  nixos.configurations.ganoderma = {
    module = {
      networking.hostId = "0e8e163d";
      system.stateVersion = "24.11";
      services.openssh.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBc+R3LtvYs/encp9UIqWKoKDG7Zr448LwIYs2nrao7+";
      boot.partlabels = [
        "boot0"
        "boot1"
      ];
      swap.partlabels = [
        "swap0"
        "swap1"
      ];
      hardware.nvidia.open = false;

      imports = with config.nixos.modules; [
        efi
        nvidia-gpu
        pc
        bow
      ];
    };

    facter.reportPath = ./ganoderma.facter.json;
  };
}
