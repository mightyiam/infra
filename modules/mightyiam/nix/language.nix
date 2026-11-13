{lib, ...}: {
  flake-file.nixConfig.extra-experimental-features = ["pipe-operators"];

  nix.settings.experimental-features = [
    "pipe-operators"
  ];

  armilaria = {pkgs, ...}: {
    lsp.servers = {
      nixd = {
        enable = true;
        packageFallback = true;
        config.settings.nixd.formatting.command = [(lib.getExe pkgs.alejandra)];
      };

      statix = {
        enable = true;
        packageFallback = true;
      };
    };
  };
}
