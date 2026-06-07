{
  nixos.modules.pc = {
    virtualisation = {
      docker = {
        enable = true;
        enableOnBoot = false;

        rootless = {
          enable = true;
          setSocketVariable = true;
        };
      };

      virtualbox.host.enable = true;
    };
  };
}
