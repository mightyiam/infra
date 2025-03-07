{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ bluetui ];
      hardware.bluetooth.enable = true;
    };
}
