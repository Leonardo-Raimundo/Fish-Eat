
local composer = require( "composer" )
local scene = composer.newScene()
local physics = require ("physics") -- chama a física para o projeto.
physics.start () -- inicia a física.
physics.setGravity (0, 0) -- define a gravidade da física.

local backGroup 
local mainGroup 
local uiGroup

local tubarao
local pontos=0
local pontosText
local vidas=3
local vidasText
local morto = false
local gameLoopTimer
local gameLoopTimer2
local tubarao
local pontosEstrela
local vidasCoracao

local bgSound = audio.loadStream("audio/bgSound.wav")
local menuSound
local recordsSound
local eatSound = audio.loadSound("audio/comer.wav")
local hurtSound = audio.loadSound("audio/golpe.wav")



local function moverTubarao(event)
	local tubarao = event.target
	local phase = event.phase

	if("began"==phase) then
		display.currentStage:setFocus(tubarao)
		tubarao.touchOffsetX=event.x -tubarao.x
		tubarao.touchOffsetY=event.y -tubarao.y

	elseif("moved"==phase) then
		tubarao.x=event.x -tubarao.touchOffsetX
		tubarao.y=event.y -tubarao.touchOffsetY

	elseif("ended"==phase or "cancelled"==phase) then
		display.currentStage:setFocus(nil)
	end
	return true
end

local peixeTable={}
local lixoTable={}

local function criar_lixo1()
	local lata = display.newImageRect(mainGroup,"imagens/lata.png", 500/10, 500/10)
	physics.addBody(lata, "dynamic", {radius=20, bounce=0.5})
	lata.myName="Lata"
	table.insert(lixoTable, lata)

	local location = math.random (2)
		if(location == 1) then
			lata.x = 449
			lata.y = math.random(300)
			lata:setLinearVelocity(math.random (40, 120), math.random (20,60)) 
		
		elseif(location == 2) then
			lata.x = 449
			lata.y = math.random(300)
			lata:setLinearVelocity(math.random(-100, -80),0)
		end
		lata:applyTorque (math.random (1, 2))
end

local function criar_lixo2()
	local pet = display.newImageRect(mainGroup,"imagens/pet.png", 416/10, 416/10)
	physics.addBody(pet, "dynamic", {radius=20, bounce=0.5})
	pet.myName="Pet"
	table.insert(lixoTable, pet)

	local location = math.random (2)
		if(location == 1) then
			pet.x = 449
			pet.y = math.random(300)
			pet:setLinearVelocity(math.random (-200, -120), 0) 
		
		elseif(location == 2) then
			pet.x = 449
			pet.y = math.random(300)
			pet:setLinearVelocity(math.random(-100, -80),0)
		end
		pet:applyTorque (math.random (1, 2))
end

local function criar_lixo3()
	local lata2 = display.newImageRect(mainGroup,"imagens/lata2.png", 71/2, 96/2)
	physics.addBody(lata2, "dynamic", {radius=10, bounce=0.5})
	lata2.myName="Lata2"
	table.insert(lixoTable, lata2)

	local location = math.random (2)
		if(location == 1) then
			lata2.x = 449
			lata2.y = math.random(300)
			lata2:setLinearVelocity(math.random (-200, -120), 0) 
		
		elseif(location == 2) then
			lata2.x = 449
			lata2.y = math.random(300)
			lata2:setLinearVelocity(math.random(-100, -80),0)
		end
		-- lata2:applyTorque (1, 2)
end

local function criar_peixe1()
	local peixe1 = display.newImageRect(mainGroup,"imagens/peixe1.png", 122/3, 92/3)
	physics.addBody(peixe1, "dynamic", {radius=30, bounce=0.5})
	peixe1.myName="Peixe1"
	table.insert(peixeTable, peixe1)

	local location = math.random (2)
		if(location == 1) then
			peixe1.x = 449
			peixe1.y = math.random(300)
			peixe1:setLinearVelocity(math.random (-200, -120), 0) 
		
		elseif(location == 2) then
			peixe1.x = 449
			peixe1.y = math.random(300)
			peixe1:setLinearVelocity(math.random(-100, -80),0)
		end
end

