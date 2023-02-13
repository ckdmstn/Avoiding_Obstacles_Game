-----------------------------------------------------------------------------------------
--
-- Game.lua
--
-----------------------------------------------------------------------------------------


local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local physics = require("physics")
physics.start()
local background
local gameUI = {}
local player


function scene:create( event )
	local sceneGroup = self.view

	--배경
	background = display.newImageRect("image/BG3.png", display.contentWidth, display.contentHeight)
	background.x , background.y = display.contentWidth/2, display.contentHeight/2

	gameUI[1] = display.newRect( display.contentWidth/2, display.contentHeight/2, 900, display.contentHeight )
  gameUI[1]:setFillColor(1)
  gameUI[1].alpha = 0.5

  gameUI[2] = display.newRect(110, 650, 160, 135)
  gameUI[2]:setFillColor(1)
  gameUI[2].alpha = 0.7

  gameUI[3] = display.newRect(1170, 68, 160, 135)
  gameUI[3]:setFillColor(1)
  gameUI[3].alpha = 0.7

  gameUI[4] = display.newRect(190, 292, 10, 584)
  gameUI[4]:setFillColor(0)

  gameUI[5] = display.newRect(1090, 427, 10, 584)
  gameUI[5]:setFillColor(0)

  gameUI[6] = display.newRect(1170, 173, 160, 76)
  gameUI[6]:setFillColor(0)
  gameUI[6].alpha = 0.5

  --시작부분
  gameUI[7] = display.newImage("image/start2.png")
  gameUI[7].x, gameUI[7].y = gameUI[2].x, gameUI[2].y
  gameUI[7].alpha = 0.7

  --도착부분
  gameUI[8] = display.newImage("image/arrive.png")
  gameUI[8].x, gameUI[8].y = gameUI[3].x, gameUI[3].y
  gameUI[8].alpha = 0.7

  local bear = display.newImageRect("image/bear.png", 55, 94)
  bear.x, bear.y = 1250, 173 --그린게 아까워서 넣어봤음...

  --점수
  local score = display.newText("500", gameUI[6].x, gameUI[6].y)
  score.size = 60
  local scoreCount = 500

  --캐릭터 생성
  player = display.newImageRect("image/player.png", 75, 125)
  player.x, player.y = gameUI[2].x, gameUI[2].y
  physics.addBody(player, "static", {friction=0})


  --장애물 생성
  --불 생성
  local function fireCreate1(event) 
  	local fire1 = display.newImageRect("image/fire1.png", 100, 100)
  	fire1.x, fire1.y = 420, -20
  	physics.addBody(fire1, "dynamic")
  	fire1.type = "fire"
  end
  local function fireCreate2(event) 
  	local fire2 = display.newImageRect("image/fire1.png", 100, 100)
  	fire2.x, fire2.y = 640, -20
  	physics.addBody(fire2, "dynamic")
  	fire2.type = "fire"
  end
  local function fireCreate3(event)
  	local fire3 = display.newImageRect("image/fire1.png", 100, 100)
  	fire3.x, fire3.y = 860, -20
  	physics.addBody(fire3, "dynamic")
  	fire3.type = "fire"
  end
  --불 떨어지는 시간 조절
  local dropFire1 = timer.performWithDelay(math.random(1300, 1500), fireCreate1, -1)
  local dropFire2 = timer.performWithDelay(math.random(1500, 2000), fireCreate2, -1)
  local dropFire3 = timer.performWithDelay(math.random(2000, 3000), fireCreate3, -1)

  --폭탄 생성
  local function bombCreate(event) 
  	local bomb = display.newImageRect("image/bomb.png", 50, 50)
  	bomb.x, bomb.y = math.random(215, 1050), math.random(0, 400)
  	physics.addBody(bomb, "dynamic")
  	bomb.type = "bomb"
  end

  local dropBomb = timer.performWithDelay(math.random(500, 1500), bombCreate, -1) --폭탄 떨어지는 시간 조절

  
  local function gotoWin(event)
    player:removeSelf()
    timer.pauseAll()
    composer.gotoScene("win")
  end

  local function gotoLose(event)
    player:removeSelf()
    timer.pauseAll()
    composer.gotoScene("lose")
  end 

  --이동
  local function movePlayer(event)
  	if event.keyName == "left" then
  		player.x, player.y = player.x-15, player.y
  	elseif event.keyName == "right" then
  		player.x, player.y = player.x+15, player.y
  	elseif event.keyName == "up" then
  		player.x, player.y = player.x, player.y-15
  	elseif event.keyName == "down" then
  		player.x, player.y = player.x, player.y+15
  	end

    if player.x > 1100 and player.y < 140 then
      Runtime:removeEventListener("key", movePlayer)
      gotoWin()
    --범위 벗어날 경우
    elseif player.x < 210 and player.y < 630 then
      Runtime:removeEventListener("key", movePlayer)
      gotoLose()
    elseif player.x > 1070 and player.y > 90 then
      Runtime:removeEventListener("key", movePlayer)
      gotoLose()
    elseif player.x < 37 or player.x > 1243 or player.y < 40 or player.y > 670 then 
      Runtime:removeEventListener("key", movePlayer)
      gotoLose()
    end
  end

  Runtime:addEventListener( "key", movePlayer )


  --충돌
  player.collision = function (self, event)
  	if (event.phase == "began") then
  		if (event.other.type == "bomb") then
  			event.other:removeSelf()
  			scoreCount = scoreCount - 250
  			score.text = string.format("%03d", scoreCount)
  			if (scoreCount <= 0) then
          Runtime:removeEventListener("key", movePlayer)
  				gotoLose()
  			end
  		elseif (event.other.type == "fire") then
        Runtime:removeEventListener("key", movePlayer)
        event.other:removeSelf()
  			gotoLose()
  		end
  	end
  end

  player:addEventListener("collision", player)




  sceneGroup:insert( background )
  for i = 1, 8, 1 do
    sceneGroup:insert( gameUI[i] )
  end
  sceneGroup:insert( bear )
  sceneGroup:insert( score )
  sceneGroup:insert( player )

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		composer.removeScene("Game")
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene