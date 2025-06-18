{ inputs, rootPath, ... }:
{
  imports = [ inputs.files.flakeModules.default ];
  perSystem = psArgs: {
    files.projectRoot = rootPath;
    make-shells.default.packages = [ psArgs.config.files.writer.drv ];
  };
}
