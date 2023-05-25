local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")

local player = "firefox"
local playerctlicon = wibox.widget.imagebox()
playerctl_container = wibox.container.background()

local myplayer = wibox.widget {
	widget = wibox.widget.textbox,
}

local playerctlbox = wibox.container {
	layout = wibox.container.background(),
	shape = gears.shape.rounded_rect,
	{
		{
			playerctlicon,
			layout = wibox.container.margin,
			left = 12,
			right = 10,
			top = 8,
			bottom = 8,
		},
		myplayer,
		layout = wibox.layout.fixed.horizontal,
	}
}

local playerctl_margin = wibox.container {
	widget = wibox.container.margin,
	playerctlbox,
}

local pressed = function()
	playerctl_margin:set_bottom(0)
	playerctl_margin:set_top(5)
	playerctl_container:set_bg(beautiful.transparent)
end

local released = function()
	playerctl_margin:set_bottom(5)
	playerctl_margin:set_top(0)
end

local playerctl_update = function()
	awful.spawn.easy_async("playerctl -p " .. player .. " status",
	function(stdout)
		if string.match(stdout, "%S+") == "Playing" then
			myplayer:set_text(player .. " ")
			playerctlicon:set_image(beautiful.playicon)
			released()
			playerctlbox:set_bg(beautiful.blue)
			playerctl_container:set_bg(beautiful.darkblue)
			return
		elseif string.match(stdout, "%S+") == "Paused" then
			myplayer:set_text(player .. " ")
			playerctlicon:set_image(beautiful.pauseicon)
			released()
			playerctlbox:set_bg(beautiful.red)
			playerctl_container:set_bg(beautiful.darkred)
			return
		else
			myplayer:set_text(player .. " ")
			playerctlicon:set_image(beautiful.stopicon)
			released()
			playerctlbox:set_bg(beautiful.red)
			playerctl_container:set_bg(beautiful.darkred)
			return
		end
	end)
end

playerctl_container = wibox.container {
	playerctl_margin,
	widget = wibox.container.background,
	shape = gears.shape.rounded_rect,
	buttons = awful.button({}, 1, function()
		awful.spawn("playerctl -p " .. player .. " play-pause", false)
		awful.spawn(string.format("mpv --no-video %s/sounds/sound.mp3", os.getenv("HOME")), false)
	end)
}

playerctl_container:connect_signal("button::press", function()
	pressed()
end)
playerctl_container:connect_signal("button::release", function()
	released()
	playerctl_update()
end)

playerctl_update()
