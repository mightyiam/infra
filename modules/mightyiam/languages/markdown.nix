{
  armilaria = {
    lsp.servers.marksman = {
      enable = true;
      packageFallback = true;
    };
  };

  home.gui = {pkgs, ...}: {
    home.packages = with pkgs; [gh-markdown-preview];
  };
}
