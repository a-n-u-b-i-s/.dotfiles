hs.hotkey.bind({}, "F13", function()
	local app = hs.application.find("kitty")
	hs.console:printStyledtext(app)
	if app then
		if not app:mainWindow() then
			app:selectMenuItem({ "kitty", "New OS window" })
		elseif app:isFrontmost() then
			app:hide()
		else
			app:activate()
		end
	else
		hs.application.launchOrFocus("kitty")
	end
end)

hs.hotkey.bind({}, "F14", function()
	local app = hs.application.find("WhatsApp")
	hs.console:printStyledtext(app)
	if app then
		if not app:mainWindow() then
			app:selectMenuItem({ "WhatsApp", "New OS window" })
		elseif app:isFrontmost() then
			app:hide()
		else
			app:activate()
		end
	else
		hs.application.launchOrFocus("WhatsApp")
	end
end)

hs.hotkey.bind({}, "F15", function()
	local app = hs.application.find("Visual Studio Code")
	hs.console:printStyledtext(app)
	if app then
		if not app:mainWindow() then
			app:selectMenuItem({ "Visual Studio Code", "New OS window" })
		elseif app:isRunning() then
			app:hide()
		else
			app:activate()
		end
	else
		hs.application.launchOrFocus("Visual Studio Code")
	end
end)
