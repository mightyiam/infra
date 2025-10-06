{ lib, ... }:
{
  flake.modules.nixvim.base =
    { pkgs, ... }:
    {
      plugins.telescope.settings =
        let
          rgArgs = [
            "--hidden"
            "--glob"
            "!**/.git/*"
          ];
        in
        {
          defaults.vimgrep_arguments = [
            (lib.getExe pkgs.ripgrep)
            "--color=never"
            "--no-heading"
            "--with-filename"
            "--line-number"
            "--column"
            "--smart-case"
          ]
          ++ rgArgs;
          pickers.find_files.find_command = [
            (lib.getExe pkgs.ripgrep)
            "--files"
          ]
          ++ rgArgs;
        };
    };
}
