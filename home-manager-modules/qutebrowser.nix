{ config, lib, ... }:
{
  config = lib.mkIf config.gui.enable {
    programs.qutebrowser = {
      enable = true;
    };
  };
}
