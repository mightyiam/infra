{ self, pkgs, ... }:
{
  extraPlugins = [
    {
      plugin = pkgs.vimUtils.buildVimPlugin {
        pname = "vim-autoread";
        version = "24061f84652d768bfb85d222c88580b3af138dab";
        src = self.inputs.vim-autoread;
      };
      config = ''
        autocmd VimEnter * nested WatchForChangesAllFile!
      '';
    }
  ];
}
