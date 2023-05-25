local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")

-- Create a textclock widget
local textclock = {
	widget = wibox.widget.textclock,
	format = '%H:%M'
}

local textdate = {
	widget = wibox.widget.textclock,
	format = '%a %b %d'
}

local dateicon = wibox.widget.imagebox(beautiful.dateicon)
local clockicon = wibox.widget.imagebox(beautiful.clockicon)

datebox = wibox.container {
	{
		{
			{
				layout = wibox.layout.fixed.horizontal,
				{
					layout = wibox.container.margin,
					left = 10,
					top = 6,
					bottom = 8,
					dateicon,
				},			
				{
					layout = wibox.container.margin,
					left = 10,
					right = 10,
					textdate, 
				},
			},
			layout = wibox.container.background,
			shape = gears.shape.rounded_rect,
			-- shape_border_width = beautiful.border_width,
			-- shape_border_color = beautiful.bg_normal,
			fg = beautiful.black,
			bg = beautiful.blue,
		},
		layout = wibox.container.margin,
		bottom = 5,
	},
	layout = wibox.container.background,
	shape = gears.shape.rounded_rect,
	bg = beautiful.darkblue,
}

clockbox = wibox.container {
	{
		{
			{
				layout = wibox.layout.fixed.horizontal,
				{
					layout = wibox.container.margin,
					left = 10,
					top = 7,
					bottom = 7,
					clockicon,
				},			
				{
					layout = wibox.container.margin,
					left = 10,
					right = 10,
					textclock, 
				},
			},
			layout = wibox.container.background,
			shape = gears.shape.rounded_rect,
			-- shape_border_width = beautiful.border_width,
			-- shape_border_color = beautiful.bg_normal,
			fg = beautiful.black,
			bg = beautiful.green,
		},
		layout = wibox.container.margin,
		bottom = 5,
	},
	layout = wibox.container.background,
	shape = gears.shape.rounded_rect,
	bg = beautiful.darkgreen,
}
