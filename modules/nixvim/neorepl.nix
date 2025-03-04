{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.vimPlugins.neorepl-nvim
  ];
  keymaps = [
    {
      key = "<leader>r";
      action = "<cmd>Repl<CR>";
    }
  ];
}
