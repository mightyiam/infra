{
  lib,
  self,
  config,
  ...
}:
{
  options.nixvimModules = lib.mkOption {
    type = lib.types.attrsOf lib.types.anything;
  };
  config.flake = {
    inherit (config) nixvimModules;
  };

  config = {
    nixvimModules.default = {
      imports = [
        ./autoread.nix
        ./clipboard.nix
        ./cmp.nix
        ./comment.nix
        ./easymotion.nix
        ./fidget.nix
        ./flash.nix
        ./gitgutter.nix
        ./guess-indent.nix
        ./indent-keep-selection.nix
        ./inline-diagnostics.nix
        ./leader.nix
        ./line-numbers.nix
        ./lsp
        ./lualine.nix
        ./luasnip.nix
        ./nix-fmt.nix
        ./nvim-autopairs.nix
        ./nvim-surround.nix
        ./rustaceanvim.nix
        ./search.nix
        ./spectre.nix
        ./telescope
        ./title.nix
        ./treesitter.nix
        ./trouble.nix
        ./updatetime.nix
        ./which-key.nix
      ];
    };
    perSystem =
      {
        inputs',
        self',
        pkgs,
        ...
      }:
      {
        packages.nixvim = inputs'.nixvim.legacyPackages.makeNixvimWithModule {
          inherit pkgs;
          extraSpecialArgs = { };
          module = self.nixvimModules.default;
        };

        checks."packages/nixvim" = self'.packages.nixvim;
      };
  };
}
