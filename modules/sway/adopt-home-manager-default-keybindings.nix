{
  flake.modules.homeManager.gui =
    { options, ... }:
    let
      defaultHomeManagerSwayConfig = options.wayland.windowManager.sway.config.type.getSubOptions { };
    in
    {
      wayland.windowManager.sway.config.keybindings = defaultHomeManagerSwayConfig.keybindings.default;
    };
}
