{ lib, pkgs, ... }:
let
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
    echo -e ${lib.escapeShellArg message} | ${pkgs.neo-cowsay}/bin/cowsay --bold --aurora -f dragon
  '';
}
