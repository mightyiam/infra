{
  flake.modules.nixos.base = {
    services.paretosecurity = {
      enable = true;
      trayIcon = false;
    };
  };
}
