{
  perSystem.treefmt.programs.yamlfmt.enable = true;

  flake.modules.nixvim.base = {
    lsp.servers.yamlls = {
      enable = true;
      packageFallback = true;
    };
  };
}
