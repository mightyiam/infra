{
  nixos.modules = {
    base = {
      services.avahi = {
        enable = true;
        nssmdns4 = true;
        settings.publish = {
          enable = true;
          publish-addresses = true;
        };
      };
    };
    pc = {
      services.avahi.settings.publish.publish-workstation = true;
    };
  };
}
