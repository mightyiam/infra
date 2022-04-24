let
  font = (import ../fonts.nix).notifications;
  instance = import ../instance.nix;
in {
  programs.mako = {
    enable = true;
    anchor = "top-right";
    defaultTimeout = 3000;
    ignoreTimeout = true;
    output = instance.outputs.left.path;
    font = with font; "${family} ${toString size}";
  };
  wayland.windowManager.sway.config.startup = [
    {command = "mako";}
  ];
}
