{ self, pkgs, ... }:
{
  extraPlugins = [
    {
      plugin = pkgs.vimUtils.buildVimPlugin {
        pname = "vim-autoread";
        version = "unstable";
        src = self.inputs.vim-autoread;
      };
      config = ''
        autocmd VimEnter * nested WatchForChangesAllFile!
      '';
    }
  ];
}
