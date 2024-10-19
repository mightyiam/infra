{
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings = {
      options = {
        globalstatus = true;
        section_separators = "";
        component_separators = "";

        disabled_filetypes = {
          winbar = [
            "Trouble"
          ];
        };

        ignore_focus = ["Trouble"];
      };

      extensions = ["trouble"];

      winbar = {
           lualine_a = [
             "encoding"
             "fileformat"
           ];
           lualine_b = [
             "filetype"
           ];
           lualine_c = [
             {
            "filename" = null;
               path = 1;
               shorting_target = 0;
             }
           ];
           lualine_x = [
             "diff"
           ];
           lualine_y = [
             "%o"
             "location"
           ];
           lualine_z = [
             "progress"
           ];
         };

      sections = {
      };
    };
  };
}
