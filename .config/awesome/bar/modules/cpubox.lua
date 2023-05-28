local awful = require("awful")
local lain = require("lain")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local cpuicon = wibox.widget.imagebox(beautiful.cpuicon)
local cpubox_margin = wibox.container.margin()
cpubox_container = wibox.container.background()

local cpu = lain.widget.cpu {
	settings = function()
		local level = cpu_now.usage .. "%"
		widget:set_markup(level)
	end
}

local pressed = function()
	cpubox_container:set_bg(beautiful.transparent)
	cpubox_margin:set_top(5)
	cpubox_margin:set_bottom(0)
end

local released = function()
	cpubox_container:set_bg(beautiful.darkred)
	cpubox_margin:set_top(0)
	cpubox_margin:set_bottom(5)
end

local cpubox = wibox.container {
	{
		layout = wibox.layout.fixed.horizontal,
		{
			layout = wibox.container.margin,
			left = 10,
			top = 7,
			bottom = 7,
			cpuicon,
		},			
		{
			layout = wibox.container.margin,
			left = 8,
			right = 10,
			cpu,
		},
	},
	layout = wibox.container.background,
	shape = gears.shape.rounded_rect,
	bg = beautiful.red,
}

cpubox_margin = wibox.container {
	layout = wibox.container.margin,
	cpubox,
}

cpubox_container = wibox.container {
	cpubox_margin,	
	layout = wibox.container.background,
	shape = gears.shape.rounded_rect,
	buttons = awful.button({}, 1, function() awful.spawn("st -e htop")
	end)
}

cpubox_container:connect_signal("button::press", function() pressed() end)
cpubox_container:connect_signal("mouse::leave", function() released() end)
cpubox_container:connect_signal("button::release", function() released() end)

released()
