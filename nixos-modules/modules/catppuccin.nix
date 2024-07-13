{self, ...}: {
  imports = [self.inputs.catppuccin.nixosModules.catppuccin];
  catppuccin.enable = true;
}
