{
  flake.modules.homeManager.base.programs.git = {
    extraConfig = {
      merge.conflictstyle = "zdiff3";
      rerere.enabled = true;
    };
  };
}
