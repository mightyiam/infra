{
  nixos.modules.pc = {
    services.geoclue2.enable = true;

    # workaround for https://gitlab.freedesktop.org/geoclue/geoclue/-/work_items/162
    environment.etc."geoclue/conf.d/00-ip.conf".text = ''
      [ip]
      enable=true
      method=ichnaea
    '';
  };
}
