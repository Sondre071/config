local wezterm = require("wezterm")

local act = wezterm.action

local function is_nvim(pane)
    local success, vim_env = pcall(function()
        return pane:get_user_vars().IS_NVIM
    end)

    return success and vim_env == "true"
end

local M = {}

function M.build_keys()
    return {

        -- Switch key table
        {
            key = "w",
            mods = "CTRL",
            action = wezterm.action_callback(function(window, pane)
                if is_nvim(pane) then
                    window:perform_action(
                        act.SendKey({
                            key = "w",
                            mods = "CTRL",
                        }),
                        pane
                    )
                else
                    window:perform_action(
                        act.ActivateKeyTable({
                            name = "pane",
                            one_shot = true,
                        }),
                        pane
                    )
                end
            end),
        },

        -- Menus
        {
			key = "F1",
			mods = "SHIFT",
			action = act.ActivateCommandPalette,
		},
        {
            key = "d",
            mods = "CTRL|SHIFT",
            action = act.ShowDebugOverlay,
        },

        -- Navigation
        {
            key = "LeftArrow",
            mods = "CTRL|SHIFT",
            action = act.SendKey({
                key = "LeftArrow",
                mods = "CTRL|SHIFT",
            }),
        },
        {
            key = "RightArrow",
            mods = "CTRL|SHIFT",
            action = act.SendKey({
                key = "RightArrow",
                mods = "CTRL|SHIFT",
            }),
        },

        -- Paste
        {
            key = "v",
            mods = "CTRL",
            action = act.PasteFrom("Clipboard"),
        },

        -- Tabs
        {
            key = "k",
            mods = "CTRL|SHIFT",
            action = act.SpawnTab("DefaultDomain"),
        },
        {
            key = "j",
            mods = "CTRL|SHIFT",
            action = act.CloseCurrentTab({ confirm = false }),
        },
        {
            key = "h",
            mods = "CTRL|SHIFT",
            action = act.ActivateTabRelative(-1),
        },
        {
            key = "l",
            mods = "CTRL|SHIFT",
            action = act.ActivateTabRelative(1),
        },

        -- Scroll
        {
            key = "y",
            mods = "CTRL",
            action = wezterm.action_callback(function(window, pane)
                if is_nvim(pane) then
                    window:perform_action(
                        act.SendKey({
                            key = "y",
                            mods = "CTRL",
                        }),
                        pane
                    )
                else
                    window:perform_action(act.ScrollByLine(-1), pane)
                end
            end),
        },
        {
            key = "e",
            mods = "CTRL",
            action = wezterm.action_callback(function(window, pane)
                if is_nvim(pane) then
                    window:perform_action(
                        act.SendKey({
                            key = "e",
                            mods = "CTRL",
                        }),
                        pane
                    )
                else
                    window:perform_action(act.ScrollByLine(1), pane)
                end
            end),
        },
        {
            key = "u",
            mods = "CTRL",
            action = wezterm.action_callback(function(window, pane)
                if is_nvim(pane) then
                    window:perform_action(
                        act.SendKey({
                            key = "u",
                            mods = "CTRL",
                        }),
                        pane
                    )
                else
                    window:perform_action(act.ScrollByPage(-1), pane)
                end
            end),
        },
        {
            key = "d",
            mods = "CTRL",
            action = wezterm.action_callback(function(window, pane)
                if is_nvim(pane) then
                    window:perform_action(
                        act.SendKey({
                            key = "d",
                            mods = "CTRL",
                        }),
                        pane
                    )
                else
                    window:perform_action(act.ScrollByPage(1), pane)
                end
            end),
        },
    }
end

function M.build_key_tables()
    return {
        pane = {
            -- Panes
            {
                key = "v",
                action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
            },
            {
                key = "s",
                action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
            },
            {
                key = "c",
                action = act.CloseCurrentPane({ confirm = false }),
            },

            {
                key = "h",
                action = act.ActivatePaneDirection("Left"),
            },
            {
                key = "j",
                action = act.ActivatePaneDirection("Down"),
            },
            {
                key = "k",
                action = act.ActivatePaneDirection("Up"),
            },
            {
                key = "l",
                action = act.ActivatePaneDirection("Right"),
            },
        },
    }
end

return M
