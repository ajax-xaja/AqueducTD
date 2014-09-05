--******************************************************************
-- AqueducTD : An Aqueduct Futures Project Mobile Tower Defense Game
--******************************************************************
-- Code by Kevin Cruz, Elisabeth Fleischer, and Dylan Gustaveson
-- File: menus_screens/highscores.lua
---------------------------------------------------------------------

local storyboard = require "storyboard"
local scene = storyboard.newScene()
--local finishDate = nil
local score01text = nil
local score02text = nil
local score03text = nil
local score04text = nil
local score05text = nil
local score06text = nil
local score07text = nil
local score08text = nil
local score09text = nil
local score10text = nil

------------------------------------------------------
-- Creates the scene for AqueducTD's High Scores Panel
------------------------------------------------------
function scene:createScene( event )
	local group = self.view
	local widget = require "widget"
	local finishDate = event.params.finishDate
	
	-- Background Construction
	local background = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
	background:setFillColor( 120, 120, 120 )
	group:insert( background )
	
	-- High Scores Text
	local highScoresTitleText = display.newText( "HIGH  SCORES", 160, 10, 160, 40, "Bebas", 30 )
	group:insert( highScoresTitleText )
	
	---------------------------
	-- Back To Main Menu Button
	---------------------------
	-- Back to Main Menu Button Event
	local function backToMainMenuButtonEvent( event )
		storyboard.gotoScene( "menus_screens.start" )
	end
	
	-- Back to Main Menu Button Construction
	local mainMenuButton = widget.newButton{
		label = "BACK  TO  MAIN  MENU",
		font = "Bebas",
		width = 400,
		height = 40,
		onPress = backToMainMenuButtonEvent
	}
	mainMenuButton.x = 240
	mainMenuButton.y = 280
	group:insert( mainMenuButton )
end


