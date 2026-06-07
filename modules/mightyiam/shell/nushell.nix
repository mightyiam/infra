{
  home.base = {
    programs.nushell.enable = true;
  };
  nixos.modules.base = {pkgs, ...}: {
    users.users.mightyiam = {
      useDefaultShell = false;
      shell = pkgs.nushell;
    };
  };
}
