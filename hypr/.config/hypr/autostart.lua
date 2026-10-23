-- Extra autostart processes.
-- o.launch_on_start("my-service")

-- Workspace overview, opened by a three-finger swipe up (see input.lua).
o.launch_on_start("qs -c overview")

-- White-on-black terminals on workspaces 1 and 3.
o.launch_on_start("/home/psd/.local/bin/psd-workspace-theme")
