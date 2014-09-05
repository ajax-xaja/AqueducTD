local M = {}

--Set level specific things here. e.g..
--Your health and the enemies..
--The amount of enemies to spawn this level..
--The amount of money you start with..
local spawnedMax = 25
local enemyHealth = 25000 
local bossHealth = 1000
local health = 100
local money = 200 
M.spawnedMax = spawnedMax
M.enemyHealth = enemyHealth
M.health = health
M.money = money
M.bossHealth = bossHealth


--Controls what goes where/path.
--"sp" is the spawnpoint for the enemies
--"p1","p2" etc are the movement points for enemies.
--"ep" is the end point, where the enemies hurt you.
--0 is normal grass
--1 is road
--2 is water
local tileArray = {
	0,   0,   0,   0,   0,   0,   0,   0,   0,   0,
 "sp",   1,   1,   1,   1,   1,   1,   1,"p1",   0,
    0,   0,   0,   0,   0,   0,   0,   0,   1,   0,
	0,"p4",   1,   1,   1,   1,"p5",   0,   1,   0,
	0,   1,   0,   0,   0,   0,   1,   0,   1,   0,
	0,   1,   0,"p8",   1,   1,   1,   1,   1,"ep",
    0,   1,   0,   1,   0,   0,   1,   0,   1,   0,
    0,   1,   0,"p7",   1,   1,"p6",   0,   1,   0,
	0,   1,   0,   0,   0,   0,   0,   0,   1,   0,
	0,"p3",   1,   1,   1,   1,   1,   1,"p2",   0,
}
M.tileArray = tileArray


--Holds the movement/tile info..
local moveArray = {}


--Populate the moveArray..
--Each movement point in the tileArray needs info.
--Eg. the direction the enemy needs to move when they get to it.
--Also what image you want to be there. All the 0's by 
--default will be grass. 1 will be the path.
local i
for i=1, #tileArray do
	--Controls whats on the ground as well as enemy direction.
	if tileArray[i] == "sp" then moveArray[1] = { "right", i, "images/floor.png" } 
	elseif tileArray[i] == "p1" then moveArray[2] = { "down", i, "images/floor.png" } 
	elseif tileArray[i] == "p2" then moveArray[3] = { "left", i, "images/floor.png" } 
	elseif tileArray[i] == "p3" then moveArray[4] = { "up", i, "images/floor.png" }
	elseif tileArray[i] == "p4" then moveArray[5] = { "right", i, "images/floor.png" }
	elseif tileArray[i] == "p5" then moveArray[6] = { "down", i, "images/floor.png" } 
	elseif tileArray[i] == "p6" then moveArray[7] = { "left", i, "images/floor.png" } 	
	elseif tileArray[i] == "p7" then moveArray[8] = { "up", i, "images/floor.png" }
	elseif tileArray[i] == "p8" then moveArray[9] = { "right", i, "images/floor.png" }
	elseif tileArray[i] == "ep" then moveArray[10] = { "right", i, "images/open_spot.png" } 
	end
end
M.moveArray = moveArray


return M