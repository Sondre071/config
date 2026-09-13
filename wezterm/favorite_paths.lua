local wezterm = require("wezterm")

local M = {}

local function get_favorite_paths()
    local env_variable

    if package.config:sub(1, 1) == "\\" then
        env_variable = "USERPROFILE"
    else
        env_variable = "HOME"
    end

    local path = string.format("%s/.config/terminal/favorite_paths", os.getenv(env_variable))

    local choices = {}

    local file = io.open(path, "r")

    if not file then
        wezterm.log_error("Could not read file: " .. path)
        return nil
    end

    local index = 1

    for line in file:lines() do
        choices[#choices + 1] = { label = line, id = index .. line }
        index = index + 1
    end

    file:close()

    if #choices == 0 then
        wezterm.log_warn("No paths saved in: " .. path)
        return nil
    end

    return choices
end

function M.show_picker(window, pane)
    local choices = get_favorite_paths()

    if not choices then
        return
    end

    window:perform_action(
        wezterm.action.InputSelector({
            title = "Move to path",
            fuzzy_description = "Path: ",
            choices = choices,
            fuzzy = true,
            action = wezterm.action_callback(function(win, pn, _id, label)
                if not label then
                    return
                end
                pn:send_text('cd "' .. label .. '"\r')
            end),
        }),
        pane
    )
end

return M
