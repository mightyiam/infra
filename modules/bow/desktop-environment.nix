{
  nixos.modules.bow = {
    services = {
      system76-scheduler.enable = true;
      desktopManager.cosmic.enable = true;
    };
  };
}
