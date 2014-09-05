------------------------------------------
-- Created by Dylan Gustaveson          --
------------------------------------------

require 'middleclass'
local Attack = require 'attacks.Attack'

local ShotgunAttack = class('ShotgunAttack', Attack)

   --constructor
   function ShotgunAttack:initialize(origin, target)
      self = display.newCircle( 0, 0, 3 )
      self:setFillColor( 255, 0, 0 )
      self.singleTarget = true
      self.dmg = 6
      Attack.initialize(self, origin, target)
      ShotgunAttack.attackTarget(self)
      end
      
return ShotgunAttack