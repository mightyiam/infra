{ inputs, ... }:
{
  flake.modules.nixvim.astrea =
    { pkgs, ... }:
    {
      extraPlugins = [
        {
          plugin = pkgs.vimUtils.buildVimPlugin {
            pname = "vim-autoread";
            version = "unstable";
            src = inputs.vim-autoread;
          };
          config = ''
            autocmd VimEnter * nested WatchForChangesAllFile!
          '';
        }
      ];
    };
}
