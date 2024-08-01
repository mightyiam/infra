{
  perSystem = {pkgs, ...}: {
    devshells.default = {
      commands = [
        {
          name = "system-diff";
          command = ''
            nixos-rebuild --flake . build
            nvd diff /run/current-system result
          '';
        }
        {
          name = "system-switch";
          command = ''
            sudo nixos-rebuild --flake . switch
          '';
        }
      ];

      devshell.packages = [pkgs.nvd];
    };
  };
}
