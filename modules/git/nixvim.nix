{
  flake.modules.nixvim.base = {
    plugins.gitsigns = {
      enable = true;
      settings.on_attach =
        # lua
        ''
          function(bufnr)
            local gitsigns = require('gitsigns')

            local function map(mode, l, desc, r, opts)
              opts = opts or {}
              opts.desc = desc
              opts.buffer = bufnr
              vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']c', "next hunk", function()
              if vim.wo.diff then
                vim.cmd.normal({']c', bang = true})
              else
                gitsigns.nav_hunk('next')
              end
            end)

            map('n', '[c', "prev hunk", function()
              if vim.wo.diff then
                vim.cmd.normal({'[c', bang = true})
              else
                gitsigns.nav_hunk('prev')
              end
            end)

            -- Actions
            map('n', '<leader>hs', "stage hunk", gitsigns.stage_hunk)
            map('n', '<leader>hr', "reset hunk", gitsigns.reset_hunk)

            map('v', '<leader>hs', "stage hunk", function()
              gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
            end)

            map('v', '<leader>hr', "reset hunk", function()
              gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
            end)

            map('n', '<leader>hS', "stage buffer", gitsigns.stage_buffer)
            map('n', '<leader>hR', "reset buffer", gitsigns.reset_buffer)
            map('n', '<leader>hp', "preview hunk", gitsigns.preview_hunk)
            map('n', '<leader>hi', "preview hunk inline", gitsigns.preview_hunk_inline)

            map('n', '<leader>hb', "blame line", function()
              gitsigns.blame_line({ full = true })
            end)

            map('n', '<leader>hd', "diff", gitsigns.diffthis)

            map('n', '<leader>hD', "diff ~", function()
              gitsigns.diffthis('~')
            end)

            map('n', '<leader>hQ', "hunk list workspace", function() gitsigns.setqflist('all') end)
            map('n', '<leader>hq', "hunk list buffer", gitsigns.setqflist)

            -- Toggles
            map('n', '<leader>tb', "line blame", gitsigns.toggle_current_line_blame)
            map('n', '<leader>tw', "toggle word diff", gitsigns.toggle_word_diff)

            -- Text object
            map({'o', 'x'}, 'ih', "select hunk", gitsigns.select_hunk)
          end
        '';
    };
  };
}
