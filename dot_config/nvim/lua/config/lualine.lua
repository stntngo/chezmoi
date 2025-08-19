local colors = require("colors")

local mode_color = {
  ["n"]   = colors.blue,
  ["i"]   = colors.orange,
  ["v"]   = colors.green,
  ["\22"] = colors.green,  -- visual block (Ctrl-V)
  ["V"]   = colors.green,
  ["c"]   = colors.magenta,
  ["no"]  = colors.red,
  ["s"]   = colors.orange,
  ["S"]   = colors.orange,
  ["\19"] = colors.orange, -- select block (Ctrl-S)
  ["ic"]  = colors.yellow,
  ["R"]   = colors.violet,
  ["Rv"]  = colors.violet,
  ["cv"]  = colors.red,
  ["ce"]  = colors.red,
  ["r"]   = colors.cyan,
  ["rm"]  = colors.cyan,
  ["r?"]  = colors.cyan,
  ["!"]   = colors.red,
  ["t"]   = colors.violet,
}

-- helpers
local function buffer_not_empty()
  local name = vim.fn.expand("%:t")
  return vim.fn.empty(name) ~= 1
end

local function match_file_type(buf_ft)
  return function(client)
    local fts = client.config and client.config.filetypes
    if not fts then return false end
    for _, ft in ipairs(fts) do
      if ft == buf_ft then return true end
    end
    return false
  end
end

local function active_lsp()
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local clients = vim.lsp.get_active_clients()

  for _, client in ipairs(clients) do
    if match_file_type(buf_ft)(client) then
      return client.name
    end
  end

  return "no active LSP"
end

local function active_mode()
  return { fg = mode_color[vim.fn.mode()] }
end

local function component(field, opts)
  opts = opts or {}
  opts[1] = field
  return opts
end

-- lualine config
local config = {
  options = {
    component_separators = "",
    section_separators = "",
    theme = {
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = {
        c = { fg = colors.fg, bg = colors.bg },
        z = { fg = colors.fg, bg = colors.bg },
      },
    },
  },

  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},

    lualine_c = {
      component(function() return "▊" end, {
        color = active_mode,
        padding = { left = 0, right = 1 },
      }),

      component("mode", {
        color = active_mode,
        fmt = string.lower,
        padding = { right = 1 },
      }),

      component("filename"),

      component("filetype", {
        icons_enabled = true,
      }),

      component("filesize", {
        cond = buffer_not_empty,
      }),

      component("location"),

      component("diagnostics", {
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " " },
        diagnostics_color = {
          color_error = { fg = colors.red },
          color_warn  = { fg = colors.yellow },
          color_info  = { fg = colors.cyan },
        },
      }),
    },

    lualine_x = {
      component(active_lsp, {
        color = function()
          -- mirrors original: if the function exists, consider "ready"
          local ready = vim.lsp.buf and vim.lsp.buf.server_ready
          return { fg = ready and colors.green or colors.orange }
        end,
      }),

      component("branch", {
        icons_enabled = false,
        color = { fg = colors.violet },
      }),

      component("diff", {
        diff_color = {
          added    = { fg = colors.green },
          modified = { fg = colors.orange },
          removed  = { fg = colors.red },
        },
      }),

      component(function()
        return string.sub(os.date(), 12, 16)
      end, {
        color = function() return { fg = colors.blue } end,
      }),

      component(function() return "▊" end, {
        color = active_mode,
        padding = { left = 1 },
      }),
    },
  },

  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_x = {},

    lualine_z = {
      component("diff", {
        diff_color = {
          added    = { fg = colors.green },
          modified = { fg = colors.orange },
          removed  = { fg = colors.red },
        },
      }),
    },

    lualine_c = {
      component(function() return vim.fn.expand("%") end, {
        color = { fg = colors.blue },
      }),
    },
  },
}

return config