local function criar_peixe2()
	local peixe2 = display.newImageRect(mainGroup,"imagens/peixe2.png", 122/2.5, 67/2.5)
	physics.addBody(peixe2, "dynamic", {radius=30, bounce=0.5})
	peixe2.myName="Peixe2"
	table.insert(peixeTable, peixe2)

	local location = math.random (2)
		if(location == 1) then
			peixe2.x = 449
			peixe2.y = math.random(300)
			peixe2:setLinearVelocity(math.random (-100, -80),0) 
		
		elseif(location == 2) then
			peixe2.x = 449
			peixe2.y = math.random(300)
			peixe2:setLinearVelocity(math.random(-200, -120), 0)
		end
end

local function criar_peixe3()
	local peixe3 = display.newImageRect(mainGroup,"imagens/peixe3.png", 122/2.5, 67/2.5)
	physics.addBody(peixe3, "dynamic", {radius=30, bounce=0.5})
	peixe3.myName="Peixe3"
	table.insert(peixeTable, peixe3)

	local location = math.random (2)
		if(location == 1) then
			peixe3.x = 449
			peixe3.y = math.random(300)
			peixe3:setLinearVelocity(math.random (-200, -120), 0) 
		
		elseif(location == 2) then
			peixe3.x = 449
			peixe3.y = math.random(300)
			peixe3:setLinearVelocity(math.random(-100, -80), 0)
		end
end

local function gameLoop()
	criar_peixe1()
	criar_peixe2()
	criar_peixe3()
	for i = #peixeTable, 1, - 1 do
		local thispeixe1 = peixeTable[i]
		local thispeixe2 = peixeTable[i]
		local thispeixe3 = peixeTable[i]

		if 	(thispeixe1.x < -100 or
			thispeixe2.x <-100 or
			thispeixe3.x <-100 or

			thispeixe1.x < -100 or
			thispeixe2.x < -100 or
			thispeixe3.x < -100 
			)
		then
			display.remove(thispeixe1)
			display.remove(thispeixe2)
			display.remove(thispeixe3)
			table.remove(peixeTable, i)
		end
	end
end

local function gameLoop2()
	criar_lixo1()
	criar_lixo2()
	criar_lixo3()
	for i = #lixoTable, 1, - 1 do
		local thislixo1 = lixoTable[i]
		local thislixo2 = lixoTable[i]
		local thislixo3 = lixoTable[i]

		if 	(thislixo1.x < -100 or
			thislixo2.x <-100 or
			thislixo3.x <-100 or

			thislixo1.x < -100 or
			thislixo2.x < -100 or
			thislixo3.x < -100 
			)
		then
			display.remove(thislixo1)
			display.remove(thislixo2)
			display.remove(thislixo3)
			table.remove(lixoTable, i)
		end
	end
end

local function restaurarTubarao()
	tubarao.isBodyActive = false
	tubarao.x = display.contentCenterX
	tubarao.y = display.contentHeight - 100

	transition.to(tubarao, {alpha=1, time=4000, 
		onComplete = function()
			tubarao.isBodyActive = true
			morto = false
	end
})
end

local function endGame()
	composer.setVariable("finalScore", pontos)
	composer.gotoScene("records", {time=800, effect="crossFade"})
end

local function onCollision(event)
	if(event.phase == "began") then
		local obj1 = event.object1
		local obj2 = event.object2

	if(((obj1.myName == "Tubarao" and obj2.myName == "Peixe1") or
			(obj1.myName == "Peixe1" and obj2.myName == "Tubarao"))
			
			or ((obj1.myName=="Tubarao" and obj2.myName=="Peixe2") or
			(obj1.myName=="Peixe2" and obj2.myName=="Tubarao"))
			
			or ((obj1.myName=="Tubarao" and obj2.myName=="Peixe3") or
			(obj1.myName=="Peixe3" and obj2.myName=="Tubarao")))
	then
		if(obj1.myName=="Peixe1" or obj1.myName=="Peixe2" or obj1.myName=="Peixe3") 
			then
				display.remove(obj1)
				audio.play(eatSound,{channel=2})
			for i = #peixeTable, 1, -1 do
			if (peixeTable [i] == obj1 or peixeTable [i] == obj2) then
				table.remove(peixeTable, i)
				break
				end
			end

		elseif(obj2.myName=="Peixe1" or obj2.myName=="Peixe2" or obj2.myName=="Peixe3") 
			then
				display.remove(obj2)
				audio.play(eatSound,{channel=2})
				for i = #peixeTable, 1, -1 do
			if (peixeTable [i] == obj1 or peixeTable [i] == obj2) then
				table.remove(peixeTable, i)
				break
				end
			end
		end
			pontos=pontos+100
			pontosText.text=pontos
			if (pontos == 5000) then
				vidas=vidas+1
				vidasText.text=vidas
			end

	end -- fecha o if do myname
	end -- fecha if do phase
