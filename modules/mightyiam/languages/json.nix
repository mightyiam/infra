{
  home.base = {pkgs, ...}: {
    home.packages = with pkgs; [
      fx
      jd-diff-patch
      jq
    ];
  };
}
