{ config, lib, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.boot-message = pkgs.writeShellApplication {
        name = "boot-message";
        text =
          let
            message = lib.escapeShellArg ''
              If found, please contact:
              Shahar "Dawn" Or
              +66613657506
              mightyiampresence@gmail.com
              @mightyiam:matrix.org
            '';
          in
          ''echo -e ${message} | boxes --design weave | lolcat --seed 38 --force'';
        runtimeInputs = [
          pkgs.lolcat
          pkgs.boxes
        ];
      };
    };

  flake.modules.nixos.mobile-device =
    { pkgs, ... }:
    {
      boot.initrd.preDeviceCommands = lib.getExe config.flake.packages.${pkgs.stdenv.system}.boot-message;
    };
}
