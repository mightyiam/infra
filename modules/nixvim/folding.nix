{
  flake.modules.nixvim.base = {
    plugins.treesitter.folding.enable = true;
    opts.foldlevel = 99;
  };
}
