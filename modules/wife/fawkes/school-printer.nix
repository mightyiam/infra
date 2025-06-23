{
  nixpkgs.allowedUnfreePackages = [
    "epson-201401w"
    "epson_201207w"
  ];

  flake.modules.nixos."nixosConfigurations/fawkes" =
    { pkgs, ... }:
    {
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
