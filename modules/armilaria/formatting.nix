{nixvim, ...}: {
  armilaria = nixvimArgs: {
    plugins = {
      none-ls = {
        enable = true;
        sources.formatting.nix_flake_fmt.enable = true;
      };
    };

    extraConfigLuaPre = ''
      vim.api.nvim_create_augroup("FormatOnSave", { clear = true })
    '';

    extraConfigLua = ''
      local function smart_format(opts)
        local bufnr = vim.api.nvim_get_current_buf()

        local function is_none_ls(client)
          return client.name == "null-ls"
        end

        local function is_nix_flake_fmt_available()
          local null_ls = require("null-ls")
          local sources = require("null-ls.sources")

          local matches = null_ls.get_source({
            name = "nix flake fmt",
          })
          if #matches == 0 then return false end

          local source = matches[1]

          local ft = vim.bo[bufnr].filetype
          if not sources.is_available(source, ft) then
            return false
          end

          return true
        end

        if is_nix_flake_fmt_available() then
          -- TODO aren't these guaranteed to be > 0 at this point?
          local none_ls_clients = vim.lsp.get_clients({
            bufnr = bufnr,
            filter = is_none_ls,
          })

          if #none_ls_clients > 0 then
            local initial_tick = vim.api.nvim_buf_get_changedtick(bufnr)

            vim.lsp.buf.format({
              bufnr = bufnr,
              filter = is_none_ls,
              async = false,
              -- TODO ?
              timeout_ms = 15000,
            })

            if vim.api.nvim_buf_get_changedtick(bufnr) ~= initial_tick then
              return
            end
          end
        end

        local other_clients = vim.lsp.get_clients({
          bufnr = bufnr,
          filter = function(client) return not is_none_ls(client) end,
        })

        if #other_clients == 0 then return end

        vim.lsp.buf.format({
          bufnr = bufnr,
          filter = function(client) return not is_none_ls(client) end,
          -- TODO what is the default?
          async = true,
          -- TODO ?
          timeout_ms = 5000,
        })
      end

      vim.api.nvim_create_user_command("Format", function()
        smart_format()
      end, {})
    '';

    autoCmd = [
      {
        event = ["BufWritePre"];
        group = "FormatOnSave";
        pattern = "*";
        callback = nixvim.mkRaw ''
          function()
            if vim.g.format_on_save_enabled ~= false then
              pcall(vim.cmd, 'Format')
            end
          end
        '';
      }
    ];

    keymaps = [
      {
        mode = "n";
        key = "<leader>tf";
        action = nixvim.mkRaw ''
          function()
            if vim.g.format_on_save_enabled == nil then
              vim.g.format_on_save_enabled = true
            end

            vim.g.format_on_save_enabled = not vim.g.format_on_save_enabled
            vim.notify("Format on save: " .. (vim.g.format_on_save_enabled and "ON" or "OFF"))
          end
        '';
        options = {
          desc = "Toggle format on save";
          silent = true;
        };
      }
      {
        key = "<space>f";
        mode = ["n" "v"];
        action = "<cmd>Format<cr>";
        options.desc = "format (nix_flake_fmt, fallback LSP)";
      }
    ];
  };
}
