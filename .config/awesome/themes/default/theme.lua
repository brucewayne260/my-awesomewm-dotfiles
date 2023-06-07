---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local xrdb = xresources.get_current_theme()
local gears = require("gears")
local naughty = require("naughty")
local wibox = require("wibox")
local awful = require("awful")
local menubar = require("menubar")

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local icons_path = os.getenv("HOME") .. "/.config/awesome/themes/default/icons/everforest/"

local theme = {}

theme.font          = "SauceCodePro Nerd Font Bold 12"

theme.white = xrdb.color15
theme.black = xrdb.color0
theme.transparent   = "#00000000"
theme.background = xrdb.background
theme.foreground = xrdb.foreground

theme.green = xrdb.color10
theme.red = xrdb.color9
theme.yellow = xrdb.color11
theme.blue = xrdb.color12
theme.magenta = xrdb.color13
theme.cyan = xrdb.color14
theme.grey = xrdb.color8

theme.darkgreen = xrdb.color2
theme.darkred = xrdb.color1
theme.darkyellow = xrdb.color3
theme.darkblue = xrdb.color4
theme.darkmagenta = xrdb.color5
theme.darkcyan = xrdb.color6
theme.darkgrey = xrdb.color7

theme.bg_normal     = theme.background
theme.bg_focus      = theme.black
theme.bg_urgent     = theme.red
theme.bg_minimize   = theme.blue

theme.fg_normal     = theme.black
theme.fg_focus      = theme.foreground 
theme.fg_urgent     = theme.black
theme.fg_minimize   = theme.black

theme.useless_gap   = dpi(5)
theme.border_width  = dpi(2)
theme.border_normal = theme.black
theme.border_focus  = theme.blue
theme.border_marked = theme.red

-- Taglist
local tag_shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 10)
end
theme.taglist_shape = tag_shape
theme.taglist_spacing = 5
theme.taglist_shape_border_width = theme.border_width
theme.taglist_shape_border_color_empty = theme.grey
theme.taglist_shape_border_color_focus = theme.yellow
theme.taglist_shape_border_color = theme.blue
theme.taglist_shape_border_color_urgent = theme.red
theme.taglist_bg_empty = theme.grey
theme.taglist_bg_focus = theme.yellow
theme.taglist_bg_occupied = theme.blue
theme.taglist_bg_urgent = theme.red
theme.taglist_fg_empty = theme.black
theme.taglist_fg_focus = theme.black
theme.taglist_fg_occupied = theme.black
theme.taglist_fg_urgent = theme.black

-- Notification
naughty.config.padding = theme.useless_gap * 3
naughty.config.defaults.border_width = theme.border_width
naughty.config.defaults.border_color = theme.blue
theme.notification_bg = theme.black
theme.notification_fg = theme.white
theme.notification_icon_size = 200
theme.notification_shape = gears.shape.rounded_rect
theme.notification_max_width = 500

-- Systray
theme.systray_icon_spacing = 5

-- Wibox
theme.wibox_height = 35

-- Promptbox and shortkeys
theme.prompt_fg = theme.white
theme.prompt_bg = theme.black
theme.hotkeys_fg = theme.white
theme.hotkeys_border_color = theme.blue
theme.hotkeys_shape = gears.shape.rounded_rect

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(25)
theme.menu_width  = dpi(160)
theme.menu_border_color = theme.blue
theme.menu_fg_focus = theme.black
theme.menu_bg_focus = theme.blue
theme.menu_fg_normal = theme.white
theme.menu_bg_normal = theme.black

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairh.png"
theme.layout_fairv = themes_path.."default/layouts/fairv.png"
theme.layout_floating  = themes_path.."default/layouts/floating.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifier.png"
theme.layout_max = themes_path.."default/layouts/max.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreen.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottom.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleft.png"
theme.layout_tile = themes_path.."default/layouts/tile.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletop.png"
theme.layout_spiral  = themes_path.."default/layouts/spiral.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindle.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernw.png"
theme.layout_cornerne = themes_path.."default/layouts/cornerne.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersw.png"
theme.layout_cornerse = themes_path.."default/layouts/cornerse.png"

-- Widget icons
theme.spotifyicon = icons_path .. "spotify.png"
theme.cpuicon = icons_path .. "cpu.png"
theme.memicon = icons_path .. "mem.png"
theme.dateicon = icons_path .. "date.png"
theme.keymapicon = icons_path .. "keymap.png"
theme.volume_mediumicon = icons_path .. "volume-medium.png"
theme.volume_lowicon = icons_path .. "volume-low.png"
theme.volumeicon = icons_path .. "volume.png"
theme.muteicon = icons_path .. "mute.png"
theme.clockicon = icons_path .. "clock.png"
theme.playicon = icons_path .. "play.png"
theme.pauseicon = icons_path .. "pause.png"
theme.stopicon = icons_path .. "stop.png"
theme.nexticon = icons_path .. "icons/catppuccin/next.png"
theme.previcon = icons_path .. "prev.png"
theme.musicicon = icons_path .. "music.png"
theme.discordicon = icons_path .. "discord.png"
theme.firefoxicon = icons_path .. "firefox.png"
theme.terminalicon = icons_path .. "terminal.png"
theme.powericon = icons_path .. "power.png"
theme.archicon = icons_path .. "arch.png"
theme.wifi_weakicon = icons_path .. "wifiweak.png"
theme.wifi_midicon = icons_path .. "wifimid.png"
theme.wifi_goodicon = icons_path .. "wifigood.png"
theme.ethicon = icons_path .. "network.png"
theme.nowifi = icons_path .. "wifi_slash.png"

awful.screen.connect_for_each_screen(function(s)
    -- gears.wallpaper.fit(nil, s, "black")
    menubar.geometry = {
        x = s.geometry.width / 4,
        y = s.geometry.height - 2 * theme.useless_gap - theme.wibox_height,
        width = s.geometry.width / 2,
    }
end)

-- Menubar
theme.menubar_border_width = theme.border_width
theme.menubar_border_color = theme.blue

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
