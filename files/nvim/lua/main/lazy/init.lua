-- build a data folder for lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" -- $HOME/.local/share/nvim/lazy/lazy.nvim

if not vim.loop.fs_stat(lazypath) then
    -- install lazy.nvim to  into the data folder
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

-- add lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- Load lazy.nvim and set up plugins
require("lazy").setup({
    {
        import = "main.lazy.plugins" -- import lua files whose name ends as "*.lua" in "plugins" folder
    },
    {
        import = "main.lazy.lsps" -- import lua files whose name ends as "*.lua" in "lsps" folder
    }
},
{
    checker = {
        enabled = true, -- automatically check for plugin updates
        notify = false, -- disable notifications for updates
    },
    change_detection = {
        enabled = true, -- enable change detection
        notify = false, -- disable notifications for changes
    },
})
