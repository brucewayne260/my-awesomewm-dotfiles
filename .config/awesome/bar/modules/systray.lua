local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")

beautiful.bg_systray = beautiful.grey
local systraybox_margin = wibox.container.margin()
systraybox_container = wibox.container.background()

local pressed = function()
	systraybox_container:set_bg(beautiful.transparent)
	systraybox_margin:set_top(5)
	systraybox_margin:set_bottom(0)
end

local released = function()
	systraybox_container:set_bg(beautiful.darkgrey)
	systraybox_margin:set_top(0)
	systraybox_margin:set_bottom(5)
end

local systraybox = wibox.container {
	{
		layout = wibox.container.margin,
		top = 6,
		bottom = 4,
		left = 8,
		right = 8,
		wibox.widget.systray(),				
	},
	layout = wibox.container.background,
	shape = gears.shape.rounded_rect, 
	bg = beautiful.bg_systray,
}

systraybox_margin = wibox.container {
	layout = wibox.container.margin,
	systraybox,
}

systraybox_container = wibox.container {
	systraybox_margin,
	layout = wibox.container.background,
	shape = gears.shape.rounded_rect,
}

systraybox_container:connect_signal("button::press", function() pressed() end)
systraybox_container:connect_signal("mouse::leave", function() released() end)
systraybox_container:connect_signal("button::release", function() released() end)

released()

