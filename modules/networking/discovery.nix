{
  nixos.modules = {
    base = {
      services = {
        resolved.settings.Resolve.MulticastDNS = false;
        avahi = {
          enable = true;
          nssmdns4 = true;
          settings.publish = {
            disable-publishing = false;
            publish-addresses = true;
          };
        };
      };
    };
    pc = {
      services.avahi.settings.publish.publish-workstation = true;
    };
  };
}
