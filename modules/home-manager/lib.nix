{ inputs, lib, ... }:
{
  _module.args.homeManager = import "${inputs.home-manager}/lib" { inherit lib; };
}
