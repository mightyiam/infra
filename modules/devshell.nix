{ inputs, ... }:
{
  imports = [ inputs.make-shell.flakeModules.default ];
}
