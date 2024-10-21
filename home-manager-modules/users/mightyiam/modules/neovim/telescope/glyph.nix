{
  programs.nixvim = {
		extraPackages = [

		];
		plugins.telescope = {
enabledExtensions = ["glyph"];
			keymaps = {
				"<leader>fu" = {
					action = "glyph";
				};
			};
		};
	};
}

