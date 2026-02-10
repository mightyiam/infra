{
  flake.modules.nixvim.base = {
    plugins = {
      lsp.servers.tinymist.enable = true;
      typst-preview.enable = true;
    };
  };
}
