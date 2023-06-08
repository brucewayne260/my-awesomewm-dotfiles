local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local launcher = wibox.container {
	{
		{
			widget = wibox.widget.imagebox,
			image = beautiful.awesome_icon,
		},
		widget = wibox.container.margin,
		top = 8,
		bottom = 8,
		left = 10,
		right = 10,
	},
	widget = wibox.container.background,
	shape = gears.shape.rounded_rect,
	bg = beautiful.cyan,
}

local launcher_margin = wibox.container {
	launcher,	
	widget = wibox.container.margin,
}

launcher_container = wibox.container {
	launcher_margin,
	widget = wibox.container.background,
	shape = gears.shape.rounded_rect,
	buttons = awful.button({}, 1, function()
		awful.spawn(string.format("%s/.local/bin/rofi_launcher", os.getenv("HOME")), false)
	end)
}

local pressed = function()
	launcher_margin:set_top(5)
	launcher_margin:set_bottom(0)
	launcher_container:set_bg(beautiful.transparent)
end

local released = function()
	launcher_margin:set_top(0)
	launcher_margin:set_bottom(5)
	launcher_container:set_bg(beautiful.darkcyan)
end

launcher_container:connect_signal("button::press", function() pressed() end)
launcher_container:connect_signal("mouse::leave", function() released() end)
launcher_container:connect_signal("button::release", function() released() end)

released()

