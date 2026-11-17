{
  nixos.modules.base = {
    services.watt = {
      enable = true;
    };
  };
}
