{
  home.base = {
    programs = {
      nushell.enable = true;
      starship.settings.character.disabled = true;
    };
  };
  nixos.modules.base = {pkgs, ...}: {
    users.users.mightyiam = {
      useDefaultShell = false;
      shell = pkgs.nushell;
    };
  };
}
