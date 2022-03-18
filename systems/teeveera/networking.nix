{
  networking = {
    hostName = (import ../../shared.nix).teeveera.hostname;
    networkmanager.enable = true;
    interfaces = {
      enp6s0.useDHCP = false;
      wlp7s0.useDHCP = false;
    };
  };
  users.users.mightyiam.extraGroups = ["networkmanager"];
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
    };
  };
}
