{
  flake.modules.homeManager.gui = {
    wayland.windowManager.sway.config.input."type:keyboard" = {
      repeat_delay = "200";
      repeat_rate = "50";
    };
  };
}
