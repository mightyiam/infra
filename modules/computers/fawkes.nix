{config, ...}: {
  nixos.configurations.fawkes = {
    module = {
      networking.hostId = "a1f5f4ab";

      system.stateVersion = "25.11";
      services.openssh.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN9nypXKeLfgwbnAlQHvuvudkI1jrpcuggYIsEwunuSC";

      imports = with config.nixos.modules; [
        efi
        pc
        bow
      ];

      boot.partlabels = [
        "boot0"
        "boot1"
      ];
    };

    facter.reportPath = ./fawkes.facter.json;
  };
}
