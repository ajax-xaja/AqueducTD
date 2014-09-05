--------------------------------------------------------------------
-- AqueducTD : An Aqueduct Futures Project Mobile Tower Defense Game
-------------------------------------------------------------------- 
-- Code by Kevin Cruz, Elisabeth Fleischer, and Dylan Gustaveson
-- File: menus_screens/credits1.lua
---------------------------------------------------------------------
---------------------------------------------------------------------

local storyboard = require "storyboard"
local Sounds = require 'Sounds'
local scene = storyboard.newScene()

--------------------------------------------------
-- Creates the scene for AqueducTD's Credits Panel
--------------------------------------------------
function scene:createScene( event )
	local group = self.view
	local widget = require "widget"
	
	---------------------------
	-- Credits Panel Background
	---------------------------
	local background = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
	background:setFillColor( 120, 120, 120 )
	group:insert( background )
	
	----------
	-- Credits
	----------
	--local creditsText = display.newText( "CREDITS", 180, 10, 120, 40, "Bebas", 30 )
	--group:insert( creditsText )
   
	local lisa = display.newImageRect( "images/menus/credits/lisa.png", 90, 90  )
   lisa:setReferencePoint( display.TopLeftReferencePoint )
   lisa.x = 10
   lisa.y = 10
	lisa:setFillColor( 150, 150, 150 )
	lisa.strokeWidth = 2
	lisa:setStrokeColor( 0, 0, 0 )
	group:insert( lisa )
   
	local lisaText = display.newText( "Elisabeth\nFleischer", 120, 20, 250, 100, "Arial", 32 )
	group:insert( lisaText )
	
   local dylan = display.newImageRect( "images/menus/credits/dylan.png", 90, 90  )
   dylan:setReferencePoint( display.TopLeftReferencePoint )
   dylan.x = 10
   dylan.y = 115
	dylan:setFillColor( 150, 150, 150 )
	dylan.strokeWidth = 2
	dylan:setStrokeColor( 0, 0, 0 )
	group:insert( dylan )
	
	local dylanText = display.newText( "Dylan\nGustaveson", 120, 120, 250, 100, "Arial", 32 )
	group:insert( dylanText )
   
   local kevin = display.newImageRect( "images/menus/credits/kevin.png", 90, 90  )
   kevin:setReferencePoint( display.TopLeftReferencePoint )
   kevin.x = 10
   kevin.y = 220
	kevin:setFillColor( 150, 150, 150 )
	kevin.strokeWidth = 2
	kevin:setStrokeColor( 0, 0, 0 )
	group:insert( kevin )
	
	local kevinText = display.newText( "Kevin\nCruz", 120, 230, 250, 100, "Arial", 32 )
	group:insert( kevinText )
	
	---------------------------
	-- Back To Main Menu Button
	---------------------------
	local function backToMainMenuButtonEvent( event )
		storyboard.gotoScene( "menus_screens.start" )
      audio.stop(Sounds.bgChannel)
      audio.play(Sounds.clickFX, {channel = audio.findFreeChannel()})
      audio.play(Sounds.menuMusic, {loops=-1, channel=Sounds.bgChannel})
	end
	local mainMenuButton = widget.newButton{
		label = "X",
		font = "Bebas",
		width = 42,
		height = 40,
		onPress = backToMainMenuButtonEvent
	}
	mainMenuButton.x = 455
	mainMenuButton.y = 25
	group:insert( mainMenuButton )
end


-- Scene Event Listeners
scene:addEventListener( "createScene" )

-- Return Statement
return scene