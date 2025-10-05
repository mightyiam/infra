{
  flake.modules = {
    homeManager.base = {
      programs.nushell.settings.show_banner = false;
    };
    nixvim.astrea = {
      extraConfigLua =
        # lua
        ''
          vim.opt.shortmess:append("I")
        '';
    };
  };
}
