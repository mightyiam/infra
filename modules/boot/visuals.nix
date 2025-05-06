{
  flake.modules.nixos.pc = {
    # https://github.com/danth/stylix/discussions/1206
    stylix.targets.grub.enable = false;

    boot = {
      kernelParams = [
        "quiet"
        "systemd.show_status=error"
      ];
      plymouth.enable = true;
    };
  };
}
