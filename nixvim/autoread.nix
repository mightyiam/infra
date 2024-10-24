{ pkgs, ... }:
{
  extraPlugins = [
    {
      plugin = pkgs.vimUtils.buildVimPlugin rec {
        pname = "vim-autoread";
        version = "24061f84652d768bfb85d222c88580b3af138dab";
        src = pkgs.fetchFromGitHub {
          owner = "djoshea";
          repo = "vim-autoread";
          rev = version;
          sha256 = "fSADjNt1V9jgAPjxggbh7Nogcxyisi18KaVve8j+c3w=";
        };
      };
      config = ''
        autocmd VimEnter * nested WatchForChangesAllFile!
      '';
    }
  ];
}
