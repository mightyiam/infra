{
  perSystem.treefmt.programs.rustfmt.enable = true;

  flake.modules = {
    nixvim.base.plugins = {
      rustaceanvim = {
        enable = true;
        settings.server.default_settings.rust-analyzer = {
          check = {
            features = "all";
            allTargets = true;
            command = "clippy";
          };
          inlayHints = {
            maxLength = 99;
            lifetimeElisionHints.enable = "always";
          };
        };
      };
      lsp.keymaps.extra = [
        {
          key = "<space>p";
          action = "<CMD>RustLsp parentModule<CR>";
        }
      ];
    };

    homeManager.base =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          cargo-watch
          cargo-outdated
          cargo-feature
        ];
      };
  };
}
