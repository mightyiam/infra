{
  flake.modules.nixvim.base.plugins = {
    lsp.servers.eslint.enable = true;
    typescript-tools.enable = true;
  };
}
