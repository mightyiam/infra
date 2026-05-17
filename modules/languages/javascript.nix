{
  flake.modules.nixvim.base.plugins = {
    lsp.servers.eslint = {
      enable = true;
      package = null;
    };
    typescript-tools.enable = true;
  };
}
