local beautiful = require("beautiful")
local vars = require("main.user-variables")
local theme_path = vars.theme_path
beautiful.init(theme_path)

require("bar.modules.spotifybox")
require("bar.modules.volumebox")
require("bar.modules.cpubox")
require("bar.modules.keymapbox")
require("bar.modules.membox")
require("bar.modules.layoutbox-container")
require("bar.modules.systray")
require("bar.modules.datebox")
require("bar.modules.clockbox")
require("bar.modules.net")
require("bar.modules.playerctl")
require("bar.modules.launcherbox")
require("bar.modules.powermenu")
require("bar.modules.mytags")
