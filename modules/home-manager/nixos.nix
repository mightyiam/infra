{
  config,
  inputs,
  ...
}:
{
  flake.modules.nixos = {
    base = {
      imports = [ (inputs.home-manager + "/nixos") ];

      home-manager.users.mightyiam =
        { osConfig, ... }:
        {
          home.stateVersion = osConfig.system.stateVersion;
          imports = [ config.flake.modules.homeManager.base ];
        };
    };
    pc = {
      home-manager.users.mightyiam = config.flake.modules.homeManager.gui;
    };
  };
}
