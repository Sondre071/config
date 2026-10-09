-- Keymaps

-- Indentation
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 4 -- Number of spaces for auto-indent
vim.opt.tabstop = 4 -- Number of spaces a tab counts for
vim.opt.softtabstop = 4 -- Number of spaces a tab counts for while editing

-- Keys
vim.g.mapleader = " "
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank selection to clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set("v", "<leader>p", '"+p', { desc = "Paste from clipboard, replacing selection" })

-- Tab state
local function set_user_var(name, value)
    io.write(string.format("\027]1337;SetUserVar=%s=%s\007", name, vim.base64.encode(value)))
end

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        set_user_var("IS_NVIM", "true")
        io.write("\027]0;neovim\007")
        io.flush()
    end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
    once = true,
    callback = function()
        set_user_var("IS_NVIM", "false")
    end,
})

-- Default shell
vim.o.shell = "pwsh"
vim.o.shellcmdflag =
    "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';"

-- Setting shell redirection
vim.o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'

-- Setting shell pipe
vim.o.shellpipe = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'

-- Setting shell quote options
vim.o.shellquote = ""
vim.o.shellxquote = ""