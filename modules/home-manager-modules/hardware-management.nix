{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dmidecode
    pciutils
    usbutils
  ];
}