------------------------------------------------------
-- Creates the scene for AqueducTD's High Scores Panel
------------------------------------------------------
function scene:enterScene( event )
	local group = self.view
	local scoresTable = nil
	
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
	
	-- Load High Scores Function
	local function loadHighScores() 
		local path = system.pathForFile( "scores.txt", system.DocumentsDirectory )
		local file = io.open( path, "r" )
		if(file == nil) then 
			return
		end
		local saveData = file:read( "*a" )
        scoresTable = saveData:split( ", " )
		io.close( file )
		file = nil
		for i = 1, #scoresTable do
			print( "scoresTable[i] = " .. scoresTable[i] )
		end
	end
	loadHighScores()
	
	-- Get Score Function
	local function getScore ( a )
		local aa = a:split( "; " )
		print( "getScore aa[1] = " .. aa[1] )
		return tonumber( aa[1] )
	end
	
	-- Compare and Sort Scores
	local function compare( a, b )
		a = getScore( a )
		b = getScore( b )
		if( a == nil or b == nil ) then return false end
		return a > b
	end 
	
	local function sortScores()
		if(scoresTable == nil) then 
				return
		else
			table.sort( scoresTable, compare )
		end
	end
	sortScores()
	
	-- Text Construction
	local function constructText()
		if(scoresTable == nil) then 
				return
		end
		
		if (scoresTable[1] ~= nil and scoresTable[1] ~= "") then 
			score01text = display.newText( "1. " .. scoresTable[1], 160, 55, 160, 20, "Arial", 10 )
			local splitter = scoresTable[1]:split("; ")
			for i = 1, #splitter do
				print( "1 splitter[i] = " .. splitter[i] )
			end
			if(splitter[2] == finishDate) then
				score01text:setTextColor( 255, 0, 0 )
			end
			group:insert( score01text )
		end
		if (scoresTable[2] ~= nil and scoresTable[2] ~= "") then 
			score02text = display.newText( "2. " .. scoresTable[2], 160, 75, 160, 20, "Arial", 10 )
			local splitter = scoresTable[2]:split("; ")
			if(splitter[2] == finishDate) then
				score02text:setTextColor( 255, 0, 0 )
			end
			group:insert( score02text )
		end
		if (scoresTable[3] ~= nil and scoresTable[3] ~= "") then 
			score03text = display.newText( "3. " .. scoresTable[3], 160, 95, 160, 20, "Arial", 10 )
			local splitter = scoresTable[3]:split("; ")
			if(splitter[2] == finishDate) then
				score03text:setTextColor( 255, 0, 0 )
			end
			group:insert( score03text )
		end
		if (scoresTable[4] ~= nil and scoresTable[4] ~= "") then 
			score04text = display.newText( "4. " .. scoresTable[4], 160, 115, 160, 20, "Arial", 10 ) 
			local splitter = scoresTable[4]:split("; ")
			if(splitter[2] == finishDate) then
				score04text:setTextColor( 255, 0, 0 )
			end
			group:insert( score04text )
		end
		if (scoresTable[5] ~= nil and scoresTable[5] ~= "") then 
			score05text = display.newText( "5. " .. scoresTable[5], 160, 135, 160, 20, "Arial", 10 ) 
			local splitter = scoresTable[5]:split("; ")
			if(splitter[2] == finishDate) then
				score05text:setTextColor( 255, 0, 0 )
			end
			group:insert( score05text )
		end
		if (scoresTable[6] ~= nil and scoresTable[6] ~= "") then 
			score06text = display.newText( "6. " .. scoresTable[6], 160, 155, 160, 20, "Arial", 10 )
			local splitter = scoresTable[6]:split("; ")
			if(splitter[2] == finishDate) then
				score06text:setTextColor( 255, 0, 0 )
			end
			group:insert( score06text )
		end
		if (scoresTable[7] ~= nil and scoresTable[7] ~= "") then 
			score07text = display.newText( "7. " .. scoresTable[7], 160, 175, 160, 20, "Arial", 10 ) 
			local splitter = scoresTable[7]:split("; ")
			if(splitter[2] == finishDate) then
				score07text:setTextColor( 255, 0, 0 )
			end
			group:insert( score07text )
		end
		if (scoresTable[8] ~= nil and scoresTable[8] ~= "") then 
			score08text = display.newText( "8. " .. scoresTable[8], 160, 195, 160, 20, "Arial", 10 ) 
			local splitter = scoresTable[8]:split("; ")
			if(splitter[2] == finishDate) then
				score08text:setTextColor( 255, 0, 0 )
			end
			group:insert( score08text )
		end
		if (scoresTable[9] ~= nil and scoresTable[9] ~= "") then 
			score09text = display.newText( "9. " .. scoresTable[9], 160, 215, 160, 20, "Arial", 10 ) 
			local splitter = scoresTable[9]:split("; ")
			if(splitter[2] == finishDate) then
				score09text:setTextColor( 255, 0, 0 )
			end
			group:insert( score09text )
		end
		if (scoresTable[10] ~= nil and scoresTable[10] ~= "") then 
			score10text = display.newText( "10. " .. scoresTable[10], 160, 235, 160, 20, "Arial", 10 ) 
			local splitter = scoresTable[10]:split("; ")
			if(splitter[2] == finishDate) then
				score10text:setTextColor( 255, 0, 0 )
			end
			group:insert( score10text )
		end
	end
	constructText()
end


----------------------------------------------------
-- Exits the scene for AqueducTD's High Scores Panel
----------------------------------------------------
function scene:exitScene( event )
	if(score01text ~= nil) then score01text:removeSelf() end
	if(score02text ~= nil) then score02text:removeSelf() end
	if(score03text ~= nil) then score03text:removeSelf() end
	if(score04text ~= nil) then score04text:removeSelf() end
	if(score05text ~= nil) then score05text:removeSelf() end
	if(score06text ~= nil) then score06text:removeSelf() end
	if(score07text ~= nil) then score07text:removeSelf() end
	if(score08text ~= nil) then score08text:removeSelf() end
	if(score09text ~= nil) then score09text:removeSelf() end
	if(score10text ~= nil) then score10text:removeSelf() end
	
end


-- Scene Event Listeners
scene:addEventListener( "createScene" )
scene:addEventListener( "enterScene" )
scene:addEventListener( "exitScene" )

-- Return Statement
return scene