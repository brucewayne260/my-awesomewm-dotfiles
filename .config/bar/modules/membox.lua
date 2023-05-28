local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")
local lain = require("lain")

local memicon = wibox.widget.imagebox(beautiful.memicon)
local membox = wibox.container.background()
local membox_margin = wibox.container.margin()
membox_container = wibox.container.background()

local mem = lain.widget.mem {
	timeout = 3,
	settings = function()
		local level = mem_now.used .. "mb"
		widget:set_markup(level)
	end
}

local pressed = function()
	membox_container:set_bg(beautiful.transparent)
	membox_margin:set_top(5)
	membox_margin:set_bottom(0)
end

local released = function()
	membox_container:set_bg(beautiful.darkyellow)
	membox_margin:set_top(0)
	membox_margin:set_bottom(5)
end

membox = wibox.container {
	{
		layout = wibox.layout.fixed.horizontal,
		{
			layout = wibox.container.margin,
			left = 10,
			top = 8,
			bottom = 7,
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
	bg = beautiful.yellow,
}

membox_margin = wibox.container {
	layout = wibox.container.margin,
	membox,
}

membox_container = wibox.container {
	membox_margin,
	layout = wibox.container.background,
	shape = gears.shape.rounded_rect,
}

membox_container:connect_signal("button::press", function()
	pressed()
end)
membox_container:connect_signal("mouse::leave", function() 
	released()
end)
membox_container:connect_signal("button::release", function() 
	released()
end)

released()
