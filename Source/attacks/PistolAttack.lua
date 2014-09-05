------------------------------------------
-- Created by Dylan Gustaveson          --
------------------------------------------

require 'middleclass'
local Attack = require 'attacks.Attack'

local PistolAttack = class('PistolAttack', Attack)

   --constructor
   function PistolAttack:initialize(origin, target)
      self = display.newCircle( 0, 0, 3 )
      self:setFillColor( 0, 0, 0 )
      self.singleTarget = true
      self.dmg = 4
      Attack.initialize(self, origin, target)
      PistolAttack.attackTarget(self)
      end
      
return PistolAttack