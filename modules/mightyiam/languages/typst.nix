{
  armilaria = {
    lsp.servers.tinymist = {
      enable = true;
      packageFallback = true;
    };
    plugins.typst-preview.enable = true;
  };

  # https://github.com/chomosuke/typst-preview.nvim/issues/136
  nixpkgs.overlays = [
    (final: prev: {
      vimPlugins = prev.vimPlugins.extend (final': prev': {
        typst-preview-nvim = prev'.typst-preview-nvim.overrideAttrs (old: {
          postPatch = ''
            substituteInPlace lua/typst-preview/servers/factory.lua --replace-fail "'--no-open'," "'--no-open',''\n    '--verbose',"
          '';
        });
      });
    })
  ];
}
