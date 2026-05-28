{
  flake.modules.nixvim.base = {
    lsp.servers.lua_ls = {
      enable = true;
      packageFallback = true;
    };
  };
}
