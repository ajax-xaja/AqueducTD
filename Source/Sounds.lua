------------------------------------------
-- Created by Dylan Gustaveson          --
------------------------------------------

local Sounds = {}
   
   audio.reserveChannels(3)
   
   Sounds.bgChannel = 1
   Sounds.miscChannel = 2
   
   --background sounds
   Sounds.menuMusic = audio.loadSound("sounds/background/menu.mp3")
   Sounds.creditMusic = audio.loadSound("sounds/background/credit.mp3")
   Sounds.gameMusic = audio.loadSound("sounds/background/game.mp3")
   
   --game fx
   Sounds.chargeFX = audio.loadSound("sounds/gamefx/charge.mp3")
   Sounds.explosionFX = audio.loadSound("sounds/gamefx/explosion.mp3")
   
   --attack fx
   Sounds.pistolFireFX = audio.loadSound("sounds/attackfx/pistol_fire.mp3")
   Sounds.ballchainFireFX = audio.loadSound("sounds/attackfx/ballchain_fire.mp3")
   Sounds.shotgunFireFX = audio.loadSound("sounds/attackfx/shotgun_fire.mp3")
   Sounds.rocketFireFX = audio.loadSound("sounds/attackfx/rocket_fire.mp3")
   Sounds.magnumFireFX = audio.loadSound("sounds/attackfx/magnum_fire.mp3")
   Sounds.boomerangFireFX = audio.loadSound("sounds/attackfx/boomerang_fire.mp3")
   
   Sounds.rocketExplosionFX = audio.loadSound("sounds/attackfx/rocket_explosion.mp3")
   
   
   --ui fx
   Sounds.clickFX = audio.loadSound("sounds/uifx/click.mp3")

   function Sounds.disposeSound(sound)
      audio.stop(sound)
      audio.dispose(sound)
      sound = nil
      end
   
return Sounds