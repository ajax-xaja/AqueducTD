--******************************************************************
-- AqueducTD : An Aqueduct Futures Project Mobile Tower Defense Game
--******************************************************************
-- Code by Kevin Cruz, Elisabeth Fleischer, and Dylan Gustaveson
-- File: main.lua
---------------------------------------------------------------------

local storyboard = require "storyboard" 
display.setStatusBar( display.HiddenStatusBar ) 
local options = {
	params = {
		currentLevel = 0
	}
}
storyboard.gotoScene( "menus_screens.start", options )




