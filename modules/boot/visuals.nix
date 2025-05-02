{
  flake.modules.nixos.pc.boot = {
    kernelParams = [ "systemd.show_status=error" ];
    plymouth.enable = true;
  };
}
