{
  flake.modules.homeManager.bow =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.hunspell
        pkgs.hunspellDicts.en-us-large
        pkgs.hunspellDicts.th_TH
      ];
    };
}
