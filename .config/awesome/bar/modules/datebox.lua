local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")

local textdate = {
	widget = wibox.widget.textclock,
	format = '%a %b %d'
}

local dateicon = wibox.widget.imagebox(beautiful.dateicon)
local datebox = wibox.container.background()
local datebox_margin = wibox.container.margin()
datebox_container = wibox.container.background()

local pressed = function()
	datebox_container:set_bg(beautiful.transparent)
	datebox_margin:set_top(5)
	datebox_margin:set_bottom(0)
end

local released = function()
	datebox_container:set_bg(beautiful.darkblue)
	datebox_margin:set_top(0)
	datebox_margin:set_bottom(5)
end

datebox = wibox.container {
	{
		layout = wibox.layout.fixed.horizontal,
		{
			layout = wibox.container.margin,
			left = 10,
			top = 7,
			bottom = 7,
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
	bg = beautiful.blue,
}

datebox_margin = wibox.container {
	datebox,	
	layout = wibox.container.margin,
}

datebox_container = wibox.container {
	datebox_margin,
	layout = wibox.container.background,
	shape = gears.shape.rounded_rect,
}

datebox_container:connect_signal("button::press", function()
	pressed()
end)
datebox_container:connect_signal("mouse::leave", function()
	released()
end)
datebox_container:connect_signal("button::release", function()
	released()
end)

released()

