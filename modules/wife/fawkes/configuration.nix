{ config, ... }:
{
  nixpkgs.config.allowUnfreePackages = [
    "epson-201401w"
    "epson_201207w"
  ];

  configurations.nixos.fawkes.module =
    { pkgs, ... }:
    {
      networking = {
        domain = "local";
        hostId = "a1f5f4ab";
        hostName = "fawkes";
      };

      system.stateVersion = "25.11";
      services.openssh.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN9nypXKeLfgwbnAlQHvuvudkI1jrpcuggYIsEwunuSC";
      hardware.facter.reportPath = ./facter.json;

      imports = with config.flake.modules.nixos; [
        efi
        pc
        wife
      ];

      services.printing.drivers = with pkgs; [
        epson-201401w
        epson-escpr
        epson-escpr2
        epson_201207w
        gutenprint
        hplip
        splix
      ];
    };
}
