--******************************************************************
-- AqueducTD : An Aqueduct Futures Project Mobile Tower Defense Game
--******************************************************************
-- Code by Kevin Cruz, Elisabeth Fleischer, and Dylan Gustaveson
-- File: gameInfo.lua
---------------------------------------------------------------------

local storyboard = require "storyboard"
local scene = storyboard.newScene()
local gameIsActive = nil
local startTime = nil
local towerArray = nil
local levelRects = nil

---------------------------------------------------
-- Creates the scene for AqueducTD's In-Game Screen
---------------------------------------------------
function scene:createScene( event )
	local Towers = require "Towers"
	local Sounds = require "Sounds"
	local duration = event.params.duration
	local currentLevel = event.params.currentLevel
	local score = event.params.score
	startTime = event.params.startTime
	
	local pistolButton = nil
	local powershotButton = nil
	local shotgunButton = nil
	local rocketButton = nil
	local boomerangButton = nil
	local towerSelected = nil

	-- Attack Speed Timer
	attackSpeedTimer = 0
	function updateAttackSpeedTimer()
		attackSpeedTimer = attackSpeedTimer + 1
	end
	attackSpeedTimerUpdater = timer.performWithDelay( 10, updateAttackSpeedTimer, 0 )
   
	-- Physics
	local physics = require "physics"
	physics.start()
	physics.setGravity( 0, 0 )

	-- Groups
	local localGroup = self.view
	local levelGroup = display.newGroup() --Setup the display groups we want
	local enemyGroup = display.newGroup()
	local weaponGroup = display.newGroup()
	local overlayGroup = display.newGroup()
	localGroup:insert(levelGroup)
	localGroup:insert(enemyGroup)
	localGroup:insert(weaponGroup)
	localGroup:insert(overlayGroup)

	-- Width, Height, and Math Variables
	local _W = display.contentWidth
	local _H = display.contentHeight 
	local mRound = math.round
	local mRand = math.random
	local mCeil = math.ceil
	local mAtan2 = math.atan2 
	local mSqrt = math.sqrt 
	local mPi = math.pi

	--Sets Up The Level Data Arrays
	local level = require("level"..currentLevel)
	local moveArray = level.moveArray
	local tileArray = level.tileArray 
	levelRects = {}

	--Other Level Information
	local spawnedMax = level.spawnedMax
	local enemyHealth = level.enemyHealth 
	local health = level.health
	local money = level.money

	--Level Control Variables
	local scoreText, moneyText, healthText 
	gameIsActive = true --If its false nothing will move etc..
	local spawnInt = 0 --iterated in the gameloop to control spawning
	local spawned = 0 --Keeps track of enemy amount
	if ( score == nil ) then
		score = 0
	end
	
	--Sets up Towers, Timers, and Transitions Arrays
	towerArray = {}
	local towerTimers = {}
	local towerTrans = {}

	--Pre-Declares A Function
	local changeText
	local clean
    
	--------------------
	-- Game Panel Images
	--------------------
	-- Houses
	local img1 = display.newImage( "images/houses.png" )
	img1.x = 16
	img1.y = 160
	levelGroup:insert( img1 )

	-- Aqueduct
	local img2 = display.newImage( "images/newaqueduct.png" )
	img2.x = 384
	img2.y = 160
	levelGroup:insert( img2 )

	-- Tower Selection Background
	local img3 = display.newImage( "images/towerbg.png" )
	img3.x = 448
	img3.y = 160
	levelGroup:insert( img3 )
	
	-----------------------
	-- In-Game Pause Button
	-----------------------
	-- Pause Button Listener
	function pauseButtonListener( event )	
		gameIsActive = false
		timer.pause(attackSpeedTimerUpdater)
		duration = duration + ( os.time() - startTime )
		local options = {
			effect = "fade",
			time = 400,
			isModal = true
			--params = {
				--duration = duration,
				--score = score,
				--currentLevel = currentLevel
			--}
		}
		storyboard.showOverlay( "menus_screens.pause", options )
	end
	
	-- Pause Button Construction
	pauseButton = display.newImageRect( "images/pause-2.png", 20, 20 )
	pauseButton.x = 15
	pauseButton.y = 15
	pauseButton:addEventListener( "tap", pauseButtonListener )
	levelGroup:insert( pauseButton )
	
	
