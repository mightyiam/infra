{
  lib,
  config,
  self,
  ...
}:
{
  imports = [ self.inputs.ucodenix.nixosModules.default ];

  options.isAmdCpu = lib.mkOption {
    #type = lib.types.bool;
    type = lib.types.enum ["false" "true"];
    #default = false;
  };

  config.services.ucodenix.enable = lib.mkIf (config.isAmdCpu == "true") true;
}
