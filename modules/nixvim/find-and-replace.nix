{ lib, ... }:
{
  flake.modules.nixvim.astrea =
    { pkgs, ... }:
    {
      plugins.grug-far = {
        enable = true;
        settings = {
          engine = "ripgrep";
          engines.ripgrep.path = lib.getExe pkgs.ripgrep-all;
        };
      };
    };

}
