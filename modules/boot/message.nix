{ config, lib, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.boot-message = pkgs.writeShellApplication {
        name = "boot-message";
        text =
          let
            message = lib.escapeShellArg (
              with config.flake.meta.owner;
              ''
                If found, please contact:
                ${name}
                ${phone}
                ${email}
                ${matrix}
              ''
            );
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
