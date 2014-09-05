------------------------------------------
-- Created by Dylan Gustaveson          --
------------------------------------------

require 'middleclass'
local Attack = require 'attacks.Attack'

local BoomerangAttack = class('BoomerangAttack', Attack)

   --constructor
   function BoomerangAttack:initialize(origin, target, enemyGroup)
      self = display.newImageRect('images/attacks/boomerang.png', 8, 9)
      self:setFillColor( 0, 255, 0 )
      self.singleTarget = true
      self.dmg = 12
      self.lastTarget = target
      self.bouncesMade = 0
      self.bounces = 3
      self.bounceRange = 40
      self.enemiesHit = {}
      Attack.initialize(self, origin, target)
      self.enemyGroup = enemyGroup
      self.rotationTimer = timer.performWithDelay(18,
                                                   function()
                                                      self.rotation = self.rotation + 36
                                                   end,
                                                   0)
      BoomerangAttack.attackTarget(self)
      end

   function BoomerangAttack.attackTarget(attack)
      local d = Attack.get_distance(attack, attack.target)
      local bt = d * (1000 / 400)
      attack.enemiesHit[attack.lastTarget] = true
      attack.transition = transition.to( attack, {y=attack.target.y, x=attack.target.x, time=bt, onComplete=BoomerangAttack.bounce} )
      end
      
   function BoomerangAttack.bounce(attack)
      if (attack.bounces > attack.bouncesMade) then
         attack.bouncesMade = attack.bouncesMade + 1
         for i=1, attack.enemyGroup.numChildren do
            local enemy = attack.enemyGroup[i]
            if (attack.enemiesHit[enemy] ~= true) then
               if (Attack.get_distance(attack, enemy) <= attack.bounceRange) then
                  attack.lastTarget = attack.target
                  attack.target = enemy
                  BoomerangAttack.attackTarget(attack)
                  return
                  end
               end
            end 
         end
      BoomerangAttack.remove_attack(attack)
      end
      
   function BoomerangAttack.remove_attack(attack)
      transition.cancel(attack.transition)
      timer.cancel(attack.rotationTimer)
      attack:removeSelf();
      attack = nil
      end
   
return BoomerangAttack