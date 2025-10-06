{
  flake.modules.nixvim.base = {
    plugins.treesitter.folding = true;
    opts.foldlevel = 99;
  };
}
