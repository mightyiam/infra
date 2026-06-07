{
  armilaria = {
    plugins.rustaceanvim = {
      enable = true;
      settings.server.default_settings.rust-analyzer = {
        check = {
          allTargets = true;
          command = "clippy";
        };
        inlayHints.lifetimeElisionHints.enable = "always";
      };
    };
    lsp.keymaps = [
      {
        key = "gmp";
        action = "<CMD>RustLsp parentModule<CR>";
      }
    ];
  };

  home.base = {pkgs, ...}: {
    home.packages = with pkgs; [
      cargo-watch
      cargo-outdated
      cargo-feature
    ];
  };
}
