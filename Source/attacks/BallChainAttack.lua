------------------------------------------
-- Created by Dylan Gustaveson          --
------------------------------------------

require 'middleclass'

local Attack = require 'attacks.Attack'

local BallChainAttack = class('BallChainAttack', Attack)

   --constructor
   function BallChainAttack:initialize(origin, target)
      self = display.newImageRect('images/attacks/ballchain_ball.png', 12, 12)
      self:setFillColor( 0, 0, 255 )
      self.singleTarget = false
      self.dmg = 20
      self.bounced = false;
      self.bouncedFrom_x = origin.x
      self.bouncedFrom_y = origin.y
      self.bounceTo_x = target.x
      self.bounceTo_y = target.y
      Attack.initialize(self, origin, target)
      BallChainAttack.attackTarget(self)
      end

   function BallChainAttack.attackTarget(attack)
      if (attack.target == nil) then return end
      local d = BallChainAttack.get_distance(attack.bouncedFrom_x, attack.bouncedFrom_y, attack.bounceTo_x, attack.bounceTo_y)  --Get the distance to the target
      local bt = d * (1000 / 400)
      attack.transition = transition.to( attack, {x=attack.bounceTo_x, y=attack.bounceTo_y, time=bt, onComplete=BallChainAttack.return_to_sender} )
      end
      
   function BallChainAttack.get_distance(x1, y1, x2, y2)
      local dx = x2 - x1
      local dy = y2 - y1
      return math.sqrt( (dx*dx) + (dy*dy) ) -- Return the distance
      end
      
   function BallChainAttack.return_to_sender(attack)
      transition.cancel(attack.transition)
      attack.bouncedFrom_x, attack.bouncedFrom_y, attack.bounceTo_x, attack.bounceTo_y = attack.bounceTo_x, attack.bounceTo_y, attack.bouncedFrom_x, attack.bouncedFrom_y 
      local d = BallChainAttack.get_distance(attack.bouncedFrom_x, attack.bouncedFrom_y, attack.bounceTo_x, attack.bounceTo_y)  --Get the distance to the target
      local bt = d * (1000 / 400)
      attack.transition = transition.to( attack, {x=attack.bounceTo_x, y=attack.bounceTo_y, time=bt, onComplete=Attack.remove_attack} )
      end
	
return BallChainAttack