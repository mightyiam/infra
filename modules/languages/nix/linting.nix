{
  perSystem = {
    treefmt.programs = {
      nixf-diagnose.enable = true;

      statix.enable = true;
    };
  };

  flake.modules = {
    nixvim.base.lsp.servers.statix = {
      enable = true;
      packageFallback = true;
    };
  };
}
