{
  homeManager.modules.gui = {pkgs, ...}: {
    home.packages = [
      pkgs.hunspell
      pkgs.hunspellDicts.en-us-large
      pkgs.hunspellDicts.th_TH
    ];
  };
}
