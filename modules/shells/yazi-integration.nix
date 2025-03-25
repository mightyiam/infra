{ lib, ... }:
{
  flake.modules.homeManager.base =
    homeArgs:
    let
      zsh = lib.getExe homeArgs.config.programs.zsh.package;
    in
    {
      programs.yazi.settings = {
        open.rules = [
          {
            mime = "inode/directory";
            use = "zsh-dir";
          }
        ];
        opener.zsh-dir = [
          {
            run = ''${zsh} -c "cd $0 && exec ${zsh}"'';
            block = true;
            desc = "Open directory in zsh";
          }
        ];
      };
    };
}
