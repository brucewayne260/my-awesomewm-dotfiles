local _M = {
-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), "default"),

-- This is used later as the default terminal and editor to run.
webbrowser = "firefox",
filemanager = "ranger",
terminal = "kitty",
editor = os.getenv("EDITOR") or "nvim",
editor_cmd = string.format("%s %s %s","kitty","-e",os.getenv("EDITOR")),

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4",
altkey = "Mod1",
}

return _M
