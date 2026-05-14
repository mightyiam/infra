{ inputs, ... }:
{
  imports = [ (inputs.make-shell + "/flake-module.nix") ];
}
