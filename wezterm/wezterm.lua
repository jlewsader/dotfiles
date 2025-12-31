local wezterm = require("wezterm")

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

return {
	color_scheme = "Dracula",
	font_size = 12.0,
	window_decorations = "RESIZE",
}