end -- fecha função

local function onCollision2(event)
	if(event.phase == "began") then
		local obj1 = event.object1
		local obj2 = event.object2

	if(((obj1.myName == "Tubarao" and obj2.myName == "Lata") or
			(obj1.myName == "Lata" and obj2.myName == "Tubarao"))
			
			or ((obj1.myName=="Tubarao" and obj2.myName=="Pet") or
			(obj1.myName=="Pet" and obj2.myName=="Tubarao"))
			
			or ((obj1.myName=="Tubarao" and obj2.myName=="Lata2") or
			(obj1.myName=="Lata2" and obj2.myName=="Tubarao")))

		then
			if (morto == false) then
				morto = true
				audio.play(hurtSound,{channel=3})

			vidas = vidas -1
			vidasText.text = vidas

				if (vidas == 0) then
					display.remove(tubarao)
					timer.performWithDelay(1000, endGame)
				else
					tubarao.alpha = 0
					timer.performWithDelay(800, restaurarTubarao)
				end	
			end
		end
	end
end

function scene:create(event)
	local sceneGroup = self.view

	physics.pause()

	backGroup = display.newGroup()
	sceneGroup:insert(backGroup)

	mainGroup = display.newGroup()
	sceneGroup:insert(mainGroup)

	uiGroup = display.newGroup()
	sceneGroup:insert(uiGroup)

	local bg = display.newImageRect(backGroup,"imagens/bg.jpeg", 624,417 )
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY

	tubarao = display.newImageRect(mainGroup,"imagens/tubarao.png", 840/5.5, 336/5.5)
	tubarao.x = display.contentCenterX
	tubarao.y = display.contentCenterY
	tubarao.xScale = -1
	physics.addBody(tubarao, {radius=30, isSensor=true})
	tubarao.myName="Tubarao"

	vidasCoracao= display.newImageRect(uiGroup,"imagens/coracao2.png", 219/6, 149/5, Arial, 23)
    vidasCoracao.x = 20
    vidasCoracao.y = 0
    vidasText = display.newText (uiGroup, vidas, 20,1.5, Arial, 18)
    vidasText:setFillColor(1,1,1)

    pontosEstrela= display.newImageRect(uiGroup,"imagens/estrela1.png", 225/6, 225/6, Arial, 23)
    pontosEstrela.x = 70
    pontosEstrela.y = 0
    pontosText = display.newText (uiGroup, vidas, 110,1.5, Arial, 18)
    pontosText:setFillColor( 0,0,0 )

	tubarao:addEventListener("touch", moverTubarao)
end
	
function scene:show(event)

	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		-- Quando a cena está pronta para ser exibida antes da transição.

	elseif (phase == "did") then
		-- Quando a cena já está sendo exibida após a transição.

		physics.start()
		Runtime:addEventListener("collision", onCollision)
		Runtime:addEventListener("collision", onCollision2)
		gameLoopTimer = timer.performWithDelay(2800, gameLoop, 0)
		gameLoopTimer2 = timer.performWithDelay(3500, gameLoop2, 0)
		audio.play(bgSound, {channel=5, loops=-1})
		
	end
end

function scene:hide(event)

	local sceneGroup = self.view
	local phase = event.phase

	if (phase == "will") then
		timer.cancel (gameLoopTimer)
		timer.cancel(gameLoopTimer2)

	elseif (phase == "did") then
		Runtime:removeEventListener("collision", onCollision)
		Runtime:removeEventListener("collision", onCollision2)
		physics.pause ()
		audio.stop(5)
		composer.removeScene ("game")
	end
end

function scene:destroy(event)
	local sceneGroup = self.view

	audio.dispose(eatSound)
	audio.dispose(hurtSound)
	audio.dispose(bgSound)
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
return scene