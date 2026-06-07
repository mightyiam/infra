{
  nixos.modules.base = {
    services.kmscon = {
      enable = true;
      extraConfig = ''
        mouse
      '';
    };
  };
}
