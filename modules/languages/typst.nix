{
  flake.modules.nixvim.base = {
    plugins.lsp.servers.tinymist = {
      enable = true;
      package = null;
    };
    plugins.typst-preview.enable = true;
  };
}
