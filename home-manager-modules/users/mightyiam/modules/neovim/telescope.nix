{
  programs.nixvim.plugins.telescope = {
    enable = true;
    settings = {
    defaults = {
      vimgrep_arguments = ["rg" "--color=never" "--no-heading" "--with-filename" "--line-number" "--column" "--smart-case" "--hidden" "--glob" "!**/.git/*"];
    };
    };
    extensions = {};
  };
}
