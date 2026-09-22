{lib, ...}: {
  home.base = {
    programs = {
      git = {
        settings = {
          merge.conflictStyle = lib.mkDefault "zdiff3";
          rerere.enabled = true;
        };
      };
      mergiraf = {
        enable = true;
        enableGitIntegration = true;
        enableJujutsuIntegration = true;
      };
    };
  };
}
