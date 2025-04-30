{
  flake.modules.nixos.pc =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ bluetui ];
      hardware.bluetooth.enable = true;
    };
}
