let
  repeat_delay = "200";
  repeat_rate = "50";
in
{
  flake.modules.homeManager.gui = {
    wayland.windowManager = {
      sway.config.input."type:keyboard" = {
        inherit repeat_delay repeat_rate;
      };

      hyprland.settings.input = {
        inherit repeat_delay repeat_rate;
      };
    };
  };
}
