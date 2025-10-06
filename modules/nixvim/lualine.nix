{ inputs, ... }:
{
  flake.modules.nixvim.base.plugins.lualine = {
    enable = true;
    settings =
      let
        winbar = {
          lualine_a = [
            "encoding"
            "fileformat"
          ];
          lualine_b = [
            "filetype"
          ];
          lualine_c = [
            (
              inputs.nixvim.lib.nixvim.listToUnkeyedAttrs [ "filename" ]
              // {
                path = 1;
                shorting_target = 0;
              }
            )
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
      in
      {
        options = {
          globalstatus = true;
          section_separators = "";
          component_separators = "";

          disabled_filetypes = {
            winbar = [
              "Trouble"
            ];
          };

          ignore_focus = [ "Trouble" ];
        };

        extensions = [ "trouble" ];

        inherit winbar;
        inactive_winbar = winbar;

        sections = {
          lualine_a = [
            "mode"
          ];
          lualine_b = [
            (
              inputs.nixvim.lib.nixvim.listToUnkeyedAttrs [ "diagnostics" ]
              // {
                sources = [ "nvim_lsp" ];
              }
            )
          ];
          lualine_c = [ ];
          lualine_x = [ ];
          lualine_y = [ ];
          lualine_z = [ "branch" ];
        };
      };
  };
}
