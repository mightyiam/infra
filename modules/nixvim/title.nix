{
  flake.modules.nixvim.astrea.globalOpts = {
    title = true;
    titlestring = "\ %{substitute(getcwd(),\ $HOME,\ '~',\ '''''')}";
  };
}
