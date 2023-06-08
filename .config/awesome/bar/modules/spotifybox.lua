local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")

local spotify = awful.widget.watch("playerctl -p spotify metadata --format '{{ title }} - {{ artist }} - {{ album }}'", 2,
function(widget, stdout, stderr, exitreason, exitcode)
	local text = " " .. stdout
	if stdout == "" then
		widget:set_text("")
	else
		widget:set_text(text)
	end
end)
local spotifybox = wibox.container.background()
local spotifybox_margin = wibox.container.margin()
spotifybox_container = wibox.container.background()

local spot_pressed = function()
	spotifybox_container:set_bg(beautiful.transparent)
	spotifybox_margin:set_top(5)
	spotifybox_margin:set_bottom(0)
end

local spot_released = function()
	spotifybox_container:set_bg(beautiful.darkgreen)
	spotifybox_margin:set_top(0)
	spotifybox_margin:set_bottom(5)
end

spotifybox = wibox.container {
	{
		layout = wibox.layout.fixed.horizontal,
		{
			layout = wibox.container.margin,
			top = 5,
			bottom = 5,
			left = 10,
			{
				widget = wibox.widget.imagebox,
				image = beautiful.spotifyicon,
			},
		},
		{
			layout = wibox.container.constraint,
			width = awful.screen.focused().workarea.width / 5,
			{
				layout = wibox.container.margin,
				right = 10,
				spotify,
			}
		},
	},
	layout = wibox.container.background,
	shape = gears.shape.rounded_rect,
	fg = beautiful.fg_normal,
	bg = beautiful.green,
}

spotifybox_margin = wibox.container {
	spotifybox,	
	layout = wibox.container.margin,
}

spotifybox_container = wibox.container {
	spotifybox_margin,
	layout = wibox.container.background,
	shape = gears.shape.rounded_rect,
}

spotifybox_container:connect_signal("button::press", function() spot_pressed() end)
spotifybox_container:connect_signal("mouse::leave", function() spot_released() end)
spotifybox_container:connect_signal("button::release", function() spot_released() end)

spot_released()

-- Play-pause button ------------------------------

local spotifyicon = wibox.widget.imagebox() 
local spotifyicon_margin = wibox.container.margin()
spotifyicon_container = wibox.container.background()

local pressed = function()
	spotifyicon_container:set_bg(beautiful.transparent)
	spotifyicon_margin:set_top(5)
	spotifyicon_margin:set_bottom(0)
end

local released = function()
	spotifyicon_container:set_bg(beautiful.darkgreen)
	spotifyicon_margin:set_top(0)
	spotifyicon_margin:set_bottom(5)
end

-- Update on key binding
spotify_keyupdate = function()
	awful.spawn.easy_async("playerctl -p spotify status",
	function(stdout)
		if string.match(stdout, "%S+") == "Paused" then
			spotifyicon:set_image(beautiful.playicon)
			released()
			return
		elseif string.match(stdout, "%S+") == "Playing" then
			spotifyicon:set_image(beautiful.pauseicon)
			released()
			return
		else
			spotifyicon:set_image(beautiful.stopicon)
			released()
			return
		end
	end)
end

-- Update on click
spotify_update = function()
	awful.spawn.easy_async("playerctl -p spotify status",
	function(stdout)
		if string.match(stdout, "%S+") == "Playing" then
			spotifyicon:set_image(beautiful.playicon)
			released()
			return
		elseif string.match(stdout, "%S+") == "Paused" then
			spotifyicon:set_image(beautiful.pauseicon)
			released()
			return
		else
			spotifyicon:set_image(beautiful.stopicon)
			released()
			return
		end
	end)
end

spotifyicon_margin = wibox.container {
	{
		{
			layout = wibox.container.margin,
			right = 15,
			top = 8,
			bottom = 8,
			left = 15,
			spotifyicon,
		},
		layout = wibox.container.background,
		shape = gears.shape.rounded_rect,
		fg = beautiful.fg_normal,
		bg = beautiful.green,
	},
	layout = wibox.container.margin,
}

spotifyicon_container = wibox.container {
	spotifyicon_margin,
	shape = gears.shape.rounded_rect,
	layout = wibox.container.background,
	buttons = awful.button({}, 1, function()
		awful.spawn("playerctl -p spotify play-pause", false)
	end)
}

spotifyicon_container:connect_signal("button::press", function()
	pressed()
end)
spotifyicon_container:connect_signal("mouse::leave", function()
	released()
	spotify_update()
end)
spotifyicon_container:connect_signal("button::release", function()
	released()
	spotify_update()
end)

spotify_update()

