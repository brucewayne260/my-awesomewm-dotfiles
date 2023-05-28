local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")

local keymap = awful.widget.keyboardlayout()
local keymapicon = wibox.widget.imagebox(beautiful.keymapicon)
local keymapbox = wibox.container.background()
local keymapbox_margin = wibox.container.margin()
keymapbox_container = wibox.container.background()

local pressed = function()
	keymapbox_container:set_bg(beautiful.transparent)
	keymapbox_margin:set_top(5)
	keymapbox_margin:set_bottom(0)
end

local released = function()
	keymapbox_container:set_bg(beautiful.darkgrey)
	keymapbox_margin:set_top(0)
	keymapbox_margin:set_bottom(5)
end

keymapbox = wibox.container {
	{
		layout = wibox.layout.fixed.horizontal,
		{
			layout = wibox.container.margin,
			left = 10,
			top = 9,
			bottom = 7,
			keymapicon
		},			
		{
			layout = wibox.container.margin,
			right = 3,
			keymap,
		},
	},
	layout = wibox.container.background,
	shape = gears.shape.rounded_rect,
	fg = beautiful.fg_normal,
	bg = beautiful.grey,
}

keymapbox_margin = wibox.container {
	layout = wibox.container.margin,
	keymapbox,
}

keymapbox_container = wibox.container {
	keymapbox_margin,
	layout = wibox.container.background,
	shape = gears.shape.rounded_rect,
}

keymapbox_container:connect_signal("button::press", function()
	pressed()
end)
keymapbox_container:connect_signal("mouse::leave", function()
	released()
end)
keymapbox_container:connect_signal("button::release", function()
	released()
end)

released()