--------------------------------
-- Tower Button Functionality --
--------------------------------
   if (currentLevel == 2) then
      function pistolButtonListener( event )	
         towerSelected = "pistol"
         pistolButton:setFillColor(255,255,255)
         pistolButton.alpha = 0.7
         magnumButton.alpha = 1
         shotgunButton.alpha = 1
         rocketButton.alpha = 1
         print(towerSelected)

      end
      pistolButton = display.newImageRect( "images/towerButtons/pistol_button.png", 50, 50)
      pistolButton.x = 448
      pistolButton.y = 45
      pistolButton:addEventListener( "tap", pistolButtonListener )
      levelGroup:insert( pistolButton )

      function magnumButtonListener( event )	
         towerSelected = "magnum"
         magnumButton:setFillColor(255,255,255)
         magnumButton.alpha = 0.7
         pistolButton.alpha = 1
         shotgunButton.alpha = 1
         rocketButton.alpha = 1
         print(towerSelected)
      end
      magnumButton = display.newImageRect( "images/towerButtons/magnum_button.png", 50, 50)
      magnumButton.x = 448
      magnumButton.y = 100
      magnumButton:addEventListener( "tap", magnumButtonListener )
      levelGroup:insert( magnumButton )

      function rocketButtonListener( event )	
         towerSelected = "rocket"
         rocketButton:setFillColor(255,255,255)
         rocketButton.alpha = 0.7
         pistolButton.alpha = 1
         shotgunButton.alpha = 1
         magnumButton.alpha = 1
         print(towerSelected)
      end
      rocketButton = display.newImageRect( "images/towerButtons/rocket_button.png", 50, 50)
      rocketButton.x = 448
      rocketButton.y = 210
      rocketButton:addEventListener( "tap", rocketButtonListener )
      levelGroup:insert( rocketButton )

      function shotgunButtonListener( event )	
         towerSelected = "shotgun"
         shotgunButton:setFillColor(255,255,255)
         shotgunButton.alpha = 0.7
         pistolButton.alpha = 1
         rocketButton.alpha = 1
         magnumButton.alpha = 1
         print(towerSelected)
      end
      shotgunButton = display.newImageRect( "images/towerButtons/shotgun_button.png", 50, 50)
      shotgunButton.x = 448
      shotgunButton.y = 155
      shotgunButton:addEventListener( "tap", shotgunButtonListener )
      levelGroup:insert( shotgunButton )
      else
         function pistolButtonListener( event )	
            towerSelected = "pistol"
            pistolButton:setFillColor(255,255,255)
            pistolButton.alpha = 0.7
            magnumButton.alpha = 1
            boomerangButton.alpha = 1
            ballchainButton.alpha = 1
            print(towerSelected)
         end
         pistolButton = display.newImageRect( "images/towerButtons/pistol_button.png", 50, 50)
         pistolButton.x = 448
         pistolButton.y = 45
         pistolButton:addEventListener( "tap", pistolButtonListener )
         levelGroup:insert( pistolButton )

         function magnumButtonListener( event )	
            towerSelected = "magnum"
            magnumButton:setFillColor(255,255,255)
            magnumButton.alpha = 0.7
            pistolButton.alpha = 1
            boomerangButton.alpha = 1
            ballchainButton.alpha = 1
            print(towerSelected)
         end
         magnumButton = display.newImageRect( "images/towerButtons/magnum_button.png", 50, 50)
         magnumButton.x = 448
         magnumButton.y = 100
         magnumButton:addEventListener( "tap", magnumButtonListener )
         levelGroup:insert( magnumButton )

         function ballchainButtonListener( event )	
            towerSelected = "ballchain"
            ballchainButton:setFillColor(255,255,255)
            ballchainButton.alpha = 0.7
            pistolButton.alpha = 1
            boomerangButton.alpha = 1
            magnumButton.alpha = 1
            print(towerSelected)
         end
         ballchainButton = display.newImageRect( "images/towerButtons/ballchain_button.png", 50, 50)
         ballchainButton.x = 448
         ballchainButton.y = 210
         ballchainButton:addEventListener( "tap", ballchainButtonListener )
         levelGroup:insert( ballchainButton )

         function boomerangButtonListener( event )	
            towerSelected = "boomerang"
            boomerangButton:setFillColor(255,255,255)
            boomerangButton.alpha = 0.7
            pistolButton.alpha = 1
            ballchainButton.alpha = 1
            magnumButton.alpha = 1
            print(towerSelected)
         end
         boomerangButton = display.newImageRect( "images/towerButtons/boomerang_button.png", 50, 50)
         boomerangButton.x = 448
         boomerangButton.y = 155
         boomerangButton:addEventListener( "tap", boomerangButtonListener )
         levelGroup:insert( boomerangButton )
      end
