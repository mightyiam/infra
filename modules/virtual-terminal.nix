{
  flake.modules.nixos.base = {
    services.kmscon = {
      enable = true;
      extraConfig = ''
        mouse
      '';
    };
  };
}
