------------------------------------------
-- Created by Dylan Gustaveson          --
------------------------------------------

require 'middleclass'

Sounds = require 'Sounds'
local sprite = require 'sprite'
local Tower = class('Tower')

local sell_percent = .60

   --constructor
   function Tower:initialize(x, y)
      self.x = x
      self.y = y
      self.displaySprite.x = x
      self.displaySprite.y = y
      self.timeOfLastAttack = -1 * 2^52
      self.timePaused = 0
      self.isSelected = false
      self.type = 'tower'
      self.upgradeLevel = 0
      end
      
   function Tower:destroy()
      display.remove(self.displaySprite)
      self = nil
      end
      
   function Tower:sell()
      display.remove(self.displaySprite)
      returnCost = -1* self.cost * sell_percent
      self = nil
      return returnCost
      end
      
   function Tower:turnToTarget(target)
      if (self:isFacingLeft(target)) then end
      end
    
    function Tower:isFacingLeft(target)
      if (self == nil or target == nil) then return end
      local theta = math.deg(self:angleToTarget(target))
      if (theta >= 90 or theta <= -90) then
         self.displaySprite.currentFrame = 1
      else
         self.displaySprite.currentFrame = 2
         end
      end
    
   function Tower:angleToTarget(target)
      if (target == nil) then return end
      return math.atan2((target.y - self.y), (target.x - self.x))
      end
    
   function Tower:canAttack()
      return ((self.timeOfLastAttack + self.attackSpeed) <= attackSpeedTimer)
      end
      
   function Tower:isTargetInRange(target)
      return self:get_distance(target) <= self.range
      end
      
   function Tower:cost()
      return -1 * self.cost;
      end

   function Tower:get_distance(target)
      local dx = self.x - target.x
      local dy = self.y -  target.y
      return math.sqrt( (dx*dx) + (dy*dy) ) -- Return the distance
      end
      
return Tower