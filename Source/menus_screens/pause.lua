--******************************************************************
-- AqueducTD : An Aqueduct Futures Project Mobile Tower Defense Game
--******************************************************************
-- Code by Kevin Cruz, Elisabeth Fleischer, and Dylan Gustaveson
-- File: menus_screens/pause.lua
---------------------------------------------------------------------

local storyboard = require "storyboard"
local scene = storyboard.newScene()
local flag = 0

-----------------------------------------------
-- Creates the scene for AqueducTD's Pause Menu
-----------------------------------------------
function scene:createScene( event )
	local group = self.view
	local widget = require "widget"
	
	-- Background Construction
	local background = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
	background:setFillColor( 0, 0, 0 )
	background.alpha = 0.75
	group:insert( background )
	
	----------------
	-- Resume Button
	----------------
	-- Resume Button Listener
	function resumeButtonListener( event )
		storyboard.hideOverlay( "fade", 400 )
	end
	
	-- Resume Button Construction
	local resumeButton = widget.newButton{
		label = "RESUME",
		font = "Bebas",
		width = 200,
		height = 40,
		onPress = resumeButtonListener
	}
	resumeButton.x = 240
	--resumeButton.y = 85
	resumeButton.y = 135
	group:insert( resumeButton )
	
	--------------
	-- Exit Button
	--------------
	-- Exit Button Listener
	function exitButtonListener( event )
		flag = 1
		storyboard.hideOverlay( "fade", 400 )
	end
	
	-- Exit Button Construction
	local exitNoSaveButton = widget.newButton{
		label = "EXIT",
		font = "Bebas",
		width = 200,
		height = 40,
		onPress = exitButtonListener
	}
	exitNoSaveButton.x = 240
	--exitNoSaveButton.y = 235
	exitNoSaveButton.y = 185
	group:insert( exitNoSaveButton )
end


---------------------------------------------
-- Exits the scene for AqueducTD's Pause Menu
---------------------------------------------
function scene:exitScene( event )
	if flag == 1 then
		audio.stop(Sounds.bgChannel)
		audio.play(Sounds.menuMusic, {loop = -1, channel = Sounds.bgChannel})
		storyboard.removeScene( "gameInfo" )
		storyboard.gotoScene( "menus_screens.start" )
	end
end


-- Scene Event Listeners
scene:addEventListener( "createScene" )
scene:addEventListener( "exitScene" )

-- Return Statement
return scene