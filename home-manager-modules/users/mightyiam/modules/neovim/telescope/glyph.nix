{ pkgs, ... }:
{
  programs.nixvim = {
    extraPackages = [
      (pkgs.vimUtils.buildVimPlugin {
        pname = "telescope-glyph-nvim";
        version = "unstable-2022-08-22";
        src = pkgs.fetchFromGitHub {
          owner = "alduraibi";
          repo = "telescope-glyph.nvim";
          rev = "f63f01e129e71cc25b79637610674bbf0be5ce9d";
          hash = "sha256-6H4afMXtaZn066oBq3z8vvR7WH7WhqZkvziyOXlsNVg=";
        };
      })
    ];
    plugins.telescope = {
      enabledExtensions = [ "glyph" ];
      keymaps = {
        "<leader>fu" = {
          action = "glyph";
        };
      };
    };
  };
}
