{
  flake.modules.homeManager.base = {
    programs = {
      git = {
        settings = {
          merge.conflictstyle = "zdiff3";
          rerere.enabled = true;
        };
      };
      mergiraf.enable = true;
    };
  };
}
