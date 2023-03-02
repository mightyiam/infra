instance: let
  font = (import ../fonts.nix).notifications;
in {
  services.mako = {
    enable = true;
    anchor = "top-right";
    defaultTimeout = 3000;
    ignoreTimeout = true;
    output = instance.notificationOutput;
    font = with font; "${family} ${toString size}";
  };
  wayland.windowManager.sway.config.startup = [
    {command = "mako";}
  ];
}
