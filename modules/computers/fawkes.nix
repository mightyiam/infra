{config, ...}: {
  nixos.configurations.fawkes = {
    module = {pkgs, ...}: {
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

      services.printing.drivers = with pkgs; [
        epson-201401w
        epson-escpr
        epson-escpr2
        epson_201207w
      ];
    };

    facter.reportPath = ./fawkes.facter.json;
  };

  perSystem = {
    nixpkgs.config.allowUnfreePackages = [
      "epson-201401w"
      "epson_201207w"
    ];
  };
}
