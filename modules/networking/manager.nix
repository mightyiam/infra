{
  nixos.modules.base = {pkgs, ...}: {
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

    services.dbus.packages = [
      (pkgs.writeTextDir "share/dbus-1/system.d/99-iwd-group.conf" ''
        <!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
         "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
        <busconfig>
          <policy group="users">
            <allow send_destination="net.connman.iwd"/>
          </policy>
        </busconfig>
      '')
    ];

    environment.systemPackages = [pkgs.impala];
  };
}
