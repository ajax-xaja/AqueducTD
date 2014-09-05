--******************************************************************
-- AqueducTD : An Aqueduct Futures Project Mobile Tower Defense Game
--******************************************************************
-- Code by Kevin Cruz, Elisabeth Fleischer, and Dylan Gustaveson
-- File: menus_screens/splash.lua
---------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local newProgressView = nil


--------------------------------------------------
-- Creates the scene for AqueducTD's Splash Screen
--------------------------------------------------
function scene:createScene( event )
    local group = self.view
	local widget = require( "widget" )
	
	-- Splash Screen Image
	local img = display.newImage( "images/splash.png" )
	group:insert( img )
		
	-- Progress Bar
	newProgressView = widget.newProgressView{
		left = 90,
		top = 270,
		width = 300,
		isAnimated = true
	}
	local inc = 0.0
	local function progressIncrement()
		inc = inc + 0.2
		newProgressView:setProgress( inc )
	end
	timer.performWithDelay( 1000, progressIncrement, 5 )
end


-------------------------------------------------
-- Enters the scene for AqueducTD's Splash Screen
-------------------------------------------------
function scene:enterScene( event )
    local group = self.view
				
	-- Timer
	local function splashListener( event )
		storyboard.hideOverlay( "fade", 1000 )
		transition.dissolve( newProgressView )
	end
	timer1 = timer.performWithDelay( 6000, splashListener, 1 )
end


-- Scene Event Listeners
scene:addEventListener( "createScene" )
scene:addEventListener( "enterScene" )

-- Return Statement
return scene