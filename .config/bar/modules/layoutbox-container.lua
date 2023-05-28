local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Create an imagebox widget which will contain an icon indicating which layout we're using.
-- We need one layoutbox per screen.
local layoutbox = awful.widget.layoutbox(s)
layoutbox:buttons(gears.table.join(
	awful.button({ }, 1, function () awful.layout.inc( 1) end),
	awful.button({ }, 3, function () awful.layout.inc(-1) end),
	awful.button({ }, 4, function () awful.layout.inc( 1) end),
	awful.button({ }, 5, function () awful.layout.inc(-1) end)))

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.floating,
	-- awful.layout.suit.tile.left,
	-- awful.layout.suit.tile.bottom,
	-- awful.layout.suit.tile.top,
	-- awful.layout.suit.fair,
	-- awful.layout.suit.fair.horizontal,
	awful.layout.suit.spiral,
	-- awful.layout.suit.spiral.dwindle,
	-- awful.layout.suit.max,
	-- awful.layout.suit.max.fullscreen,
	-- awful.layout.suit.magnifier,
	-- awful.layout.suit.corner.nw,
	-- awful.layout.suit.corner.ne,
	-- awful.layout.suit.corner.sw,
	-- awful.layout.suit.corner.se,
}
-- }}}

local box = wibox.container.background()
local layoutbox_margin = wibox.container.margin()
layoutbox_container = wibox.container.background()

local pressed = function()
	layoutbox_container:set_bg(beautiful.transparent)
	layoutbox_margin:set_top(5)
	layoutbox_margin:set_bottom(0)
end

local released = function()
	layoutbox_container:set_bg(beautiful.darkgrey)
	layoutbox_margin:set_top(0)
	layoutbox_margin:set_bottom(5)
end

box = wibox.container {
	{
		layout = wibox.container.margin,
		top = 7,
		bottom = 7,
		left = 10,
		right = 10,
		layoutbox,
	},
	layout = wibox.container.background,
	-- shape_border_width = beautiful.border_width,
	-- shape_border_color = beautiful.grey,
	shape = gears.shape.rounded_rect,
	bg = beautiful.grey,
}

layoutbox_margin = wibox.container {
	box,
	layout = wibox.container.margin,
}

layoutbox_container = wibox.container {
	layoutbox_margin,
	layout = wibox.container.background,
	shape = gears.shape.rounded_rect,
}

layoutbox_container:connect_signal("button::press", function()
	pressed()
end)
layoutbox_container:connect_signal("mouse::leave", function()
	released()
end)
layoutbox_container:connect_signal("button::release", function()
	released()
end)

released()