local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")

local systraybox = wibox.container {
	{
		layout = wibox.container.margin,
		top = 5,
		bottom = 5,
		left = 8,
		right = 8,
		wibox.widget.systray(),				
	},
	layout = wibox.container.background,
	shape = gears.shape.rounded_rect, 
	-- shape_border_width = beautiful.border_width,
	-- shape_border_color = beautiful.grey,
	bg = beautiful.bg_systray,
}

systraybox_container = wibox.container {
	{
		layout = wibox.container.margin,
		bottom = 5,
		systraybox,
	},
	layout = wibox.container.background,
	shape = gears.shape.rounded_rect,
	bg = beautiful.grey,
}

