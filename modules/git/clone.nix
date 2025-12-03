{ lib, ... }:
{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.git.settings.init.templateDir =
        pkgs.writeTextDir "config" ''
          [remote "origin"]
              fetch = +refs/heads/*:refs/remotes/origin/*
        ''
        |> lib.getAttr "outPath";
    };
}
