{
  flake.modules.nixvim.base.globalOpts = {
    title = true;
    titlestring = "\ %{substitute(getcwd(),\ $HOME,\ '~',\ '''''')}";
  };
}
