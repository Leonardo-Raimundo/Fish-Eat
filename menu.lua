local composer = require( "composer" )

local scene = composer.newScene()

local function gotoGame()
	composer.gotoScene ("game", {time=800, effect="crossFade"})
end

local function gotoRecords()
	composer.gotoScene ("records", {time=800, effect="crossFade"})
end

function scene:create(event)
	local sceneGroup = self.view

	local bg = display.newImageRect(sceneGroup,"imagens/bg-menu.jpg", 740, 493)
	bg.x=display.contentCenterX
	bg.y=display.contentCenterY

	local title = display.newImageRect(sceneGroup,"imagens/logo.png", 666/1.5, 375/1.5)
	title.x=display.contentCenterX +10
	title.y= 90

	local placaMenu = display.newImageRect(sceneGroup, "imagens/placa-menu.png", 269, 117)
	placaMenu.x = display.contentCenterX
	placaMenu.y = 195

	local buttonPlay = display.newText(sceneGroup,"Play", display.contentCenterX, 200, "fonts/Tangerine-Bold.ttf", 45)
	buttonPlay:setFillColor (1, 1, 1)

	local placaMenu2 = display.newImageRect(sceneGroup, "imagens/placa-menu.png", 269, 117)
	placaMenu2.x = display.contentCenterX
	placaMenu2.y = 280

	local buttonRecords = display.newText (sceneGroup, "Records", display.contentCenterX, 280, "fonts/Tangerine-Bold.ttf", 43)
	buttonRecords:setFillColor (1, 1, 1)

	buttonPlay:addEventListener("tap", gotoGame)
	buttonRecords:addEventListener("tap", gotoRecords)

	menuSound = audio.loadStream("audio/menuSound.wav")
end

function scene:show(event)
	audio.play(menuSound, {channel=4, loops=-1})
	local sceneGroup = self.view
	local phase = event.phase

	if(phase == "will") then

	elseif(phase == "did") then
	end
end

function scene:hide(event)
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
	elseif ( phase == "did" ) then
	audio.stop(4)
	end
end

function scene:destroy(event)

	local sceneGroup = self.view
	audio.dispose(menuSound)
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene