{ nixvim, ... }:
{
  flake.modules.nixvim.base = {
    plugins.mini-files.enable = true;
    keymaps = [
      {
        key = "<leader>.";
        action = nixvim.mkRaw "MiniFiles.open";
        options.desc = "file manager";
      }
    ];
  };
}
