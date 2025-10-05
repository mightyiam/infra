{
  flake.modules.homeManager.base = {
    programs = {
      zsh.defaultKeymap = "viins";
      nushell.settings.edit_mode = "vi";
    };
  };
}
