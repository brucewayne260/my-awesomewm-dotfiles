local _M = {
theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), "default"),

webbrowser = "firefox",
filemanager = "ranger",
terminal = "kitty",
editor = os.getenv("EDITOR") or "nvim",
editor_cmd = string.format("%s %s %s","kitty","-e",os.getenv("EDITOR")),
modkey = "Mod4",
altkey = "Mod1",
}

return _M
