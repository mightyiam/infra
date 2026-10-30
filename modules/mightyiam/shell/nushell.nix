{
  home.base = {
    programs = {
      nushell = {
        enable = true;

        # evaluation warning: The default value of `programs.nushell.loadSessionVariables` has changed from `false` to `true`.
        #                     You are currently using the legacy default (`false`) because `home.stateVersion` is less than "26.11".
        #                     To silence this warning and keep legacy behavior, set:
        #                       programs.nushell.loadSessionVariables = false;
        #                     To adopt the new default behavior, set:
        #                       programs.nushell.loadSessionVariables = true;
        loadSessionVariables = true;
      };
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
