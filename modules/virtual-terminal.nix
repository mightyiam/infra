{
  nixos.modules.base = {
    services.kmscon = {
      enable = true;
      config.mouse = true;
    };
  };
}
