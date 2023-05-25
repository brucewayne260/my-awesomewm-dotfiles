local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")

local mykeyboardlayout = awful.widget.keyboardlayout()
local keymapicon = wibox.widget.imagebox(beautiful.keymapicon)

local keyboardlayoutbox = wibox.container {
	{
		layout = wibox.layout.fixed.horizontal,
		{
			layout = wibox.container.margin,
			left = 10,
			top = 9,
			bottom = 7,
			keymapicon
		},			
		{
			layout = wibox.container.margin,
			right = 3,
			mykeyboardlayout,
		},
	},
	layout = wibox.container.background,
	shape = gears.shape.rounded_rect,
	-- shape_border_width = beautiful.border_width,
	-- shape_border_color = beautiful.bg_normal,
	fg = beautiful.fg_normal,
	bg = beautiful.white,
}

keyboardlayoutbox_container = wibox.container {
	{
		layout = wibox.container.margin,
		bottom = 5,
		keyboardlayoutbox,
	},
	layout = wibox.container.background,
	shape = gears.shape.rounded_rect,
	bg = beautiful.grey,
}

