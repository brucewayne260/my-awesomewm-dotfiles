local beautiful = require("beautiful")
local vars = require("main.user-variables")
local awful = require("awful")
local wibox = require("wibox")
local theme_path = vars.theme_path
beautiful.init(theme_path)

require("bar.modules.spotifybox")
require("bar.modules.volumebox")
require("bar.modules.cpubox")
require("bar.modules.keymapbox")
require("bar.modules.membox")
require("bar.modules.layoutbox-container")
require("bar.modules.systray")
require("bar.modules.clockbox")
require("bar.modules.net")
require("bar.modules.playerctl")
require("bar.modules.launcherbox")
require("bar.modules.powermenu")
require("bar.modules.mytags")

awful.screen.connect_for_each_screen(function(s)

	s.mypromptbox = awful.widget.prompt {
		prompt = ' Execute: '
	}

	-- Create a separator
	sep = wibox.widget.separator {
		opacity = 0,
		forced_width = beautiful.useless_gap,
	}

	-- Create the topwibox and border
	s.mytopwibox_border = awful.wibar({position = "top", height = beautiful.wibox_height + beautiful.useless_gap * 2, opacity = 0})
	s.mytopwibox = wibox({
		visible = true,
		bg = beautiful.transparent,
		width = s.geometry.width - 4 * beautiful.useless_gap,
		height = beautiful.wibox_height,
		x = 2 * beautiful.useless_gap,
		y = 2 * beautiful.useless_gap,
	})

	s.mytopwibox:setup {
		layout = wibox.layout.align.horizontal,
		expand = "none",
		{
			layout = wibox.layout.fixed.horizontal,
			launcher_container,
			sep,
			volumebox_container,
			sep,
			netbox_container,
			sep,
			playerctl_container,
		},
		{
			layout = wibox.layout.fixed.horizontal,
			spotifyicon_container,
			sep,
			spotifybox_container,
		},
		{
			layout = wibox.layout.fixed.horizontal,
			cpubox_container,
			sep,
			membox_container,
			sep,
			clockbox_container,
		},
	}

	-- Create the wibox and border
	s.mywibox_border = awful.wibar({position = "bottom", height = beautiful.wibox_height + beautiful.useless_gap * 2, opacity = 0})
	s.mywibox = wibox({
		visible = true,
		bg = beautiful.transparent,
		width = s.geometry.width - 4 * beautiful.useless_gap,
		height = beautiful.wibox_height,
		x = 2 * beautiful.useless_gap,
		y = s.geometry.height - beautiful.wibox_height - 2 * beautiful.useless_gap,
	})

	-- Add widget to wibox
	s.mywibox:setup {
		layout = wibox.layout.align.horizontal,
		expand = "none",
		{
			layout = wibox.layout.fixed.horizontal,
			s.mytaglist,
		},
		s.mypromptbox,
		{
			layout = wibox.layout.fixed.horizontal,
			keymapbox_container,
			sep,
			systraybox_container,	
			sep,
			layoutbox_container,
			sep,
			powerlauncher_container,
		},
	}
end)
