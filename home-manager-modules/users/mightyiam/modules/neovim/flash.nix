{config, ...}: {
  programs.nixvim = {
	  plugins.flash.enable = true;
	  keymaps = [
	  {
	    key = "s";
	    mode = ["n" "x" "o"];
	    action = config.lib.nixvim.mkRaw ''function() require("flash").jump() end'';
	  options.desc = "Flash";
	  }
	  ];
  };
}
