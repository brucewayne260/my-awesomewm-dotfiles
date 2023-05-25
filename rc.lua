-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
local lain = require("lain")
-- Notification library
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Bar widgets
require("bar.init")

-- Main modules
require("main.error-handling")
require("main.signals")
local screenshot = require("main.screenshot")

-- User Variables
local vars = require("main.user-variables")
local terminal = vars.terminal
local editor = vars.editor
local editor_cmd = vars.editor_cmd
local filemanager = vars.filemanager
local webbrowser = vars.webbrowser
local modkey = vars.modkey
local altkey = vars.altkey

-- {{{ Menu
-- Create a launcher widget and a main menu
mymainmenu = awful.menu({ items = { { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
	{ "manual", terminal .. " -e man awesome" },
	{ "edit config", editor_cmd .. " " .. awesome.conffile },
	{ "restart", awesome.restart },
	{ "quit", function() awesome.quit() end }, 
	{ "terminal", terminal }}})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar

-- Create a wibox for each screen and add it
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

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, false)
        -- gears.wallpaper.fit(nil, s, beautiful.bg_normal)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	-- Each screen has its own tag table.
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

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	
	-- Create a taglist widget
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
				widget = wibox.container.margin,
				bottom = 5,
			},
			widget = wibox.container.background,
			shape = gears.shape.rounded_rect,
			bg = beautiful.grey,
		}
	}

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist {
		screen  = s,
		filter  = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons
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
			spotifyiconbox,
			sep,
			spotifybox,
		},
		{
			layout = wibox.layout.fixed.horizontal,
			cpubox_container,
			sep,
			membox_container,
			sep,
			clockbox,
			sep,
			datebox,
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
			sep,
			s.mytaglist,
		},
		s.mypromptbox,
		{
			layout = wibox.layout.fixed.horizontal,
			keyboardlayoutbox_container,
			sep,
			systraybox_container,	
			sep,
			layoutbox_container,
			sep,
		},
	}
end)
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(

	-- Basic applications
	awful.key({altkey}, "w", function()
		awful.util.spawn(webbrowser)
	end),
	awful.key({altkey}, "f", function()
		awful.util.spawn(terminal .. " -e " .. filemanager)
	end),

	-- Playerctl Keys
   	awful.key({altkey, "Shift"}, ",", function()
     		awful.util.spawn("playerctl -p spotify previous", false)
	end),
   	awful.key({altkey, "Shift"}, "p", function()
     		awful.spawn("playerctl -p spotify play-pause", false)
		spotify_keyupdate()
	end),
   	awful.key({altkey, "Shift"}, ".", function()
     		awful.util.spawn("playerctl -p spotify next", false)
	end),

	-- brightness
--   	awful.key({altkey, "shift"}, "q", function()
--     		awful.util.spawn("xbacklight -dec 5", false) end),
--   	awful.key({altkey, "shift"}, "e", function()
--     		awful.util.spawn("xbacklight -inc 5", false) end),
--   	awful.key({altkey, "shift"}, "x", function()
--     		awful.util.spawn("xbacklight -set 0", false) end),
--   	awful.key({altkey, "Shift"}, "w", function()
--     		awful.util.spawn("xbacklight -set 100", false) end),

	-- Configure the hotkeys.
		awful.key({ }, "Print", scrot_full,
		  {description = "Take a screenshot of entire screen", group = "screenshot"}),
		awful.key({ modkey, }, "Print", scrot_selection,
		  {description = "Take a screenshot of selection", group = "screenshot"}),
		awful.key({ "Shift" }, "Print", scrot_window,
		  {description = "Take a screenshot of focused window", group = "screenshot"}),
		awful.key({ "Ctrl" }, "Print", scrot_delay,
		  {description = "Take a screenshot of delay", group = "screenshot"}),	
	-- Hide wibox
	awful.key({ modkey }, "b", function ()
		myscreen = awful.screen.focused()
		myscreen.mywibox_border.visible = not myscreen.mywibox_border.visible
		myscreen.mytopwibox_border.visible = not myscreen.mytopwibox_border.visible
		myscreen.mywibox.visible = not myscreen.mywibox.visible
		myscreen.mytopwibox.visible = not myscreen.mytopwibox.visible end),

	-- Volume control
	awful.key({altkey, "Shift"}, "a", function() 
		awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%", false)
		volume.update() end),
	awful.key({altkey, "Shift"}, "d", function() 
		awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%", false)
		volume.update() end),
	awful.key({altkey, "Shift"}, "m", function() 
		awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle", false)
		volume.update() end),

    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey, "Shift" },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Rofi
    awful.key({ modkey }, "p", function() awful.spawn(string.format("%s/.local/bin/rofi_launcher", os.getenv("HOME"))) end,
              {description = "show the menubar", group = "launcher"}),

    awful.key({ modkey, "Shift" }, "p", function() awful.spawn(string.format("%s/.local/bin/rofi_powermenu", os.getenv("HOME"))) end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(

	-- working toggle titlebar
	awful.key({ modkey, "Control" }, "t", function (c)
		awful.titlebar.toggle(c) end),

    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen+awful.placement.centered
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
     { rule = { class = "firefox" },
       properties = { screen = s, tag = "2" } },
     { rule = { class = "discord" },
       properties = { screen = s, tag = "4" } },
     { rule = { class = "Spotify" },
       properties = { screen = s, tag = "3" } },
     { rule = { class = "mpv" },
       properties = { screen = s, tag = "5" } },
}
-- }}}

-- Run garbage collector regularly to prevent memory leaks
gears.timer {
       timeout = 30,
       autostart = true,
       callback = function() collectgarbage() end
}
