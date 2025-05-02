{
  flake.modules.nixos.pc.boot = {
    kernelParams = [
      "loglevel=4"
      "systemd.show_status=error"
    ];
    plymouth.enable = true;
  };
}
