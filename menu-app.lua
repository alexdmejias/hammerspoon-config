focusMenu = hs.menubar.new()
local defaultFocusText = "🔥"
b = ""

jokesTimer = nil

json = hs.json.read("~/jokes.json")

jokesMenu = hs.menubar.new()

jokesTimer = hs.timer.doEvery(10 * 60, function()
    if (jokesEnabled) then
        random = hs.math.randomFromRange(1, tablelength(json))
        joke = json[random]
        hs.notify.show("Dad Joke", joke[1], joke[2])
    end
end)

local speech = require 'hs.speech'

-- Init speaker.
speaker = speech.new()

announcerMenu = hs.menubar.new()

announcerTimer = hs.timer.doEvery(60, function()
    local mins = os.date("%M")
    if (announcerEnabled and (math.fmod(tonumber(mins), 15) == 0)) then
        print("at quater", os.date("%I:%M"))
        speaker:speak(os.date("%I:%M"))
    end
end)

function focusClicked()
    _, b = hs.dialog.textPrompt("Set Display Text", "")
    if (b == nil or b == '') then
        b = defaultFocusText
    end
    focusMenu:setTitle(b)
end

if focusMenu then
    -- focusMenu:setClickCallback(focusClicked)
    focusMenu:setTitle(defaultFocusText)
end

timer = nil
timeLeftTimer = nil;

function createTimerMap(minutes)
    return {
        title = minutes .. " minute(s)",
        fn = function()
            if timer then
                timer:stop()
            end

            print(minutes .. " minute(s) timer started")
            local t = b
            local minutesLeft = minutes

            if t == "" then
                t = "timer"
            end

            focusMenu:setTitle(t .. " - " .. minutes .. " min(s)")

            timer = hs.timer.doAfter(minutesLeft * 60, function()
                if b == "" or b == nil then
                    b = defaultFocusText
                end
                focusMenu:setTitle(b)
                print(minutes .. " minute(s) elapsed")
                timeLeftTimer:stop()
                hs.notify.show("timer ended", "timer ended 2", "")
            end)

            timeLeftTimer = hs.timer.doEvery(60, function()
                minutesLeft = minutesLeft - 1
                focusMenu:setTitle(t .. " - " .. minutesLeft .. " min(s)")
            end)
        end
    }
end

DIVIDER = {
    title = "-------",
    disabled = true
}

jokesEnabled = true
announcerEnabled = true

focusMenu:setMenu(function()
    return {{
        title = "set title",
        fn = focusClicked
    }, DIVIDER, createTimerMap(1), createTimerMap(5), createTimerMap(10), createTimerMap(15), createTimerMap(20),
            createTimerMap(30), DIVIDER, {
        title = "stop timer",
        fn = function()
            if timer then
                timer:stop()
                timeLeftTimer:stop()
            end
            if b == "" or b == nil then
                b = defaultFocusText
            end
            focusMenu:setTitle(b)
            print("timer stopped")
        end
    }, DIVIDER, {
        title = "tell jokes",
        checked = jokesEnabled,
        fn = function()
            if (jokesEnabled) then
                jokesEnabled = false
            else
                jokesEnabled = true
            end
        end
    }, {
        title = "tell time",
        checked = announcerEnabled,
        fn = function()
            if (announcerEnabled) then
                announcerEnabled = false
                -- announcerMenu:setTitle("disabled")
            else
                announcerEnabled = true
                -- announcerMenu:setTitle("enabled")
            end
        end
    }}
end)

function tablelength(T)
    local count = 0
    for _ in pairs(T) do
        count = count + 1
    end
    return count
end
