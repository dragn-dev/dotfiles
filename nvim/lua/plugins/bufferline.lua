return {'akinsho/bufferline.nvim',
version = "*",
event = 'VeryLazy',
dependencies = 'nvim-tree/nvim-web-devicons',
config = function()
require("bufferline").setup{
options  = {
        close_command = 'bd! %d', -- can be a string | function, see "Mouse actions"
    }
}
end,
}
