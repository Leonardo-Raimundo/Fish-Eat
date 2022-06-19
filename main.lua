local composer = require("composer")

display.setStatusBar(display.HiddenStatusBar)

math.randomseed( os.time () )

composer.gotoScene( "menu" )

-- canal para som do menu recordes
audio.reserveChannels(1)
audio.setVolume(0.6, {channel=1})

-- canal para som de comer
audio.reserveChannels(2)
audio.setVolume(0.6, {channel=2})

-- canal para som de golpe
audio.reserveChannels(3)
audio.setVolume(0.6, {channel=3})

-- canal para som do menu
audio.reserveChannels(4)
audio.setVolume(0.3, {channel=4})

-- canal para som do jogo
audio.reserveChannels(5)
audio.setVolume(0.08, {channel=5})
