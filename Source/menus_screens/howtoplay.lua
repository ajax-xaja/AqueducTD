--------------------------------------------------------------------
-- AqueducTD : An Aqueduct Futures Project Mobile Tower Defense Game
-------------------------------------------------------------------- 
-- Code by Kevin Cruz, Elisabeth Fleischer, and Dylan Gustaveson
-- File: menus_screens/howtoplay.lua
---------------------------------------------------------------------
---------------------------------------------------------------------

local storyboard = require "storyboard"
local Sounds = require 'Sounds'
local scene = storyboard.newScene()


------------------------------------------------------
-- Creates the scene for AqueducTD's How To Play Panel
------------------------------------------------------
function scene:createScene( event )
   local group = self.view
	local widget = require "widget"
	local flag = 1
	
	-------------------------
	-- How to Play Background
	-------------------------
	local background = display.newRect( 100, 20, 280, 270 )
	background:setFillColor( 0, 0, 0 )
	background.alpha = 0.95
   background:setStrokeColor(215, 215, 215)
   background.strokeWidth = 2
	group:insert( background )
	
	--------------------------
	-- How To Play Image Panel
	--------------------------
	local gameClip = display.newImageRect( "images/menus/howto/howto_1.png", 200, 200 )
	gameClip.x = 240
	gameClip.y = 135
	group:insert( gameClip )
	
	---------------------------
	-- Back to Main Menu Button
	---------------------------
	local backToMainMenuButton = widget.newButton{
		label = "MENU",
		font = "Bebas",
		width = 80,
		height = 40
	}
	backToMainMenuButton.x = 240
	backToMainMenuButton.y = 260
	function backToMainMenuButtonListener( event )
		storyboard.hideOverlay( "fade", 400 )
      audio.play(Sounds.clickFX)
	end
	backToMainMenuButton:addEventListener( "tap", backToMainMenuButtonListener )
	group:insert( backToMainMenuButton )
	
	--------------
	-- Back Button
	--------------
	local backButton = widget.newButton{
		label = "BACK",
		font = "Bebas",
		width = 80,
		height = 40
	}
	backButton.x = 150
	backButton.y = 260
   
	function backButtonListener( event )
		gameClip:removeSelf()
		if flag == 1 then
			gameClip = display.newImageRect( "images/menus/howto/howto_10.png", 200, 200 )
			gameClip.x = 240
			gameClip.y = 135
			group:insert( gameClip )
			flag = 10
		elseif flag == 2 then
			gameClip = display.newImageRect( "images/menus/howto/howto_1.png", 200, 200 )
			gameClip.x = 240
			gameClip.y = 135
			group:insert( gameClip )
			flag = 1
		elseif flag == 3  then
			gameClip = display.newImageRect( "images/menus/howto/howto_2.png", 200, 200 )
			gameClip.x = 240
			gameClip.y = 135
			group:insert( gameClip )
			flag = 2
		elseif flag == 4 then
			gameClip = display.newImageRect( "images/menus/howto/howto_3.png", 200, 200 )
			gameClip.x = 240
			gameClip.y = 135
			group:insert( gameClip )
			flag = 3
		elseif flag == 5 then
			gameClip = display.newImageRect( "images/menus/howto/howto_4.png", 200, 200 )
			gameClip.x = 240
			gameClip.y = 135
			group:insert( gameClip )
			flag = 4
		elseif flag == 6 then
			gameClip = display.newImageRect( "images/menus/howto/howto_5.png", 200, 200 )
			gameClip.x = 240
			gameClip.y = 135
			group:insert( gameClip )
			flag = 5
		elseif flag == 7 then
			gameClip = display.newImageRect( "images/menus/howto/howto_6.png", 200, 200 )
			gameClip.x = 240
			gameClip.y = 135
			group:insert( gameClip )
			flag = 6
		elseif flag == 8 then
			gameClip = display.newImageRect( "images/menus/howto/howto_7.png", 200, 200 )
			gameClip.x = 240
			gameClip.y = 135
			group:insert( gameClip )
			flag = 7
		elseif flag == 9 then
			gameClip = display.newImageRect( "images/menus/howto/howto_8.png", 200, 200 )
			gameClip.x = 240
			gameClip.y = 135
			group:insert( gameClip )
			flag = 8
		elseif flag == 10 then
			gameClip = display.newImageRect( "images/menus/howto/howto_9.png", 200, 200 )
			gameClip.x = 240
			gameClip.y = 135
			group:insert( gameClip )
			flag = 9         
		end
      audio.play(Sounds.clickFX)
	end
	backButton:addEventListener( "tap", backButtonListener )
	group:insert( backButton )
	
	--------------
	-- Next Button
	--------------
	local nextButton = widget.newButton{
		label = "NEXT",
		font = "Bebas",
		width = 80,
		height = 40
	}
	nextButton.x = 330
	nextButton.y = 260
	function nextButtonListener( event )
		gameClip:removeSelf()
		if flag == 1 then
			gameClip = display.newImageRect( "images/menus/howto/howto_2.png", 200, 200 )
			gameClip.x = 240
			gameClip.y = 135
			group:insert( gameClip )
			flag = 2
		elseif flag == 2 then
			gameClip = display.newImageRect( "images/menus/howto/howto_3.png", 200, 200 )
			gameClip.x = 240
			gameClip.y = 135
			group:insert( gameClip )
			flag = 3
		elseif flag == 3  then
			gameClip = display.newImageRect( "images/menus/howto/howto_4.png", 200, 200 )
			gameClip.x = 240
			gameClip.y = 135
			group:insert( gameClip )
			flag = 4
		elseif flag == 4 then
			gameClip = display.newImageRect( "images/menus/howto/howto_5.png", 200, 200 )
			gameClip.x = 240
			gameClip.y = 135
			group:insert( gameClip )
			flag = 5
		elseif flag == 5 then
			gameClip = display.newImageRect( "images/menus/howto/howto_6.png", 200, 200 )
			gameClip.x = 240
			gameClip.y = 135
			group:insert( gameClip )
			flag = 6
		elseif flag == 6 then
			gameClip = display.newImageRect( "images/menus/howto/howto_7.png", 200, 200 )
			gameClip.x = 240
			gameClip.y = 135
			group:insert( gameClip )
			flag = 7
		elseif flag == 7 then
			gameClip = display.newImageRect( "images/menus/howto/howto_8.png", 200, 200 )
			gameClip.x = 240
			gameClip.y = 135
			group:insert( gameClip )
			flag = 8
		elseif flag == 8 then
			gameClip = display.newImageRect( "images/menus/howto/howto_9.png", 200, 200 )
			gameClip.x = 240
			gameClip.y = 135
			group:insert( gameClip )
			flag = 9
		elseif flag == 9 then
			gameClip = display.newImageRect( "images/menus/howto/howto_10.png", 200, 200 )
			gameClip.x = 240
			gameClip.y = 135
			group:insert( gameClip )
			flag = 10
		elseif flag == 10 then
			gameClip = display.newImageRect( "images/menus/howto/howto_1.png", 200, 200 )
			gameClip.x = 240
			gameClip.y = 135
			group:insert( gameClip )
			flag = 1        
		end
      audio.play(Sounds.clickFX)
	end
	nextButton:addEventListener( "tap", nextButtonListener )
	group:insert( nextButton )
end


-- Scene Event Listeners
scene:addEventListener( "createScene" )

-- Return Statement
return scene