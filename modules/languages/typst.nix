{
  flake.modules.nixvim.base = {
    lsp.servers.tinymist = {
      enable = true;
      packageFallback = true;
    };
    plugins.typst-preview.enable = true;
  };
}
