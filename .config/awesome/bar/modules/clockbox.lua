local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")

local textclock = wibox.widget {
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
	if textclock.format == '%H:%M' then
		clockbox:set_bg(beautiful.green)
	else
		clockbox:set_bg(beautiful.blue)
	end
end

local released = function()
	clockbox_margin:set_top(0)
	clockbox_margin:set_bottom(5)
	if textclock.format == '%H:%M' then
		clockbox_container:set_bg(beautiful.darkgreen)
	else
		clockbox_container:set_bg(beautiful.darkblue)
	end
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
	buttons = awful.button({}, 1, function()
		if textclock.format == '%H:%M' then
			textclock.format = '%a %b %d'
		else
			textclock.format = '%H:%M'
		end
	end),
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

