{ lib, pkgs, ... }:
let
  inherit (lib) escapeShellArg;
  inherit (pkgs) neo-cowsay;

  message = ''
    If found, please contact:
    Shahar "Dawn" Or
    +66613657506
    mightyiampresence@gmail.com
    @mightyiam:matrix.org
  '';
in
{
  boot.initrd.preDeviceCommands = ''
    echo -e ${escapeShellArg message} | ${neo-cowsay}/bin/cowsay --bold --aurora -f dragon
  '';
}
