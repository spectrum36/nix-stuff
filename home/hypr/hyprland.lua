--autostart
hl.on("hyprland.start", function ()
--hl.exec_cmd("discord --enable-features=UseOzonePlatform,WebRTCPipeWireCapturer --ozone-platform=wayland")
hl.exec_cmd("noctalia-shell")
hl.exec_cmd("easyeffects -w")
hl.exec_cmd("hyprpaper")
hl.exec_cmd("tailscale up")
end)

--monitor setup
hl.monitor({output = "eDP-1", mode = "1920x1200@60", position = "0x0", scale = 1})
hl.monitor({output = "HDMI-A-2", mode = "1920x1080", position = "1920x0", scale = 1})
hl.monitor({output = "DP-2", mode = "1920x1080", position = "3840x0", scale = 1})

--local variables
local mainmod = "SUPER"
local terminal = "kitty"
local filemanager = "pcmanfm"
local menu = "fuzzel"

--hyprland variables
hl.config({general = {gaps_in = 0}})
hl.config({general = {gaps_out = 0}})
hl.config({input = {follow_mouse = 2}})
hl.config({cursor = {no_warps = true}})

--core binds
hl.bind(mainmod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainmod .. " + C", hl.dsp.window.close())
hl.bind(mainmod .. " + M", hl.dsp.exit())
hl.bind(mainmod .. " + E", hl.dsp.exec_cmd(filemanager))
hl.bind(mainmod .. " + v", hl.dsp.window.float({ action = "toggle"}))
hl.bind(mainmod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainmod .. " + SHIFT + S", hl.dsp.exec_cmd("grimblast copy area"))

--window movment binds
hl.bind(mainmod .. " + left", hl.dsp.focus({direction = "l"}))
hl.bind(mainmod .. " + right", hl.dsp.focus({direction = "r"}))
hl.bind(mainmod .. " + up", hl.dsp.focus({direction = "u"}))
hl.bind(mainmod .. " + down", hl.dsp.focus({direction = "d"}))

hl.bind(mainmod .. " + SHIFT + right", hl.dsp.window.move({ monitor = "r"}))
hl.bind(mainmod .. " + SHIFT + left", hl.dsp.window.move({ monitor = "l"}))

hl.bind(mainmod .. " + CTRL + right", hl.dsp.window.move({direction = "r"}))
hl.bind(mainmod .. " + CTRL + left", hl.dsp.window.move({direction = "l"}))
hl.bind(mainmod .. " + CTRL + up", hl.dsp.window.move({direction = "u"}))
hl.bind(mainmod .. " + CTRL + down", hl.dsp.window.move({direction = "d"}))

--workspace binds
hl.bind(mainmod .. " + 1", hl.dsp.focus({workspace = "1", on_current_monitor = false}))
hl.bind(mainmod .. " + 2", hl.dsp.focus({workspace = "2", on_current_monitor = false}))
hl.bind(mainmod .. " + 3", hl.dsp.focus({workspace = "3", on_current_monitor = false}))
hl.bind(mainmod .. " + 4", hl.dsp.focus({workspace = "4", on_current_monitor = false}))
hl.bind(mainmod .. " + 5", hl.dsp.focus({workspace = "5", on_current_monitor = false}))
hl.bind(mainmod .. " + 6", hl.dsp.focus({workspace = "6", on_current_monitor = false}))
hl.bind(mainmod .. " + 7", hl.dsp.focus({workspace = "7", on_current_monitor = false}))
hl.bind(mainmod .. " + 8", hl.dsp.focus({workspace = "8", on_current_monitor = false}))
hl.bind(mainmod .. " + 9", hl.dsp.focus({workspace = "9", on_current_monitor = false}))

--move window to workspace
hl.bind(mainmod .. " + SHIFT + 1", hl.dsp.window.move({workspace = "1"}))
hl.bind(mainmod .. " + SHIFT + 2", hl.dsp.window.move({workspace = "2"}))
hl.bind(mainmod .. " + SHIFT + 3", hl.dsp.window.move({workspace = "3"}))
hl.bind(mainmod .. " + SHIFT + 4", hl.dsp.window.move({workspace = "4"}))
hl.bind(mainmod .. " + SHIFT + 5", hl.dsp.window.move({workspace = "5"}))
hl.bind(mainmod .. " + SHIFT + 6", hl.dsp.window.move({workspace = "6"}))
hl.bind(mainmod .. " + SHIFT + 7", hl.dsp.window.move({workspace = "7"}))
hl.bind(mainmod .. " + SHIFT + 8", hl.dsp.window.move({workspace = "8"}))
hl.bind(mainmod .. " + SHIFT + 9", hl.dsp.window.move({workspace = "9"}))


--animations
hl.animation({leaf = "global", enabled = false})

--window rules

--workspace rules
hl.workspace_rule({workspace = "1", monitor = "eDP-1"})
hl.workspace_rule({workspace = "2", monitor = "eDP-1"})
hl.workspace_rule({workspace = "3", monitor = "eDP-1"})
hl.workspace_rule({workspace = "4", monitor = "HDMI-A-2"})
hl.workspace_rule({workspace = "5", monitor = "HDMI-A-2"})
hl.workspace_rule({workspace = "6", monitor = "HDMI-A-2"})
hl.workspace_rule({workspace = "7", monitor = "DP-2"})
hl.workspace_rule({workspace = "8", monitor = "DP-2"})
hl.workspace_rule({workspace = "9", monitor = "DP-2"})
