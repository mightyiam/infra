{
  flake.modules.homeManager.wife =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.hunspell
        pkgs.hunspellDicts.en-us-large
        pkgs.hunspellDicts.th_TH
      ];
    };
}
