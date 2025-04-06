{ lib, ... }:
{
  flake.modules = {
    nixvim.astrea = nixvim: {
      plugins.lsp.servers.nixd.enable = true;
      autoCmd = [
        {
          event = "FileType";
          pattern = "nix";
          callback = lib.nixvim.mkRaw ''
            function()
              local function nix_fold(lnum)
                local parser = vim.treesitter.get_parser(0, "nix")
                local tree = parser:parse()[1]
                local node = tree:root():named_descendant_for_range(lnum - 1, 0, lnum - 1, -1)
                if not node then return 0 end
                local node_type = node:type()
                
                -- Debug: Uncomment to diagnose
                -- vim.notify("Line: " .. lnum .. ", Node: " .. node_type)
                
                if node_type == "binding" then
                  local value_node = node:named_child(2)  -- Value after '='
                  if value_node then
                    local start_row, _, end_row, _ = value_node:range()
                    start_row = start_row + 1  -- 0-based to 1-based
                    end_row = end_row + 1
                    if lnum >= start_row and lnum <= end_row then
                      return 1  -- Fold the entire value range
                    end
                  end
                  return 0  -- Name and '=' stay unfolded
                elseif node:parent() then
                  local parent = node:parent()
                  while parent do
                    if parent:type() == "binding" then
                      local value_node = parent:named_child(2)
                      if value_node then
                        local start_row, _, end_row, _ = value_node:range()
                        start_row = start_row + 1
                        end_row = end_row + 1
                        if lnum >= start_row and lnum <= end_row then
                          return 1  -- Fold nested value
                        end
                      end
                      return 0
                    end
                    parent = parent:parent()
                  end
                end
                return 0
              end
              
              local function nix_foldtext()
                local line = vim.fn.getline(vim.v.foldstart)
                local eq_pos = line:find("=")
                if eq_pos then
                  return line:sub(1, eq_pos) .. " <folded>"
                end
                return line .. " <folded>"
              end
              
              vim.notify("Setting foldexpr for nix")
              vim.opt_local.foldmethod = "expr"
              vim.opt_local.foldexpr = "v:lua.vim.b.nix_fold(v:lnum)"
              vim.b.nix_fold = nix_fold
              vim.opt_local.foldenable = true
              vim.opt_local.foldlevel = 0
              vim.opt_local.foldtext = "v:lua.vim.b.nix_foldtext()"
              vim.b.nix_foldtext = nix_foldtext
            end
          '';
        }
      ];
    };
    homeManager.base =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          #nix-melt
          nix-prefetch-scripts
          nixd
          nurl
          statix
        ];
      };
  };
}
