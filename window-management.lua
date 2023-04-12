hs.window.animationDuration = 0.1

mover = {"cmd", "ctrl"}
moverTwoThirds = {"cmd", "ctrl", "alt"}
moverOneThird = {"cmd", "ctrl", "shift"}

-- next screen
hs.hotkey.bind(mover, 'Down', function()
    -- get the focused window
    local win = hs.window.focusedWindow()
    -- get the screen where the focused window is displayed, a.k.a. current screen
    local screen = win:screen()
    -- compute the unitRect of the focused window relative to the current screen
    -- and move the window to the next screen setting the same unitRect
    win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
end)

hs.hotkey.bind(mover, "Left", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end)

hs.hotkey.bind(moverTwoThirds, "Left", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    local third = max.w / 3

    f.x = max.x
    f.y = max.y
    f.w = third * 2
    f.h = max.h
    win:setFrame(f)
end)

hs.hotkey.bind(moverOneThird, "Left", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    local third = max.w / 3

    f.x = max.x
    f.y = max.y
    f.w = third
    f.h = max.h
    win:setFrame(f)
end)

hs.hotkey.bind(mover, "Right", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    win:setFrame(f)
end)

hs.hotkey.bind(moverTwoThirds, "Right", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    local third = max.w / 3

    f.x = max.x + third
    f.y = max.y
    f.w = third * 2
    f.h = max.h
    win:setFrame(f)
end)

hs.hotkey.bind(moverOneThird, "Right", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    local third = max.w / 3

    f.x = max.x + (third * 2)
    f.y = max.y
    f.w = third
    f.h = max.h
    win:setFrame(f)
end)

hs.hotkey.bind(mover, "Up", function()
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    local max = screen:frame()
    local f = win:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h
    win:setFrame(f)
end)
