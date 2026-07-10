hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.layer_rule({
    match = {
        namespace = "vicinae",
    },
    blur = true,
    ignore_alpha = false
})

--[[hl.layer_rule({
    match = {
        namespace = "quickshell",
    },
    blur = true
})]]

hl.window_rule({
    match = {
        initial_title = "negative:Steam",
        class = "steam"
    },
    float = true
})

hl.window_rule({
    match = {
        title = "Quickshell Settings",
    },
    float = true
})

hl.window_rule({
    match = {
        title = "Quickshell Overlay Backdrop",
    },
    float = true,
    size = "100% 100%",
    move = "0 0"
})

hl.window_rule({
    match = {
        title = "Quickshell Overlay",
    },
    float = true
})

hl.window_rule({
    match = {title = "^(orbolay)$"},
    no_initial_focus = true,
    suppress_event = "activatefocus",
    float = true,
    pin = true,
    center = true,
    no_blur = true,
    no_dim = true,
    no_follow_mouse = true,
    no_shadow = true,
    border_size = 0,
    no_focus = true,
    move = {"monitor_w", "monitor_h"},
    size = {"monitor_w - 5", "monitor_h - 5"}
})
