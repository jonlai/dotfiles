-- plugins
vim.pack.add({
  "https://github.com/airblade/vim-gitgutter",
  "https://github.com/alexghergh/nvim-tmux-navigation",
  "https://github.com/folke/flash.nvim",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/jonlai/smyth",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/tpope/vim-sleuth",
});

-- general settings
vim.opt.showmatch = true
vim.opt.wrap = false
vim.opt.foldenable = false
vim.opt.updatetime = 500
vim.opt.colorcolumn = "81,101"

-- indentation
vim.opt.shiftround = true
vim.opt.expandtab = true

-- line numbering
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
  pattern = "*",
  callback = function()
    vim.opt.relativenumber = not vim.opt.relativenumber:get()
  end,
})

-- mappings
vim.g.mapleader = " "
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "q:", "<nop>")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "<leader>x", "gcc", { silent = true, remap = true })
vim.keymap.set("v", "<leader>x", "gc", { silent = true, remap = true })
vim.keymap.set("n", "<leader>n", "<cmd>Inspect<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>bd<cr>")
vim.keymap.set({ "n", "i", "v" }, "<c-j>", "<cmd>bp<cr>")
vim.keymap.set({ "n", "i", "v" }, "<c-k>", "<cmd>bn<cr>")
vim.keymap.set("n", "<leader>h", function()
  vim.opt.hlsearch = not vim.opt.hlsearch:get()
end)

-- jonlai/smyth
vim.cmd("colorscheme smyth")

-- airblade/vim-gitgutter
vim.g.gitgutter_map_keys = 0
vim.g.gitgutter_sign_priority = 5

-- alexghergh/nvim-tmux-navigation
local nvim_tmux = require("nvim-tmux-navigation")
vim.keymap.set("n", "<c-space>x", "<c-w>q")
vim.keymap.set("v", "<c-space>x", "<esc><c-w>q")
vim.keymap.set({ "n", "i" }, "<c-space>h", nvim_tmux.NvimTmuxNavigateLeft)
vim.keymap.set({ "n", "i" }, "<c-space>j", nvim_tmux.NvimTmuxNavigateDown)
vim.keymap.set({ "n", "i" }, "<c-space>k", nvim_tmux.NvimTmuxNavigateUp)
vim.keymap.set({ "n", "i" }, "<c-space>l", nvim_tmux.NvimTmuxNavigateRight)

-- folke/flash.nvim
local flash = require("flash")
vim.keymap.set("v", "f", flash.jump)
vim.keymap.set("n", "<leader>f", flash.jump)
vim.keymap.set("n", "<leader>s", flash.treesitter_search)

-- ibhagwan/fzf-lua
vim.keymap.set("n", "<leader>g", "<cmd>FzfLua git_files<cr>", { silent = true })

-- nvim-lualine/lualine.nvim
require("lualine").setup {
  options = {
    icons_enabled = false,
    theme = "smyth",
    component_separators = { left = "|", right = "|"},
    section_separators = { left = "", right = ""},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {"mode"},
    lualine_b = {
      { "branch", icons_enabled = true, icon = "" },
      "diagnostics",
    },
    lualine_c = {"lsp_status"},
    lualine_x = {"fileformat", "filetype"},
    lualine_y = {"progress"},
    lualine_z = {
      { "location", icons_enabled = true, icon = "\u{2632}" },
    },
  },
  inactive_sections = {
    lualine_c = {"filename"},
    lualine_x = {
      { "location", icons_enabled = true, icon = "\u{2632}" },
    },
  },
  tabline = {
    lualine_a = {
      {
        "buffers",
        buffers_color = {
          active = "lualine_a_replace",
          inactive = "lualine_c_normal",
        },
        symbols = { modified = "✱", alternate_file = "", directory = "" },
      },
    },
    lualine_z = {
      { "encoding", color = "lualine_b_normal" },
    },
  },
  extensions = {},
}

-- strip whitespace while preserving cursor position, for all non-markdown files
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "markdown" then
      return
    end
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, cursor_pos)
  end,
})

