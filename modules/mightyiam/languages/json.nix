{
  home.base = {pkgs, ...}: {
    home.packages = with pkgs; [
      fx
      jd-diff-patch
      jq
    ];
  };

  armilaria = {
    lsp.servers.jsonls = {
      enable = true;
      packageFallback = true;
    };
  };
}
