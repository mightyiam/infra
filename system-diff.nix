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
      ];

      devshell.packages = [pkgs.nvd];
    };
  };
}
