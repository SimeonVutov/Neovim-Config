-- ~/.config/nvim/lua/plugins/render-markdown.lua
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.nvim", -- optional but recommended by the plugin
    },
    opts = {
      enabled = true,

      -- Filetypes where rendering is enabled
      render_modes = true,
      file_types = { "markdown", "Avante" },

      -- Anti-conceal behavior while editing
      anti_conceal = {
        enabled = true,
        above = 0,
        below = 0,
      },

      -- Heading rendering
      heading = {
        enabled = true,

        -- Set to false if you want raw "#"
        sign = true,
        icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },

        -- Background width style:
        -- "full" = whole line
        -- "block" = just heading content
        -- "inline" = compact
        width = "block",

        -- left/right padding around heading text
        left_pad = 1,
        right_pad = 1,

        -- extra space before headings
        position = "overlay",

        -- border styles around headings
        borders = false,
        border_virtual = false,

        -- Highlight groups per level
        backgrounds = {
          "RenderMarkdownH1Bg",
          "RenderMarkdownH2Bg",
          "RenderMarkdownH3Bg",
          "RenderMarkdownH4Bg",
          "RenderMarkdownH5Bg",
          "RenderMarkdownH6Bg",
        },
        foregrounds = {
          "RenderMarkdownH1",
          "RenderMarkdownH2",
          "RenderMarkdownH3",
          "RenderMarkdownH4",
          "RenderMarkdownH5",
          "RenderMarkdownH6",
        },
      },

      -- Code blocks
      code = {
        enabled = true,
        sign = true,
        width = "full",
        right_pad = 1,
        left_pad = 1,
        border = "thin",
        above = " ",
        below = " ",
        highlight = "RenderMarkdownCode",
        highlight_inline = "RenderMarkdownCodeInline",
      },

      -- Bullet lists
      bullet = {
        enabled = true,
        icons = { "●", "○", "◆", "◇" },
        ordered_icons = function(ctx)
            local value = vim.trim(ctx.value)
            local index = tonumber(value:sub(1, #value - 1))
            return ('%d.'):format(index > 1 and index or ctx.index)
        end,
      },

      -- Checkboxes
      checkbox = {
        enabled = true,
        unchecked = {
          icon = "󰄱 ",
          highlight = "RenderMarkdownUnchecked",
        },
        checked = {
          icon = "󰱒 ",
          highlight = "RenderMarkdownChecked",
        },
        custom = {
          todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
          important = { raw = "[!]", rendered = " ", highlight = "RenderMarkdownWarn" },
        },
      },

      -- Block quotes
      quote = {
        enabled = true,
        icon = "▋",
        repeat_linebreak = false,
      },

      -- Pipe tables
      pipe_table = {
        enabled = true,
        preset = "round",
        style = "full",
        cell = "padded",
        padding = 1,
        min_width = 0,
        border = {
          "┌", "┬", "┐",
          "├", "┼", "┤",
          "└", "┴", "┘",
          "│", "─",
        },
      },

      -- Callouts / Obsidian-like blocks
      callout = {
        note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
        tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownSuccess" },
        important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint" },
        warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "RenderMarkdownWarn" },
        caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "RenderMarkdownError" },
      },

      -- Links
      link = {
        enabled = true,
        image = "󰥶 ",
        email = "󰀓 ",
        hyperlink = "󰌹 ",
        wiki = { icon = "󱗖 " },
        custom = {
          web = { pattern = "^https?://", icon = "󰖟 " },
          github = { pattern = "github%.com", icon = "󰊤 " },
        },
      },

      -- Inline markdown highlights
      inline_highlight = {
        enabled = true,
      },

      -- Horizontal rules
      dash = {
        enabled = true,
        icon = "─",
        width = "full",
      },

      -- HTML rendering
      html = {
        enabled = true,
      },

      -- LaTeX / math conceal
      latex = {
        enabled = true,
      },

      -- Indentation guides for nested content
      indent = {
        enabled = false, -- set true if you want nested guides
        per_level = 2,
        skip_level = 1,
        skip_heading = false,
      },
    },

    config = function(_, opts)
      require("render-markdown").setup(opts)

      -- Useful keymaps
      vim.keymap.set("n", "<leader>mr", function()
        local ok, state = pcall(require, "render-markdown.state")
        if ok and state.enabled then
          vim.cmd("RenderMarkdown disable")
        else
          vim.cmd("RenderMarkdown enable")
        end
      end, { desc = "Toggle Render Markdown" })
    end,
  },
}
