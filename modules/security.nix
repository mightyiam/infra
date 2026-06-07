{
  nixos.modules.base = {
    services.paretosecurity = {
      enable = true;
      trayIcon = false;
    };
  };
}