--------------------------------
-- End of Tower Functions     --
--------------------------------

	-------------------------
	-- Level Touched Function
	-------------------------
	local function levelTouched( event )	
		if event.phase == "ended" and gameIsActive then
			local touchTile = event.target
			local towerID = touchTile.towerID

			--Places a tower if we can
			if touchTile.towerOn == false then
				-- Boomerang Tower
				if towerSelected ==  "boomerang" and money >= (-1 * Towers.BoomerangTower.cost) then
                local tower = Towers.BoomerangTower:new(touchTile.x, touchTile.y, enemyGroup)
                table.insert(towerArray, towerID, tower)
				--Minus 50 from money
				changeText("money", Towers.BoomerangTower.cost)
				touchTile.towerOn = true 
				print(touchTile.x, touchTile.y, enemyGroup, towerArray, towerID, tower)
				-- Pistol Tower
				elseif towerSelected ==  "pistol" and money >= (-1 * Towers.PistolTower.cost) then
				local tower = Towers.PistolTower:new(touchTile.x, touchTile.y, enemyGroup)
                table.insert(towerArray, towerID, tower)
				--Minus 50 from money
				changeText("money", Towers.PistolTower.cost)
				touchTile.towerOn = true 
				-- Powershot Tower
				elseif towerSelected ==  "magnum" and money >= (-1 * Towers.MagnumTower.cost) then
				local tower = Towers.MagnumTower:new(touchTile.x, touchTile.y, enemyGroup)
                table.insert(towerArray, towerID, tower)
				--Minus 50 from money
				changeText("money", Towers.MagnumTower.cost)
				touchTile.towerOn = true 
				-- Rocket Tower
				elseif towerSelected ==  "rocket" and money >= (-1 * Towers.RocketTower.cost) then
				local tower = Towers.RocketTower:new(touchTile.x, touchTile.y, enemyGroup)
                table.insert(towerArray, towerID, tower)
				--Minus 50 from money
				changeText("money", Towers.RocketTower.cost)
				touchTile.towerOn = true
				-- Shotgun Tower
				elseif towerSelected ==  "shotgun" and money >= (-1 * Towers.ShotgunTower.cost) then
				local tower = Towers.ShotgunTower:new(touchTile.x, touchTile.y, enemyGroup)
                table.insert(towerArray, towerID, tower)
				--Minus 50 from money
				changeText("money", Towers.ShotgunTower.cost)
				touchTile.towerOn = true 
				elseif towerSelected ==  "ballchain" and money >= (-1 * Towers.BallChainTower.cost) then
				local tower = Towers.BallChainTower:new(touchTile.x, touchTile.y, enemyGroup)
                table.insert(towerArray, towerID, tower)
				--Minus 50 from money
				changeText("money", Towers.BallChainTower.cost)
				touchTile.towerOn = true 
				end
			elseif touchTile.towerOn == true then
				--Removes tower and add 40 money
				changeText("money", towerArray[towerID]:sell())
				towerArray[towerID] = nil
				touchTile.towerOn = false
			end
		end	
		return true
	end
    
	------------------
	-- Tower Game Loop
	------------------
    local TowerGameLoop = function(event)
		if(gameIsActive) then
		if enemyGroup.numChildren == nil then
			enemyGroup.numChildren = 0
		end
			for i=1, enemyGroup.numChildren do
				local enemy = enemyGroup[i]
				for k,v in pairs(towerArray) do
					if (v ~= nil) then
						v:attack(enemy)
					end
				end
			end
		end
    end
	Runtime:addEventListener( "enterFrame", TowerGameLoop )  
   
	-----------------------
	-- Level Setup Function
	-----------------------
	local function levelSetup()
		audio.play(Sounds.chargeFX, {channel = audio.findFreeChannel()})
		audio.play(Sounds.gameMusic, {loops=-1, channel=Sounds.bgChannel})
		--Create the level based off the array..
		local i
		for i=1, #tileArray do
			local placementAllowed = false
			local groundImage
			local xPos, yPos
			local numMoveArray = #moveArray

			--Sort out placeable areas etc...
			if tileArray[i] == 0 then 
				groundImage = "images/grass.png" 
				placementAllowed = true
			elseif tileArray[i] == 1 then
				groundImage = "images/floor.png" 
			elseif tileArray[i] == 2 then 
				groundImage = "images/water_01.png" 
			else
				local j
				for j=1, numMoveArray do
					if moveArray[j][2] == i then
						groundImage = moveArray[j][3];
					end
				end
			end

			--Now create the level rectangle...
			levelRects[i] = display.newImageRect(groundImage,32,32)
			if i <= 10 then xPos = 16+(32*(i)); yPos = 16
			elseif i <= 20 then xPos = 16+(32*(i-10)); yPos = 16+(32 * 1)
			elseif i <= 30 then xPos = 16+(32*(i-20)); yPos = 16+(32 * 2)
			elseif i <= 40 then xPos = 16+(32*(i-30)); yPos = 16+(32 * 3)
			elseif i <= 50 then xPos = 16+(32*(i-40)); yPos = 16+(32 * 4)
			elseif i <= 60 then xPos = 16+(32*(i-50)); yPos = 16+(32 * 5)
			elseif i <= 70 then xPos = 16+(32*(i-60)); yPos = 16+(32 * 6)
			elseif i <= 80 then xPos = 16+(32*(i-70)); yPos = 16+(32 * 7)
			elseif i <= 90 then xPos = 16+(32*(i-80)); yPos = 16+(32 * 8)
			else xPos = 16+(32*(i-90)); yPos = 16+(32 * 9)
			end
         levelRects[i].x = xPos; levelRects[i].y = yPos
			levelGroup:insert(levelRects[i])
			--If its the ep (end point) add a physics object to it.
			if tileArray[i] == "ep" then
				levelRects[i].type = "ep"; 
				physics.addBody(levelRects[i], { isSensor = true } )
			end

			--If placement is alowed we create a touch listner for it.
			if placementAllowed == true then 
				levelRects[i].towerOn = false
				levelRects[i].towerID = i
				levelRects[i]:addEventListener("touch", levelTouched)
			end
		end

		--Text items for score etc..
		scoreText	= display.newText("Score: "..score, 0,0, "Helvetica", 10)
		--scoreText:setReferencePoint(display.CenterLeftReferencePoint)
		scoreText.x = _W-32; scoreText.y = _H-40; overlayGroup:insert(scoreText)

		moneyText = display.newText("Money: "..money, 0,0, "Helvetica", 10)
		--moneyText:setReferencePoint(display.CenterReferencePoint)
		moneyText.x = _W-32; moneyText.y = _H-25; overlayGroup:insert(moneyText)

		healthText = display.newText("Health: "..health, 0,0, "Helvetica", 10)
		--healthText:setReferencePoint(display.CenterLeftReferencePoint)
		healthText.x = _W-32; healthText.y = _H-10; overlayGroup:insert(healthText)
	end
	levelSetup()
		
	---------------------
	-- End Game Functions
	---------------------
	--Game Over Function (Lose)
	local function gameOver()
		audio.stop(Sounds.bgChannel)
		gameIsActive = false
		timer.cancel(attackSpeedTimerUpdater)
		print("game ded remove tower")
      for k,v in pairs(towerArray) do
			print(k, v)
			v:destroy()
			levelRects[k].towerOn = false
			table.remove(towerArray, k)
			v = nil
		end
		
		storyboard.gotoScene( "menus_screens.lose"..currentLevel )

		--local function restartGame( event )
			--if event.phase == "ended" then
				--storyboard.gotoScene("gameInfo")
			--end
			--return true
		--end
		--Show game over text and restart text.
		--local gameOverText = display.newText("Ohuh! You died!", 0,0, "Helvetica", 18)
		--gameOverText.x = _W*0.5; gameOverText.y = _H*0.35; overlayGroup:insert(gameOverText)

		--local gameOverScore = display.newText("With a score of "..score, 0,0, "Helvetica", 18)
		--gameOverScore.x = _W*0.5; gameOverScore.y = gameOverText.y + 30; overlayGroup:insert(gameOverScore)

		--local tryAgainText = display.newText("Click me to try again!", 0,0, "Helvetica", 18)
		--tryAgainText.x = _W*0.5; tryAgainText.y = gameOverScore.y + 50; overlayGroup:insert(tryAgainText)
		--tryAgainText:addEventListener("touch", restartGame)
	end

	-- Level Complete Function (Win)
	local function levelComplete()
		audio.stop(Sounds.bgChannel)
		--local function restartGame( event )
			--if event.phase == "ended" then
				--Limited it here to 3 so that it wont crash.. 
				--Make more levels and remove this limiter!
				--if currentLevel < 3 then
					--currentLevel = currentLevel + 1
				--end
				--clean()
				--storyboard.gotoScene("gameInfo")
			--end
			--return true
		--end
		
		for k,v in pairs(towerArray) do
			print(k, v)
			v:destroy()
			levelRects[k].towerOn = false
			table.remove(towerArray, k)
			v = nil
		end
		
		duration = duration + ( os.time() - startTime )
		
		local completeOptions = {
			params = {
				currentLevel = currentLevel,
				score = math.floor(score * (1 + money / 1000)),
				duration = duration,
				finishDate = os.date()
			}
		}
		
		--print("duration = " .. duration)
		storyboard.gotoScene( "menus_screens.complete"..currentLevel, completeOptions )
		
	end

	-----------------------
	-- Main Level Functions
	-----------------------
	-- Spawn Enemy Function
	local function spawnEnemy()
		local enemy = display.newImageRect("images/enemy1_2.png",24,24)
		enemy.x = levelRects[moveArray[1][2]].x-32;
		enemy.y = levelRects[moveArray[1][2]].y;
		enemy.type = "enemy"; enemy.health = enemyHealth; enemy.maxHealth = enemyHealth;
		enemy.movPoint = "p1" --Used in the gameloop
		physics.addBody(enemy, { isSensor = true } )

		enemy.healthBar1 = display.newRect(0,0,20,3)
		enemy.healthBar1.x = enemy.x; enemy.healthBar1.y = enemy.y -12; 
		enemy.healthBar1:setFillColor(0,255,0)
		
		overlayGroup:insert(enemy.healthBar1)
		enemyGroup:insert(enemy)
	end

	-- Change Text Function
	function changeText( type, amount )
		if type == "health" then 
			health = health - 10; healthText.text = "Health: "..health
			--healthText:setReferencePoint(display.CenterLeftReferencePoint)
			--healthText.x = _W*0.81;
			if health <= 0 then gameOver() end
		elseif type == "score" then
			score = score + amount
			scoreText.text = "Score: "..score; 
			--scoreText:setReferencePoint(display.CenterLeftReferencePoint)
			--scoreText.x = 10;
		elseif type == "money" then
			money = money + amount
			moneyText.text = "Money: "..money; 
			--moneyText:setReferencePoint(display.CenterReferencePoint)
			--moneyText.x = _W*0.48;
		end
	end

	-- Game Loop Enemy Check Function
	local function gameLoopEnemyCheck( movPoint )
		local transDirecX, transDirecY, rect, nextPoint, rotate

		local function getDirect( moveArray )
			local direc = moveArray
			if direc == "right" then transDirecX = 1; transDirecY = 0; rotate = 0
			elseif direc == "left" then transDirecX = -1; transDirecY = 0; rotate = -180
			elseif direc == "up" then transDirecX = 0; transDirecY = -1; rotate = -90
			elseif direc == "down" then transDirecX = 0; transDirecY = 1; rotate = 90; end
		end

		local i
		for i=1, #moveArray-1 do
			if movPoint == "p"..i then 
				rect = levelRects[moveArray[i+1][2]] 
				getDirect(moveArray[i][1])
				nextPoint = "p"..i+1
			elseif movPoint == "ep" then 
				rect = levelRects[moveArray[i+1][2]] 
				getDirect(moveArray[i][1])
				nextPoint = "ep"
			end
		end

		return transDirecX, transDirecY, rect, nextPoint, rotate
	end

	--Game Loop Function
	local endCheckAmount = 0
	local function gameLoop(event)
		if gameIsActive == true then
			--Increase the int until it spawns an enemy..
			spawnInt = spawnInt + 1
			if spawnInt == 40 and spawned ~= spawnedMax then 
				spawnEnemy()
				spawnInt = 0
				spawned = spawned + 1

				if spawned == spawnedMax then
					print("GAME SHOULD BE ENDING SOON")
				end
			end	

			--Move enemies along the path..
			--Need to check each point each enemy has made it to.
			local i
			local enemyActive = false
			for i = enemyGroup.numChildren,1,-1 do
				local enemy = enemyGroup[i]
				if enemy ~= nil and enemy.x ~= nil then

					local transDirecX, transDirecY, rect, nextPoint, rotate = gameLoopEnemyCheck(enemy.movPoint)
					enemy:translate( transDirecX, transDirecY)
					enemy.healthBar1:translate( transDirecX, transDirecY)
					enemy.rotation = rotate

					if rect.x == mRound(enemy.x) and rect.y == mRound(enemy.y) then 
						enemy.movPoint = nextPoint 
					end
					enemyActive = true
					endCheckAmount = 0
				end
			end	

			--Using endCheckAmount and enemyActive
			--to finish the game.. checks each frame.
			if enemyActive == false then
				endCheckAmount = endCheckAmount + 1
				if endCheckAmount == 100 then
					print("Amount has maxed, ending the game")
					local timer = timer.performWithDelay(250, levelComplete, 1) 
				end
			end
		end
	end

	-- On Collision Function
	local function onCollision(event)
		if (event.object1 == nil or event.object2 == nil) then
			return
		end
		if event.phase == "began" and gameIsActive == true then
			--Destory the enemy if it is hit...
			if event.object1 ~= nil and event.object1.type == "enemy" and event.object2.type == "ep" or event.object1 ~= nil and event.object1.type == "ep" and event.object2.type == "enemy" then
				if event.object1.type == "enemy" then 
					display.remove(event.object1.healthBar1)
					event.object1.healthBar1 = nil
					display.remove(event.object1)
					event.object1 = nil
				else 
					display.remove(event.object2.healthBar1)
					event.object2.healthBar1 = nil
					display.remove(event.object2)
					event.object2 = nil
				end

				--Increase the score if we kill and enemy..
            audio.play(Sounds.explosionFX, {channel = audio.findFreeChannel()})
				changeText("health")
			end

			--Destory the enemy if it is hit...
			if event.object1 ~= nil and event.object1.type == "enemy" and event.object2.type == "attack" or event.object1 ~= nil and event.object1.type == "attack" and event.object2.type == "enemy" then
				if event.object1.type == "enemy" then 
               if (event.object2.singleTarget == true and event.object2.target ~= event.object1) then return end
					event.object1.health = event.object1.health - event.object2.dmg
					if event.object1.health <= 0 then
                  changeText("money", (.2 * event.object1.maxHealth))
                  changeText("score", event.object1.maxHealth)
						display.remove(event.object1.healthBar1)
						event.object1.healthBar1 = nil
						display.remove(event.object1)
						event.object1 = nil
					else
						local healthScale = event.object1.health/enemyHealth
						event.object1.healthBar1.xScale = healthScale
					end
				else 
               if (event.object1.singleTarget == true and event.object1.target ~= event.object2) then return end
					event.object2.health = event.object2.health - event.object1.dmg
					if event.object2.health <= 0 then
                  changeText("money", .2 * event.object2.maxHealth)
                  changeText("score", event.object2.maxHealth)
						display.remove(event.object2.healthBar1)
						event.object2.healthBar1 = nil
						display.remove(event.object2)
						event.object2 = nil
					else
						local healthScale = event.object2.health/enemyHealth
						event.object2.healthBar1.xScale = healthScale
					end
				end
			end
		end	
	end

	-- Event Listeners
	Runtime:addEventListener( "enterFrame", gameLoop )
	Runtime:addEventListener( "collision", onCollision )

	-----------------
	-- Clean Function
	-----------------
	function clean()
		Runtime:removeEventListener( "enterFrame", gameLoop )
		Runtime:removeEventListener( "collision", onCollision )

		--Clean timers and transitions..
		--We use "pairs" as there will be gaps
		--in those arrays. Iterating over them
		--normally wouldnt remove them.
		local k,v
		for k,v in pairs(towerTimers) do
			timer.cancel(towerTimers[k])
			towerTimers[k] = nil
		end
		for k,v in pairs(towerTrans) do
			transition.cancel(towerTrans[k])
			towerTrans[k] = nil
		end
	end
	return localGroup
end


function scene:overlayEnded( event )
	gameIsActive = true
	timer.resume(attackSpeedTimerUpdater)
	startTime = os.time()
end


function scene:destroyScene( event )
	for k,v in pairs(towerArray) do
		print(k, v)
		v:destroy()
		levelRects[k].towerOn = false
		table.remove(towerArray, k)
		v = nil
	end
end


-- Scene Event Listeners
scene:addEventListener( "createScene" )
scene:addEventListener( "overlayEnded" )
scene:addEventListener( "destroyScene" )

-- Return Statement
return scene
