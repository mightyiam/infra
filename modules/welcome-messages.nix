{
  flake.modules = {
    homeManager.base = {
      programs.nushell.settings.show_banner = false;
    };
    nixvim.base = {
      extraConfigLua =
        # lua
        ''
          vim.opt.shortmess:append("I")
        '';
    };
  };
}
