local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")
local vars = require("main.user-variables")
local theme_path = vars.theme_path
beautiful.init(theme_path)

local spotify = awful.widget.watch("playerctl -p spotify metadata --format '{{ title }} - {{ artist }} - {{ album }}'", 2)

spotifybox = wibox.container {
	{
		{
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
					width = 500,
					{
						layout = wibox.container.margin,
						left = 10,
						right = 15,
						spotify,
					}
				},
			},
			layout = wibox.container.background,
			shape = gears.shape.rounded_rect,
			-- shape_border_width = beautiful.border_width,
			-- shape_border_color = beautiful.bg_normal,
			fg = beautiful.fg_normal,
			bg = beautiful.green,
		},
		layout = wibox.container.margin,
		bottom = 5,
	},
	layout = wibox.container.background,
	shape = gears.shape.rounded_rect,
	bg = beautiful.darkgreen,
}

local spotifyicon = wibox.widget.imagebox() 
local spotify_margin = wibox.container.margin()
spotifyiconbox = wibox.container.background()

local pressed = function()
	spotifyiconbox:set_bg(beautiful.transparent)
	spotify_margin:set_top(5)
	spotify_margin:set_bottom(0)
end

local released = function()
	spotifyiconbox:set_bg(beautiful.darkgreen)
	spotify_margin:set_top(0)
	spotify_margin:set_bottom(5)
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

spotify_margin = wibox.container {
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
		-- shape_border_width = beautiful.border_width,
		-- shape_border_color = beautiful.bg_normal,
		fg = beautiful.fg_normal,
		bg = beautiful.green,
	},
	layout = wibox.container.margin,
}

spotifyiconbox = wibox.container {
	spotify_margin,
	shape = gears.shape.rounded_rect,
	layout = wibox.container.background,
	buttons = awful.button({}, 1, function()
		awful.spawn("playerctl -p spotify play-pause", false)
	end)
}

spotifyiconbox:connect_signal("button::press", function() pressed() end)
spotifyiconbox:connect_signal("button::release", function()
	released()
	spotify_update()
end)

spotify_update()

