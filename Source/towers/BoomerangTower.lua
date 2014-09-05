------------------------------------------
-- Created by Dylan Gustaveson          --
------------------------------------------

require 'middleclass'
local Tower = require 'towers.Tower'
local BoomerangAttack = require 'attacks.BoomerangAttack'

local BoomerangTower = class('BoomerangTower', Tower)

   BoomerangTower.attackSpeed = 40
   BoomerangTower.range = 96
   BoomerangTower.cost = -25
   local _spriteSheetOptions = sprite.newSpriteSheet("images/towers/boomerang_tower.png", 32, 32)
   BoomerangTower.spriteSheet = sprite.newSpriteSet(_spriteSheetOptions, 1, 2)
   
   --constructor
   function BoomerangTower:initialize(x, y, enemyGroup)
      self.displaySprite = sprite.newSprite(BoomerangTower.spriteSheet)
      self.displaySprite.currentFrame = 1   
      self.enemyGroup = enemyGroup
      self.towerType = "boomerang"
      Tower.initialize(self, x, y)
      end
      
   function BoomerangTower:attack(target, enemyGroup)
      if self:isTargetInRange(target) and self:canAttack() then
         audio.play(Sounds.boomerangFireFX, {channel = audio.findFreeChannel()})
         self:turnToTarget(target)
         local atk = BoomerangAttack:new(self, target, self.enemyGroup)
         self.timeOfLastAttack = attackSpeedTimer
         end
      end
      
return BoomerangTower