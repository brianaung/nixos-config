return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<Leader>cp", "<Cmd>CodeCompanion<CR>" },
    { "<Leader>cc", "<Cmd>CodeCompanionChat<CR>" },
    { "<Leader>ca", "<Cmd>CodeCompanionActions<CR>" },
    { "<Leader>cd", "<Cmd>CodeCompanionCmd<CR>" },
  },
  opts = {
    adapters = {
      anthropic = function()
        return require("codecompanion.adapters").extend("anthropic", {
          env = {
            api_key = "ANTHROPIC_API_KEY",
          },
          schema = {
            model = {
              default = "claude-3-5-sonnet-latest",
            },
          },
        })
      end,
    },
    strategies = {
      chat = {
        adapter = "anthropic",
        slash_commands = {
          ["buffer"] = {
            opts = {
              provider = "fzf_lua",
            },
          },
          ["file"] = {
            opts = {
              provider = "fzf_lua",
            },
          },
          ["help"] = {
            opts = {
              provider = "fzf_lua",
            },
          },
        },
      },
      inline = {
        adapter = "anthropic",
      },
      agent = {
        adapter = "anthropic",
      },
      cmd = {
        adapter = "anthropic",
      },
    },
  },
}
