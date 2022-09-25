local status_ok, rt = pcall(require, "rust-tools")
if not status_ok then
  return
end
local lsp_installer_servers = require "nvim-lsp-installer.servers"
local _, requested_server = lsp_installer_servers.get_server "rust_analyzer"
    rt.setup({
      tools = {
        autoSetHints = true,
        -- hover_with_actions = true,
        hover_actions = {
            auto_focus = true
        },
        runnables = {
            use_telescope = true,
        },
    },
    server = {
      -- on_attach = function(_, bufnr)
      --   -- Hover actions
      --   vim.keymap.set("n", "<Leader>z", rt.hover_actions.hover_actions, { buffer = bufnr })
      --   -- Code action groups
      --   vim.keymap.set("n", "<Leader>x", rt.code_action_group.code_action_group, { buffer = bufnr })
      -- end,
      on_attach = require("user.lsp.handlers").on_attach,
      capabilities = require("user.lsp.handlers").capabilities,
      settings = {
        -- to enable rust-analyzer settings visit:
        -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
        ["rust-analyzer"] = {
          cmd_env = requested_server._default_options.cmd_env,
            -- enable clippy on save
            lens = {
              enable = true,
            }, 
            checkOnSave = {
                command = "clippy"
            },
        }
    }
    },
  })