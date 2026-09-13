local wezterm = require("wezterm")

local M = {}

function M.load()
    local env_variable

    if package.config:sub(1, 1) == "\\" then
        env_variable = "USERPROFILE"
    else
        env_variable = "HOME"
    end

    local path = string.format("%s/.config/terminal/background.json", os.getenv(env_variable))

    local file = io.open(path, "r")

    if not file then
        wezterm.log_info("No background file found in: " .. path)
        return nil
    end

    local json = file:read("*all")
    file:close()

    local image = json:match('"image":%s"([^"]+)"')
    local brightness = tonumber(json:match('"brightness":%s(%-?[%.%d]+)'))
    local saturation = tonumber(json:match('"saturation":%s(%-?[%.%d]+)'))

    if image == nil or image == "" then
        wezterm.log_warn("No background image path found in: " .. path)
        return nil
    end

    if brightness == nil then
        wezterm.log_warn("No brightness found in: " .. path)
        return nil
    end

    if saturation == nil then
        wezterm.log_warn("No saturation found in: " .. path)
        return nil
    end

    return {
        {
            source = {
                File = image,
            },
            width = "Cover",
            hsb = {
                brightness = brightness,
                saturation = saturation,
            },
        },
    }
end

return M
