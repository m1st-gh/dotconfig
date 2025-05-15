colors = {
	-- The default text color
	foreground = "#abb2bf",
	-- The default background color
	background = "#1e222a",

	-- Overrides the cell background color when the current cell is occupied by the
	-- cursor and the cursor style is set to Block
	cursor_bg = "#abb2bf",
	-- Overrides the text color when the current cell is occupied by the cursor
	cursor_fg = "#1e222a",
	-- Specifies the border color of the cursor when the cursor style is set to Block,
	-- or the color of the vertical or horizontal bar when the cursor style is set to
	-- Bar or Underline.
	cursor_border = "#98c379",

	-- the foreground color of selected text
	selection_fg = "#abb2bf",
	-- the background color of selected text
	selection_bg = "#353b45",

	-- The color of the scrollbar "thumb"; the portion that represents the current viewport
	scrollbar_thumb = "#282c34",

	-- The color of the split lines between panes
	split = "#31353d",

	brights = {
		"#1e222a", -- black
		"#e06c75", -- red
		"#98c379", -- green
		"#e5c07b", -- yellow
		"#61afef", -- blue
		"#c678dd", -- purple
		"#56b6c2", -- teal
		"#abb2bf", -- white
	},
	ansi = {
		"#545862", -- bright black
		"#DE8C92", -- bright red
		"#7eca9c", -- bright green
		"#EBCB8B", -- bright yellow
		"#81A1C1", -- bright blue
		"#de98fd", -- bright magenta
		"#a3b8ef", -- bright cyan
		"#c8ccd4", -- bright white
	},

	-- Arbitrary colors of the palette in the range from 16 to 255
	indexed = {
		[136] = "#d19a66", -- orange
		[137] = "#be5046", -- dark red
		[138] = "#ff75a0", -- pink
	},

	-- Since: 20220319-142410-0fcdea07
	-- When the IME, a dead key or a leader key are being processed and are effectively
	-- holding input pending the result of input composition, change the cursor
	-- to this color to give a visual cue about the compose state.
	compose_cursor = "#fca2aa",

	-- Colors for copy_mode and quick_select
	-- available since: 20220807-113146-c2fee766
	-- In copy_mode, the color of the active text is:
	-- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
	-- 2. selection_* otherwise
	copy_mode_active_highlight_bg = { Color = "#373b43" },
	-- use `AnsiColor` to specify one of the ansi color palette values
	-- (index 0-15) using one of the names "Black", "Maroon", "Green",
	--  "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
	-- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
	copy_mode_active_highlight_fg = { AnsiColor = "Black" },
	copy_mode_inactive_highlight_bg = { Color = "#98c379" },
	copy_mode_inactive_highlight_fg = { AnsiColor = "White" },

	quick_select_label_bg = { Color = "#61afef" },
	quick_select_label_fg = { Color = "#1e222a" },
	quick_select_match_bg = { Color = "#e06c75" },
	quick_select_match_fg = { Color = "#1e222a" },

	input_selector_label_bg = { Color = "#61afef" },
	input_selector_label_fg = { Color = "#1e222a" },
}
