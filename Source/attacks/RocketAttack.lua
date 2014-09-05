------------------------------------------
-- Created by Dylan Gustaveson          --
------------------------------------------

require 'middleclass'
local Attack = require 'attacks.Attack'

local RocketAttack = class('RocketAttack', Attack)

   --constructor
   function RocketAttack:initialize(origin, target)
      self = display.newImageRect('images/attacks/rocket.png', 6, 9)
      self:setFillColor( 255, 255, 255 )
      self.singleTarget = true
      self.dmg = 10
      self.splashSize = 32
      self.splashPercentDamage = .2
      Attack.initialize(self, origin, target)
      self.rotation = math.atan2(target.y - origin.y, target.x - origin.x) * 180/math.pi + 90
      RocketAttack.attackTarget(self)
      end
      
   function RocketAttack.attackTarget(attack)
      local d = Attack.get_distance(attack, attack.target)  --Get the distance to the target
      local bt = d * (1000 / 350)
      attack.transition = transition.to( attack, {y=attack.target.y, x=attack.target.x, time=bt, onComplete=RocketAttack.splash_attack} )
      end
      
   function RocketAttack.splash_attack(attack)
      local splash = display.newCircle(0, 0, attack.splashSize)
      splash:setFillColor(255, 63, 52, 90)
      splash.x = attack.x
      splash.y = attack.y
      splash.dmg = attack.dmg * attack.splashPercentDamage
      splash.singleTarget = false
      Attack.remove_attack(attack)
      Attack.initialize(splash, splash, splash)
      audio.play(Sounds.rocketExplosionFX, {channel = audio.findFreeChannel()})
      splash.transition = transition.to(splash, {x = splash.x, y = splash.y, time = 10, onComplete=Attack.remove_attack})
      end
   
return RocketAttack