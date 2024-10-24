{ }
# (omitPluginInVSCode vimPlugins.nvim-spectre (embedLua ''
#   require('spectre').setup()
#   local wk = require('which-key')
#
#   wk.register({
#     ["<leader>"] = {
#       s = {
#         s = {
#           '<cmd>lua require("spectre").toggle()<CR>',
#           "Toggle Spectre",
#         },
#         w = {
#           '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
#           "Search current word",
#         },
#         p = {
#           '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
#           "Search current file",
#         },
#       },
#     },
#   })
# ''))
