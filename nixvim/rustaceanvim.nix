{
  plugins = {
    rustaceanvim = {
      enable = true;
      settings = {
        default_settings.rust-analyzer = {
          check = {
            command = "clippy";
            allTargets = true;
          };
          inlayHints = {
            maxLength = 99;
            lifetimeElisionHints.enable = "always";
          };
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
}
