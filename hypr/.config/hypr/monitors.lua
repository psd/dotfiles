-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 1
local omarchy_monitor_scale = 1.25

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
-- Default for any external/unknown monitor: sit above the laptop screen
-- (mouse up goes to it) and own workspace 10 (the "0" key).
hl.monitor({ output = "", mode = "preferred", position = "auto-center-up", scale = omarchy_monitor_scale })

-- Laptop screen stays at the origin.
hl.monitor({ output = "eDP-1", mode = "preferred", position = "0x0", scale = omarchy_monitor_scale })

-- Workspace 10 lives on the external monitor, and follows whichever
-- non-laptop monitor is plugged in.
local function dedicate_workspace_10(mon)
  if mon.name == "eDP-1" then return end
  hl.workspace_rule({ workspace = "10", monitor = mon.name, persistent = true })
  hl.dispatch(hl.dsp.workspace.move({ workspace = "10", monitor = mon.name }))
end

hl.on("monitor.added", dedicate_workspace_10)
for _, mon in ipairs(hl.get_monitors()) do dedicate_workspace_10(mon) end

-- Configure a specific monitor.
-- hl.monitor({ output = "DP-2", mode = "2560x1440@144", position = "0x0", scale = 1 })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })

-- Workspaces 1-9 are pinned to the laptop screen; only 10 lives on the external one.
for i = 1, 9 do
  hl.workspace_rule({ workspace = tostring(i), monitor = "eDP-1", persistent = (i <= 5) })
end
