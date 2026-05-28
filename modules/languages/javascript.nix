{
  flake.modules.nixvim.base = {
    lsp.servers.eslint = {
      enable = true;
      package = null;
    };
    plugins.typescript-tools.enable = true;
  };
}
