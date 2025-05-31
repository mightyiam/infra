{
  flake.modules = {
    nixos.pc =
      { pkgs, ... }:
      {
        networking = {
          wireless.iwd = {
            enable = true;
            settings = {
              IPv6.Enabled = true;
              Settings.AutoConnect = true;
            };
          };
          networkmanager.wifi.backend = "iwd";
        };
        environment.systemPackages = [ pkgs.impala ];

        services.avahi = {
          enable = true;
          nssmdns4 = true;
          publish = {
            enable = true;
            addresses = true;
          };
        };
      };

    homeManager.base =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          bandwhich
          bind # for dig
          curl
          ethtool
          gping
          inetutils
          socat
        ];
      };
  };
}
