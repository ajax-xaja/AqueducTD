------------------------------------------
-- Created by Dylan Gustaveson          --
------------------------------------------

require 'middleclass'
local sprite = require 'sprite'
local Tower = require 'towers.Tower'
local ShotgunAttack = require 'attacks.ShotgunAttack'

local ShotgunTower = class('ShotgunTower', Tower)

   ShotgunTower.attackSpeed = 55
   ShotgunTower.range = 64
   ShotgunTower.cost = - 15
   local _spriteSheetOptions = sprite.newSpriteSheet("images/towers/shotgun_tower.png", 32, 32)
   ShotgunTower.spriteSheet = sprite.newSpriteSet(_spriteSheetOptions, 1, 2)

   --constructor
   function ShotgunTower:initialize(x, y, enemyGroup)
      self.displaySprite = sprite.newSprite(ShotgunTower.spriteSheet)
      self.displaySprite.currentFrame = 1   
      self.maxTargettedEnemies = 3
      self.enemyGroup = enemyGroup
      self.towerType = "shotgun"
      Tower.initialize(self, x, y)
      end  
      
   function ShotgunTower:attack(target)
      self.targetedEnemies = {}
      self.targetedEnemiesCount = 0
      if self:isTargetInRange(target) and self:canAttack() then
         self.displaySprite.currentFrame = 2
         self.targetedEnemies[target] = true
         self.targetedEnemiesCount = self.targetedEnemiesCount + 1
         local atk = ShotgunAttack:new(self, target)
         self:turnToTarget(target)
         for i=1, self.enemyGroup.numChildren do
            local enemy = self.enemyGroup[i]
            if ((self.targetedEnemiesCount < self.maxTargettedEnemies) and self.targetedEnemies[enemy] ~= true) then
               if (ShotgunAttack.get_distance(self, enemy) <= self.range) then
                  local atk = ShotgunAttack:new(self, enemy)
                  self.targetedEnemies[enemy] = true
                  self.targetedEnemiesCount = self.targetedEnemiesCount + 1
                  end
               end
            end
         audio.play(Sounds.shotgunFireFX, {channel = audio.findFreeChannel()})
         self.timeOfLastAttack = attackSpeedTimer
         end
      end
      
return ShotgunTower