--******************************************************************
-- AqueducTD : An Aqueduct Futures Project Mobile Tower Defense Game
--******************************************************************
-- Code by Kevin Cruz, Elisabeth Fleischer, and Dylan Gustaveson
-- File: menus_screens/complete1.lua
---------------------------------------------------------------------

local storyboard = require "storyboard"
local scene = storyboard.newScene()

-------------------------------------------------------------
-- Creates the scene for AqueducTD's Level 1 Completion Panel
-------------------------------------------------------------
function scene:createScene( event )
	local group = self.view
	local widget = require "widget"
	local score = event.params.score
	local totalDuration = event.params.duration
	local finishDate = event.params.finishDate
	
	-- Background Construction
	local background = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
	background:setFillColor( 120, 120, 120 )
	group:insert( background )
	
	-- Finish Time Calculation
	print( totalDuration )
	local days = math.floor( totalDuration / 86400 )
	local remainder = totalDuration % 86400
	print ( remainder )
	local hours = math.floor( remainder / 3600 )
	remainder = remainder % 3600
	print ( remainder )
	local minutes = math.floor( remainder / 60 )
	remainder = remainder % 60
	print ( remainder )
	local seconds = remainder
	local finishTime = days .. " DAYS\n" .. hours .. " HOURS\n" .. minutes .. " MINUTES\n" .. seconds .. " SECONDS"
	
	-- Text Construction
	local winText = display.newText( "LEVEL 1 COMPLETE", 160, 10, 250, 40, "Bebas", 30 )
	local scoreText = display.newText( "Score: " .. score, 160, 55, 160, 20, "Arial", 10 )
	local finishDateText = display.newText( "Finish Date: " .. finishDate, 160, 75, 160, 20, "Arial", 10 )
	local finishTimeText = display.newText( "You finished the level in:\n" .. finishTime, 160, 95, 160, 100, "Arial", 10 )
	group:insert( winText )
	group:insert( scoreText )
	group:insert( finishDateText )
	group:insert( finishTimeText )
	
	--------------------------------
	-- Save And Go To Level 2 Button
	--------------------------------
	-- Save And Go To Level 2 Button Event
	local function nextLevelButtonEvent( event )
		local saveData = score .. ", " .. totalDuration
		local path = system.pathForFile( "save.txt", system.DocumentsDirectory ) 
		local file = io.open( path, "w" )
		file:write( saveData )
		io.close( file )
		file = nil
		local options = {
			params = {
				score = score,
				startTime = os.time(),
				duration = 0,
				currentLevel = 2
			}
		}
		storyboard.removeScene( "gameInfo" )
		storyboard.gotoScene( "gameInfo", options )
	end
	
	-- Save And Go To Level 2 Button Construction
	local nextLevelButton = widget.newButton{
		label = "SAVE  AND  GO  TO  LEVEL  2",
		font = "Bebas",
		width = 400,
		height = 40,
		onPress = nextLevelButtonEvent
	}
	nextLevelButton.x = 240
	nextLevelButton.y = 230
	group:insert( nextLevelButton )
	
	----------------------------------
	-- Save And Go To Main Menu Button
	----------------------------------
	-- Save And Go To Main Menu Button Event
	local function backToMainMenuButtonEvent( event )
		local saveData = score .. ", " .. totalDuration
		local path = system.pathForFile( "save.txt", system.DocumentsDirectory ) 
		local file = io.open( path, "w" )
		file:write( saveData )
		io.close( file )
		file = nil
		local options = {
			params = {
				currentLevel = 1
			}
		}
		storyboard.removeScene( "gameInfo" )
		storyboard.gotoScene( "menus_screens.start", options )
	end
	
	-- Save And Go To Main Menu Button Construction
	local mainMenuButton = widget.newButton{
		label = "SAVE  AND  GO  TO  MAIN  MENU",
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