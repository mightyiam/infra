{
  programs.nixvim.plugins.lsp = {
    enable = true;
    inlayHints = true; # TODO test

    imports = [
	    ./inlay-hints.nix
	    ./keymaps.nix
	    ./servers
    ];
  };
}
