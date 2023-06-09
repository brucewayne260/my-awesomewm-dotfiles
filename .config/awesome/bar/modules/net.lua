local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")
local vars = require("main.user-variables")

local wifi_icon = wibox.widget.imagebox()
local net = wibox.widget.textbox()
local netbox = wibox.container.background()
local netbox_margin = wibox.container.margin()
netbox_container = wibox.container.background()

local update_net_widget = function(wifi_name)
	if wifi_name == "" then
		net.text = ""
	else
		net.text = string.format(" %s", wifi_name)
	end
end

local pressed = function()
	netbox_container:set_bg(beautiful.transparent)
	netbox_margin:set_bottom(0)
	netbox_margin:set_top(5)
end

local released = function()
	netbox_margin:set_bottom(5)
	netbox_margin:set_top(0)
end

local net_status, net_timer = awful.widget.watch(
	"iwgetid -r",
	5,
	function(self, stdout)
		local wifi_name = stdout
		if wifi_name == "" then
			awful.spawn.easy_async_with_shell("nmcli device status | grep -i ethernet | awk '{print$3}'",
			function(stdout)
				local eth_name = stdout
				if string.match(stdout, "%S+") == "connected" then
					update_net_widget("Connected")
					wifi_icon:set_image(beautiful.ethicon)
					netbox:set_bg(beautiful.green)
					netbox_container:set_bg(beautiful.darkgreen)
				else
					update_net_widget("")
					wifi_icon:set_image(beautiful.nowifi)
					netbox:set_bg(beautiful.red)
					netbox_container:set_bg(beautiful.darkred)
				end
				netbox_margin:set_bottom(5)
				netbox_margin:set_top(0)
			end)
		else
			update_net_widget(wifi_name)
			wifi_icon:set_image(beautiful.wifi_goodicon)
			netbox:set_bg(beautiful.green)
			netbox_container:set_bg(beautiful.darkgreen)
			netbox_margin:set_bottom(5)
			netbox_margin:set_top(0)
		end
	end
)

netbox = wibox.container {
	{
		layout = wibox.layout.fixed.horizontal,
		{
			layout = wibox.container.margin,
			left = 10,
			top = 8,
			bottom = 8,
			wifi_icon,
		},
		{
			{
				layout = wibox.container.margin,
				right = 10,
				net,
			},
			layout = wibox.layout.constraint,
			width = 150,
		},
	},
	layout = wibox.container.background,
	shape = gears.shape.rounded_rect,
	fg = beautiful.black,
}

netbox_margin = wibox.container {
	layout = wibox.container.margin,
	netbox,
}

netbox_container = wibox.container {
	netbox_margin,
	layout = wibox.container.background,
	shape = gears.shape.rounded_rect,
	buttons = awful.button({}, 1,
		function()
			awful.spawn(vars.terminal .. " -e nmtui")
		end)
}

netbox_container:connect_signal("button::press", function() pressed() end)
netbox_container:connect_signal("mouse::leave", function()
	released()
	net_timer:emit_signal("timeout")
end)
netbox_container:connect_signal("button::release", function()
	released()
	net_timer:emit_signal("timeout")
end)

