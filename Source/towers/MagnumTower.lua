------------------------------------------
-- Created by Dylan Gustaveson          --
------------------------------------------

require 'middleclass'
local Tower = require 'towers.Tower'
local MagnumAttack = require 'attacks.MagnumAttack'

local MagnumTower = class('MagnumTower', Tower)

   MagnumTower.attackSpeed = 40
   MagnumTower.range = 96
   MagnumTower.cost = -10
   local _spriteSheetOptions = sprite.newSpriteSheet("images/towers/magnum_tower.png", 32, 32)
   MagnumTower.spriteSheet = sprite.newSpriteSet(_spriteSheetOptions, 1, 2)
   
   --constructor
   function MagnumTower:initialize(x, y)
      self.displaySprite = sprite.newSprite(MagnumTower.spriteSheet)
      self.displaySprite.currentFrame = 1   
      self.towerType = 'magnum'
      Tower.initialize(self, x, y)
      end
      
   function MagnumTower:attack(target)
      if self:isTargetInRange(target) and self:canAttack() then
         audio.play(Sounds.magnumFireFX, {channel = audio.findFreeChannel()})
         self:turnToTarget(target)
         local theta = Tower.angleToTarget(self, target)
         local deltaX = (self.range) * math.cos(theta)
         local deltaY = (self.range) * math.sin(theta)
         local endTarget = {}
         endTarget.x = self.x + deltaX
         endTarget.y = self.y + deltaY
         local atk = MagnumAttack:new(self, endTarget)
         self.timeOfLastAttack = attackSpeedTimer
         end
      end
      
return MagnumTower