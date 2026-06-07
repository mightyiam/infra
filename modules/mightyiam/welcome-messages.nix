{
  home.base = {
    programs.nushell.settings.show_banner = false;
  };

  armilaria = {
    extraConfigLua = ''
      vim.opt.shortmess:append("I")
    '';
  };
}
