------------------------------------------
-- Created by Dylan Gustaveson          --
------------------------------------------

require 'middleclass'
local Attack = require 'attacks.Attack'

local MagnumAttack = class('MagnumAttack', Attack)

   --constructor
   function MagnumAttack:initialize(origin, target)
      self = display.newCircle( 0, 0, 3 )
      self:setFillColor( 0, 0, 0 )
      self.singleTarget = false
      self.dmg = 6
      Attack.initialize(self, origin, target)
      MagnumAttack.attackTarget(self)
      end
      
   function MagnumAttack.attackTarget(attack)
      local d = Attack.get_distance(attack, attack.target)  --Get the distance to the target
      local bt = d * (1000 / 400)
      attack.transition = transition.to( attack, {y=attack.target.y, x=attack.target.x, time=bt, onComplete=Attack.remove_attack} )
      end
      
return MagnumAttack