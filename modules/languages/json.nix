{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        fx
        jd-diff-patch
        jq
      ];
    };
}
