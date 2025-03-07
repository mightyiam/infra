{
  flake.modules.nixos."nixosConfigurations/termitomyces" =
    { pkgs, ... }:
    {
      services.ratbagd.enable = true;
      environment.systemPackages = [ pkgs.piper ];
    };
}
