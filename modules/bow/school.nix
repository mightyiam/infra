{
  nixos.modules.pc = {pkgs, ...}: {
    services.printing.drivers = with pkgs; [
      epson-201401w
      epson-escpr
      epson-escpr2
      epson_201207w
    ];
  };

  perSystem = {
    nixpkgs.config.allowUnfreePackages = [
      "epson-201401w"
      "epson_201207w"
    ];
  };
}
