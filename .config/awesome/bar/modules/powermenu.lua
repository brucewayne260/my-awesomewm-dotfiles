local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local powerlauncher = wibox.container {
	{
		{
			widget = wibox.widget.imagebox,
			image = beautiful.powericon,
		},
		widget = wibox.container.margin,
		top = 9,
		bottom = 7,
		left = 12,
		right = 12,
	},
	widget = wibox.container.background,
	shape = gears.shape.rounded_rect,
	bg = beautiful.red,
}

local powerlauncher_margin = wibox.container {
	powerlauncher,	
	widget = wibox.container.margin,
}

powerlauncher_container = wibox.container {
	powerlauncher_margin,
	widget = wibox.container.background,
	shape = gears.shape.rounded_rect,
	buttons = awful.button({}, 1, function()
		awful.spawn(string.format("%s/.local/bin/rofi_powermenu", os.getenv("HOME")), false)
--		awful.spawn(string.format("mpv %s/sounds/sound.mp3", os.getenv("HOME")), false)
	end)
}

local pressed = function()
	powerlauncher_margin:set_top(5)
	powerlauncher_margin:set_bottom(0)
	powerlauncher_container:set_bg(beautiful.transparent)
end

local released = function()
	powerlauncher_margin:set_top(0)
	powerlauncher_margin:set_bottom(5)
	powerlauncher_container:set_bg(beautiful.darkred)
end

local ispress = false
powerlauncher_container:connect_signal("button::press", function()
	pressed()
	-- awful.spawn(string.format("ffmpeg -i %s/sounds/press.mp3 -f alsa default", os.getenv("HOME")), false)
	ispress = true
end)
powerlauncher_container:connect_signal("mouse::leave", function()
	released()
	if ispress then
		-- awful.spawn(string.format("ffmpeg -i %s/sounds/release.mp3 -f alsa default", os.getenv("HOME")), false)
		ispress = false
	end
end)
powerlauncher_container:connect_signal("button::release", function()
	released()
	-- awful.spawn(string.format("ffmpeg -i %s/sounds/release.mp3 -f alsa default", os.getenv("HOME")), false)
	ispress = false
end)

released()

