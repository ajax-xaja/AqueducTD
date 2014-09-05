------------------------------------------
-- Created by Dylan Gustaveson          --
------------------------------------------

require 'middleclass'
local Tower = require 'towers.Tower'
local RocketAttack = require 'attacks.RocketAttack'

local RocketTower = class('RocketTower', Tower)

   RocketTower.attackSpeed = 60
   RocketTower.range = 160
   RocketTower.cost = - 40
   local _spriteSheetOptions = sprite.newSpriteSheet("images/towers/rocket_tower.png", 32, 32)
   RocketTower.spriteSheet = sprite.newSpriteSet(_spriteSheetOptions, 1, 2)
   
   --constructor
   function RocketTower:initialize(x, y)
      self.displaySprite = sprite.newSprite(RocketTower.spriteSheet)
      self.displaySprite.currentFrame = 1   
      self.towerType = "rocket"
      Tower.initialize(self, x, y)
      end
      
   function RocketTower:attack(target)
      if self:isTargetInRange(target) and self:canAttack() then
         audio.play(Sounds.rocketFireFX, {channel = audio.findFreeChannel()})
         self:turnToTarget(target)
         local atk = RocketAttack:new(self, target)
         self.timeOfLastAttack = attackSpeedTimer
         end
      end
      
return RocketTower