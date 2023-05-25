local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")
local lain = require("lain")

local memicon = wibox.widget.imagebox(beautiful.memicon)

local mem = lain.widget.mem {
	timeout = 3,
	settings = function()
		local level = mem_now.used .. "mb"
		widget:set_markup(level)
	end
}

local membox = wibox.container {
	{
		layout = wibox.layout.fixed.horizontal,
		{
			layout = wibox.container.margin,
			left = 10,
			top = 8,
			bottom = 8,
			memicon,
		},			
		{
			layout = wibox.container.margin,
			left = 8,
			right = 10,
			mem,
		},
	},
	layout = wibox.container.background,
	shape = gears.shape.rounded_rect,
	-- shape_border_width = beautiful.border_width,
	-- shape_border_color = beautiful.bg_normal,
	fg = beautiful.black,
	bg = beautiful.yellow,
}

membox_container = wibox.container {
	{
		layout = wibox.container.margin,
		bottom = 5,
		membox,
	},
	layout = wibox.container.background,
	shape = gears.shape.rounded_rect,
	bg = beautiful.darkyellow,
}

