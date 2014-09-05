------------------------------------------
-- Created by Dylan Gustaveson          --
------------------------------------------

require 'middleclass'
local Tower = require 'towers.Tower'
local BallChainAttack = require 'attacks.BallChainAttack'

local BallChainTower = class('BallChainTower', Tower)

   BallChainTower.attackSpeed = 70
   BallChainTower.range = 64
   BallChainTower.cost = - 30
   local _spriteSheetOptions = sprite.newSpriteSheet("images/towers/ballchain_tower.png", 32, 32)
   BallChainTower.spriteSheet = sprite.newSpriteSet(_spriteSheetOptions, 1, 2)
   
   --constructor
   function BallChainTower:initialize(x, y, attackSpeedTimer)
      self.displaySprite = sprite.newSprite(BallChainTower.spriteSheet)
      self.displaySprite.currentFrame = 1   
      self.towerType = "ballchain"
      Tower.initialize(self, x, y, attackSpeedTimer)
      end
      
   function BallChainTower:attack(target)
      if self:isTargetInRange(target) and self:canAttack() then
         self:turnToTarget(target)
         local theta = Tower.angleToTarget(self, target)
         local deltaX = (self.range) * math.cos(theta)
         local deltaY = (self.range) * math.sin(theta)
         local endTarget = {}
         endTarget.x = self.x + deltaX
         endTarget.y = self.y + deltaY
         audio.play(Sounds.ballchainFireFX, {channel = audio.findFreeChannel()})
         local atk = BallChainAttack:new(self, endTarget)
         self.timeOfLastAttack = attackSpeedTimer
         end
      end
      
return BallChainTower