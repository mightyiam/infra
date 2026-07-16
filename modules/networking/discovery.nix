{
  nixos.modules = {
    base = {
      services.avahi = {
        enable = true;
        nssmdns4 = true;
        publish = {
          enable = true;
          addresses = true;
        };
      };
    };
    pc = {
      services.avahi.publish.workstation = true;
    };
  };
}
