{
  flake.modules.nixos.pc = {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = false;

      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };
}
