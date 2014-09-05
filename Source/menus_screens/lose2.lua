--******************************************************************
-- AqueducTD : An Aqueduct Futures Project Mobile Tower Defense Game
--******************************************************************
-- Code by Kevin Cruz, Elisabeth Fleischer, and Dylan Gustaveson
-- File: menus_screens/lose2.lua
---------------------------------------------------------------------

local storyboard = require "storyboard"
local scene = storyboard.newScene()

----------------------------------------------------
-- Creates the scene for AqueducTD's Game Lost Panel
----------------------------------------------------
function scene:createScene( event )
	local group = self.view
	local widget = require "widget"
	
	-- Background Construction
	local background = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
	background:setFillColor( 120, 120, 120 )
	group:insert( background )
	
	-- Text Contruction
	local loseText = display.newText( "YOU  LOSE", 160, 10, 250, 40, "Bebas", 30 )
	group:insert( loseText )
	
	-----------------------
	-- Restart Level Button
	-----------------------
	-- Restart Level Button Event
	local function restartLevelButtonEvent( event )
		local path = system.pathForFile( "save.txt", system.DocumentsDirectory )
		local file = io.open( path, "r" )
		if(file == nil) then 
			return
		end
		local saveData = file:read( "*a" )
		local saveTable = saveData:split(", ")
		local score = saveTable[1]
		local duration = saveTable[2]
		local startTime = os.time()
		io.close( file )
		file = nil
		local options = {
			params = {
				startTime = startTime,
				duration = duration,
				score = score,
				currentLevel = 2
			}	
		}
		storyboard.removeScene( "gameInfo" )
		storyboard.gotoScene( "gameInfo", options )
	end
	
	-- Restart Level Button Construction
	local restartLevelButton = widget.newButton{
		label = "RESTART  LEVEL",
		font = "Bebas",
		width = 400,
		height = 40,
		onPress = restartLevelButtonEvent
	}
	restartLevelButton.x = 240
	restartLevelButton.y = 230
	group:insert( restartLevelButton )
	
	-------------------------
	-- Go To Main Menu Button
	-------------------------
	-- Go To Main Menu Button Event
	local function backToMainMenuButtonEvent( event )
		local options = {
			params = {
				currentLevel = 1
			}
		}
		storyboard.removeScene( "gameInfo" )
		storyboard.gotoScene( "menus_screens.start", options )
	end
	
	-- Go To Main Menu Button Construction
	local mainMenuButton = widget.newButton{
		label = "GO TO  MAIN  MENU",
		font = "Bebas",
		width = 400,
		height = 40,
		onPress = backToMainMenuButtonEvent
	}
	mainMenuButton.x = 240
	mainMenuButton.y = 280
	group:insert( mainMenuButton )
end


-- Scene Event Listeners
scene:addEventListener( "createScene" )

-- Return Statement
return scene