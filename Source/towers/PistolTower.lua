------------------------------------------
-- Created by Dylan Gustaveson          --
------------------------------------------

require 'middleclass'
local Tower = require 'towers.Tower'
local PistolAttack = require 'attacks.PistolAttack'

local PistolTower = class('PistolTower', Tower)

   PistolTower.attackSpeed = 20
   PistolTower.range = 96
   PistolTower.cost = - 5
   local _spriteSheetOptions = sprite.newSpriteSheet("images/towers/pistol_tower.png", 32, 32)
   PistolTower.spriteSheet = sprite.newSpriteSet(_spriteSheetOptions, 1, 2)

   --constructor
   function PistolTower:initialize(x, y)
      self.displaySprite = sprite.newSprite(PistolTower.spriteSheet)
      self.displaySprite.currentFrame = 1   
      self.towerType = "pistol"
      Tower.initialize(self, x, y)
      end
      
   function PistolTower:attack(target)
      if self:isTargetInRange(target) and self:canAttack() then
         audio.play(Sounds.pistolFireFX, {channel = audio.findFreeChannel()})
         self:turnToTarget(target)
         local atk = PistolAttack:new(self, target)
         self.timeOfLastAttack = attackSpeedTimer
         end
      end
      
return PistolTower