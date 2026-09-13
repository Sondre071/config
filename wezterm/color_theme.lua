local M = {}

local function load_campbell()
    return {
        -- Text color
        foreground = "#d9d9d9",

        -- Background
        background = "#0c0c0c",

        cursor_fg = "#0c0c0c",
        cursor_border = "#ffffff",
        cursor_bg = "#ffffff",

        ansi = {
            "#0c0c0c",
            "#c50f1f",
            "#13a10e",
            "#c19c00",
            "#0037da",
            "#881798",
            "#3a96dd",
            "#d9d9d9",
        },

        brights = {
            "#767676",
            "#e74856",
            "#16c60c",
            "#f9f1a5",
            "#3b78ff",
            "#b4009e",
            "#61d6d6",
            "#f2f2f2",
        },

        -- Pane split color
        split = "#555555",
    }
end

local function load_new()
    return {
        -- Text color
        foreground = "#d8d8d8",

        background = "#000000",

        cursor_fg = "#0c0c0c",
        cursor_border = "#ffffff",
        cursor_bg = "#ffffff",

        ansi = {
            "#000000",
            "#c41414",
            "#0acc00",
            "#ded148",
            "#0b2ad9",
            "#d90bd9",
            "#0bd9d9",
            "#d8d8d8",
        },

        brights = {
            "#808080",
            "#ea2828",
            "#25fc19",
            "#f9ef89",
            "#1938ff",
            "#ff19ff",
            "#18f3f3",
            "#ffffff",
        },

        -- Pane split color
        split = "#555555",
    }
end

--M.load = load_new
M.load = load_campbell

return M
