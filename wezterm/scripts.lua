local wezterm = require("wezterm")

local M = {}

local function get_script_choices()
	local env_variable

	if package.config:sub(1, 1) == "\\" then
		env_variable = "USERPROFILE"
	else
		env_variable = "HOME"
	end

	local scripts_path = string.format("%s/.config/terminal/scripts", os.getenv(env_variable))

	local choices = {}

	for _, path in ipairs(wezterm.glob(scripts_path .. "/*.nu")) do
		-- Captures last non-slash sequence.
		local filename = path:match("[^/]+$")

		choices[#choices + 1] = { label = filename, id = path }
	end

	for _, path in ipairs(wezterm.glob(scripts_path .. "/*/*.nu")) do
		-- Captures last two non-slash sequences.
		local dirname, filename = path:match("([^/]+)/([^/]+)$")

		choices[#choices + 1] = { label = dirname .. " / " .. filename, id = path }
	end

	if #choices == 0 then
		wezterm.log_error("No .nu scripts found in " .. scripts_path)
		return nil
	end

	return choices
end

function M.show_picker(window, pane)
	local choices = get_script_choices()

	if not choices then
		return
	end

	window:perform_action(
		wezterm.action.InputSelector({
			title = "Run Script",
			fuzzy_description = "Script: ",
			choices = choices,
			fuzzy = true,
			action = wezterm.action_callback(function(win, pn, id, _label)
				if not id then
					return
				end
				pn:send_text('nu --experimental-options "native-clip=true" "' .. id .. '"\r')
			end),
		}),
		pane
	)
end

return M
