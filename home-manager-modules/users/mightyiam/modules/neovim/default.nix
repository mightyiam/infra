{ self, ... }:
{
  imports = [ self.inputs.nixvim.homeManagerModules.nixvim ];
  programs.nixvim.enable = true;
}
