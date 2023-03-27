hs.loadSpoon("SpoonInstall")

Install = spoon.SpoonInstall

local windowManagement = require('./window-management')
local menuApp = require('menu-app')

hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()
