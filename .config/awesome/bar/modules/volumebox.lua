local lain = require("lain")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")
local vars = require("main.user-variables")

local volumeicon = wibox.widget.imagebox() 
local volumebox = wibox.container.background()
local volumebox_margin = wibox.container.margin()
volumebox_container = wibox.container.background()

local pressed = function()
	volumebox_margin:set_bottom(0)
	volumebox_margin:set_top(5)
	volumebox_container:set_bg(beautiful.transparent)
end

local released = function()
	volumebox_margin:set_bottom(5)
	volumebox_margin:set_top(0)
end

vol_keybind_update = function()
	if ismute then
		volumebox:set_bg(beautiful.blue)
		volumebox_container:set_bg(beautiful.darkblue)
	elseif not ismute then
		volumebox:set_bg(beautiful.red)
		volumebox_container:set_bg(beautiful.darkred)
	end
end

local volumebox_update = function()
	if ismute then
		volumebox:set_bg(beautiful.red)
		volumebox_container:set_bg(beautiful.darkred)
	elseif not ismute then
		volumebox:set_bg(beautiful.blue)
		volumebox_container:set_bg(beautiful.darkblue)
	end
end

local first_time = true

volume = lain.widget.pulse {
	cmd = "(pactl get-sink-volume @DEFAULT_SINK@ | sed 's/Volume/volume/' && pactl get-sink-mute @DEFAULT_SINK@ | sed 's/Mute/muted/') | sed '/balance/d'",
	settings = function()
		local level = tonumber(volume_now.left)
		if volume_now.muted == "yes" then
			volumeicon:set_image(beautiful.muteicon)
			ismute = true
			if first_time then
				volumebox_update()
				first_time = false
			end
		elseif volume_now.muted == "no" then
			ismute = false
			if first_time then
				volumebox_update()
				first_time = false
			end
			if level >= 80 then
				volumeicon:set_image(beautiful.volumeicon)
			elseif level >= 30 then
				volumeicon:set_image(beautiful.volume_mediumicon)
			else
				volumeicon:set_image(beautiful.volume_lowicon)
			end
		end
		widget:set_markup(level .. "%")
	end
}

volumebox = wibox.container {
	{
		layout = wibox.layout.fixed.horizontal,
		{
			layout = wibox.container.margin,
			left = 10,
			top = 8,
			bottom = 8,
			volumeicon,
		},
		{
			layout = wibox.container.margin,
			left = 5,
			right = 10,
			volume,
		},
	},
	layout = wibox.container.background,
	shape = gears.shape.rounded_rect,
	fg = beautiful.fg_normal,
}

volumebox_margin = wibox.container {
	layout = wibox.container.margin,
	volumebox,
}

volumebox_container = wibox.container {
	volumebox_margin,
	layout = wibox.container.background,
	shape = gears.shape.rounded_rect,
	buttons = awful.util.table.join(
		awful.button({}, 1, function() -- left click
			awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle", false)
			volume.update()
		end),
		awful.button({}, 3, function() -- right click
			awful.spawn(vars.terminal .. " -e alsamixer")
			volume.update()
		end),
		awful.button({}, 4, function() -- scroll up
			awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%", false)
			volume.update()
		end),
		awful.button({}, 5, function() -- scroll down
			awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%", false)
			volume.update()
		end)),
}

volumebox_container:connect_signal("button::press", function()
	pressed()
end)
volumebox_container:connect_signal("mouse::leave", function()
	released()
	volumebox_update()
end)
volumebox_container:connect_signal("button::release", function()
	released()
	volumebox_update()
end)

released()
volume.update()
