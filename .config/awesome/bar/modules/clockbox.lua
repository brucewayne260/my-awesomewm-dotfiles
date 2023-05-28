local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")

local textclock = {
	widget = wibox.widget.textclock,
	format = '%H:%M'
}

local clockicon = wibox.widget.imagebox(beautiful.clockicon)
local clockbox = wibox.container.background()
local clockbox_margin = wibox.container.margin()
clockbox_container = wibox.container.background()

local pressed = function()
	clockbox_container:set_bg(beautiful.transparent)
	clockbox_margin:set_top(5)
	clockbox_margin:set_bottom(0)
end

local released = function()
	clockbox_container:set_bg(beautiful.darkgreen)
	clockbox_margin:set_top(0)
	clockbox_margin:set_bottom(5)
end

clockbox = wibox.container {
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
	bg = beautiful.green,
}

clockbox_margin = wibox.container {
	clockbox,	
	layout = wibox.container.margin,
}

clockbox_container = wibox.container {
	clockbox_margin,
	layout = wibox.container.background,
	shape = gears.shape.rounded_rect,
}

clockbox_container:connect_signal("button::press", function()
	pressed()
end)
clockbox_container:connect_signal("mouse::leave", function()
	released()
end)
clockbox_container:connect_signal("button::release", function()
	released()
end)

released()

