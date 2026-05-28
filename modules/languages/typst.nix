{
  flake.modules.nixvim.base = {
    lsp.servers.tinymist = {
      enable = true;
      package = null;
    };
    plugins.typst-preview.enable = true;
  };
}
