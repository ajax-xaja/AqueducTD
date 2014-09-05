--******************************************************************
-- AqueducTD : An Aqueduct Futures Project Mobile Tower Defense Game
--******************************************************************
-- Code by Kevin Cruz, Elisabeth Fleischer, and Dylan Gustaveson
-- File: menus_screens/start.lua
---------------------------------------------------------------------

local storyboard = require "storyboard"
local scene = storyboard.newScene()
local currentLevel = nil

-----------------------------------------------
-- Creates the scene for AqueducTD's Start Menu
-----------------------------------------------
function scene:createScene( event )
	local group = self.view
	local widget = require "widget"
	local Sounds = require "Sounds"
	currentLevel = event.params.currentLevel
	local loadButton = nil
	
	-- Background Construction
	local background = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
	background:setFillColor( 120, 120, 120 )
	group:insert( background )
	
	-- Game Clip Panel
	local gameClip = display.newImageRect( "images/menus/startmenu/menuPicture.png", 300, 300 )
	gameClip.x = 160
	gameClip.y = 160
	gameClip:setStrokeColor(235,235,235)
	gameClip.strokeWidth = 4
	group:insert( gameClip )
	
	-----------------
	-- "Kiosk" Button
	-----------------
	-- Kiosk Button Event	
	local function kioskListener( event )
		local options = {
			params = {
				startTime = os.time(),
				duration = 0,
				currentLevel = 3,
				score = 0
			}	
		}
		audio.play( Sounds.clickFX, { channel = audio.findFreeChannel() } )
		audio.stop( Sounds.bgChannel )
		storyboard.gotoScene( "gameInfoKiosk", options )
	end
	
	-- Kiosk Button Construction	
	local kioskButton = widget.newButton{
		label = "K",
		font = "Bebas",
		width = 40,
		height = 40,
		onPress = kioskListener
	}
	kioskButton.x = 20
	kioskButton.y = 300
	group:insert( kioskButton )
	
	----------------
	-- "Play" Button
	----------------
	-- Play Button Event
	local function onPlayButtonEvent( event )
		local options = {
			params = {
				startTime = os.time(),
				duration = 0,
				currentLevel = 1,
				score = 0
			}	
		}
		audio.play( Sounds.clickFX, { channel = audio.findFreeChannel() } )
		audio.stop( Sounds.bgChannel )
		storyboard.gotoScene( "gameInfo", options )
	end
	
	-- Play Button Construction
	local playButton = widget.newButton{
		label = "PLAY",
		font = "Bebas",
		width = 150,
		height = 40,
		onPress = onPlayButtonEvent
	}
	playButton.x = 395
	playButton.y = 30
	group:insert( playButton )
	
	----------------
	-- "Load" Button
	----------------
	-- Load Button Event
	local function onLoadButtonEvent( event )
		local path = system.pathForFile( "save.txt", system.DocumentsDirectory )
		local file = io.open( path, "r" )
		if(file == nil) then 
			return
		end
		local saveData = file:read( "*a" )
        local saveTable = saveData:split(", ")
		--local currentLevel = saveTable[1]
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
		audio.play( Sounds.clickFX, { channel = audio.findFreeChannel() } )
		audio.stop( Sounds.bgChannel )
		storyboard.gotoScene( "gameInfo", options )
	end
	
	-- Load Button Construction
	loadButton = widget.newButton{
		label = "LOAD",
		font = "Bebas",
		width = 150,
		height = 40,
		onEvent = onLoadButtonEvent
	}
	loadButton.x = 395
	loadButton.y = 80
	group:insert( loadButton )
	
	-- Split Function
	function string:split( inSplitPattern, outResults )
		if not outResults then
			outResults = { }
		end
		local theStart = 1
		local theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
		while theSplitStart do
			table.insert( outResults, string.sub( self, theStart, theSplitStart-1 ) )
			theStart = theSplitEnd + 1
			theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
		end
		table.insert( outResults, string.sub( self, theStart ) )
		return outResults
	end

	------------------
	-- "How To" Button
	------------------
	-- How To Button Event
	local function onHowToButtonEvent( event )
		local options = {
			effect = "fade",
			time = 400,
			isModal = true
		}
		audio.play( Sounds.clickFX, { channel = audio.findFreeChannel() } )
		storyboard.showOverlay( "menus_screens.howtoplay", options )
	end
	
	-- How To Button Construction
	local howToButton  = widget.newButton{
		label = "HOW TO",
		font = "Bebas",
		width = 150,
		height = 40,
		onEvent = onHowToButtonEvent
	}
	howToButton.x = 395
	howToButton.y = 130
	group:insert( howToButton )
	
	-----------------------
	-- "High Scores" Button
	-----------------------
	-- High Scores Button Event
	local function onHighScoresButtonEvent( event )
		local options = {
			params = {
				finishDate = 0
			}
		}
		audio.play( Sounds.clickFX, { channel = audio.findFreeChannel() } )
		storyboard.gotoScene( "menus_screens.highscores", options )
	end
	
	-- High Schores Button Construction
	local highScoresButton = widget.newButton{
		label = "HIGH  SCORES",
		font = "Bebas",
		width = 150,
		height = 40,
		onEvent = onHighScoresButtonEvent
	}
	highScoresButton.x = 395
	highScoresButton.y = 180
	group:insert( highScoresButton )
	
	-------------------
	-- "Credits" Button
	-------------------
	-- Credits Button Event
	local function onCreditsButtonEvent( event )
		if ( event.phase == "ended" ) then
			storyboard.gotoScene( "menus_screens.credits1" )
			audio.play( Sounds.clickFX, { channel = audio.findFreeChannel() } )
			audio.stop( Sounds.bgChannel )
			audio.play( Sounds.creditMusic, { loops = -1, channel=Sounds.bgChannel } )
		end
	end
	
	-- Credits Button Construction
	local creditsButton = widget.newButton{
		label = "CREDITS",
		font = "Bebas",
		width = 150,
		height = 40,
		onEvent = onCreditsButtonEvent
	}
	creditsButton.x = 395
	creditsButton.y = 230
	group:insert( creditsButton )
	
	----------------
	-- "Exit" Button
	----------------
	-- Exit Button Event
	local function onExitButtonEvent( event )
		audio.play( Sounds.clickFX, { channel = audio.findFreeChannel() } )
		os.exit()
		-- USE ON ANDROID: native.requestExit()
	end
	
	-- Exit Button Contruction
	local exitButton = widget.newButton{
		label = "EXIT",
		font = "Bebas",
		width = 150,
		height = 40,
		onEvent = onExitButtonEvent
	}
	exitButton.x = 395
	exitButton.y = 280
	group:insert( exitButton )
end


----------------------------------------------
-- Enters the scene for AqueducTD's Start Menu
----------------------------------------------
function scene:enterScene( event )
	local Sounds = require "Sounds"
	
	-- Splash Screen Initiation
	if( currentLevel == 0 ) then
		local options = {
			isModal = true
		}
		storyboard.showOverlay( "menus_screens.splash", options )
		audio.play( Sounds.menuMusic, { loops=-1, channel=Sounds.bgChannel } )
		currentLevel = 1
	end
end


-- Scene Event Listeners
scene:addEventListener( "createScene" )
scene:addEventListener( "enterScene" )

-- Return Statement
return scene