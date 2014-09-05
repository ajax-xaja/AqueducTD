------------------------------------------
-- Created by Dylan Gustaveson          --
------------------------------------------

require 'middleclass'

local Attack = class('Attack')

   --constructor
   function Attack:initialize(origin, target)
      self.type = 'attack'
      self.origin = origin
      self.target = target
      self.x = self.origin.x
      self.y = self.origin.y
      physics.addBody(self, {isSensor=true})
      end
      
   function Attack.get_distance( p1, p2 )
      local dx = p1.x - p2.x
      local dy = p1.y - p2.y
      return math.sqrt( (dx*dx) + (dy*dy) ) -- Return the distance
      end

   function Attack.attackTarget(attack)
      local d = Attack.get_distance(attack, attack.target)  --Get the distance to the target
      local bt = d * (1000 / 400)
      attack.transition = transition.to( attack, {y=attack.target.y, x=attack.target.x, time=bt, onComplete=Attack.remove_attack} )
      end

   function Attack.remove_attack(attack)
      transition.cancel(attack.transition)
      attack:removeSelf();
      attack = nil
      end
   
return Attack