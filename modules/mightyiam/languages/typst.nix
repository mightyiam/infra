{
  armilaria = nixvimArgs: {
    lsp.servers.tinymist = {
      enable = true;
      packageFallback = true;
      config.settings = {
        typstExtraArgs = nixvimArgs.lib.nixvim.mkRaw ''
          (function()
              local extra_args = os.getenv('TYPST_EXTRA_ARGS')
              if not extra_args or extra_args == "" then
                return ""
              end

              extra_args = vim.split(extra_args, '%s+', { trimempty = true })

              return extra_args
          end)()
        '';
      };
    };
    plugins.typst-preview = {
      enable = true;
      settings.extra_args = nixvimArgs.config.lsp.servers.tinymist.config.settings.typstExtraArgs;
    };
  };

  perSystem = {
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
  };
}
