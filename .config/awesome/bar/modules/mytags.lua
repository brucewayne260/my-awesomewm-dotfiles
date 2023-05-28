local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

awful.screen.connect_for_each_screen(function(s)

	local tag1 = awful.tag.add("1", {
		selected = true,
    		gap = beautiful.useless_gap * 3,
		layout = awful.layout.suit.tile,
		screen = s,
	})

	local tag2 = awful.tag.add("2", {
    		gap = beautiful.useless_gap * 3,
		layout = awful.layout.suit.tile,
		screen = s,
	})
	
	local tag3 = awful.tag.add("3", {
    		gap = beautiful.useless_gap * 3,
		layout = awful.layout.suit.tile,
		screen = s,
	})
	
	local tag4 = awful.tag.add("4", {
    		gap = beautiful.useless_gap * 3,
		layout = awful.layout.suit.tile,
		screen = s,
	})

	local tag5 = awful.tag.add("5", {
    		gap = beautiful.useless_gap * 3,
		layout = awful.layout.suit.tile,
		screen = s,
	})

	s.mytaglist = awful.widget.taglist {
		screen  = s,
		filter  = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
		widget_template = {
			{
				{
					{
						{
							id     = 'text_role',
							widget = wibox.widget.textbox,
						},
						left = 12,
						right = 12,
						widget = wibox.container.margin
					},
					id     = 'background_role',
					widget = wibox.container.background,
				},
				id = 'role_margin',
				widget = wibox.container.margin,
			},
			id = 'role_container',
			widget = wibox.container.background,
			shape = gears.shape.rounded_rect,
			create_callback = function(self, t, index, tags)
				local pressed = function()
					self:get_children_by_id('role_container')[1].bg = beautiful.transparent
					self:get_children_by_id('role_margin')[1].top = 5
					self:get_children_by_id('role_margin')[1].bottom = 0
				end
				local released = function()
					self:get_children_by_id('role_margin')[1].top = 0
					self:get_children_by_id('role_margin')[1].bottom = 5
					self:get_children_by_id('role_container')[1].bg = beautiful.darkgrey
				end
				self:connect_signal("button::press", function() pressed() end)
				self:connect_signal("button::release", function() released() end)
				self:connect_signal("mouse::leave", function() released() end)
				released()
			end,
			update_callback = function(self, t, index, tags)
				local pressed = function()
					self:get_children_by_id('role_container')[1].bg = beautiful.transparent
					self:get_children_by_id('role_margin')[1].top = 5
					self:get_children_by_id('role_margin')[1].bottom = 0
				end
				local released = function()
					self:get_children_by_id('role_margin')[1].top = 0
					self:get_children_by_id('role_margin')[1].bottom = 5
					self:get_children_by_id('role_container')[1].bg = beautiful.darkgrey
				end
				self:connect_signal("button::press", function() pressed() end)
				self:connect_signal("button::release", function() released() end)
				self:connect_signal("mouse::leave", function() released() end)
			end,
		}
	}
end)

