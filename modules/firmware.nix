{
  flake.modules.nixos.base = {
    services.fwupd.enable = true;
  };
}
