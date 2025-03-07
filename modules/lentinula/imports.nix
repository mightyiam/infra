{ config, ... }:
{
  flake.modules.nixOnDroid."nixOnDroidConfigurations/lentinula".imports = [
    config.flake.modules.nixOnDroid.base
  ];
}
