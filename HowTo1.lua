-----------------------------------------------------------------------------------------
--
-- HowTo1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local physics = require("physics")
physics.start()
local background
local gameUI = {}
local text = {}
local gotoHowTo2
local player

function scene:create( event )
	local sceneGroup = self.view
	
	--배경
	background = display.newImageRect("image/BG2.png", display.contentWidth, display.contentHeight)
	background.x , background.y = display.contentWidth/2, display.contentHeight/2

	gameUI[1] = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
	gameUI[1]:setFillColor(0)
	gameUI[1].alpha = 0

	--게임 룰
	gameUI[2] = display.newRect(display.contentWidth/2, display.contentHeight/2, 740, display.contentHeight)
	gameUI[2].alpha = 0.2

	text[1] = display.newImageRect("image/조작.png", 180, 68)
	text[1].x, text[1].y = 380, 50

  	text[2] = display.newText("키보드 방향키를 사용해서 이동합니다.", display.contentWidth/2, 650)
  	text[2]:setFillColor(0)
  	text[2].size = 30

  	text[3] = display.newText("한번 해보기♥", display.contentWidth/2, 690)
  	text[3]:setFillColor(0)
  	text[3].size = 30

  	player = display.newImageRect("image/player.png", 75, 125)
 	player.x, player.y = display.contentWidth/2 - 290, 650
  	physics.addBody(player, "static", {friction=0})
		
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
	end

  	Runtime:addEventListener( "key", movePlayer )
		


	local function goHowTo2( event )
		player:removeSelf()
		Runtime:removeEventListener("key", movePlayer)
		composer.gotoScene("HowTo2")
	end

	gotoHowTo2 = display.newImage("image/next.png")
	gotoHowTo2.x, gotoHowTo2.y = 1145, display.contentHeight/2
	gotoHowTo2.alpha = 0.7

	gotoHowTo2:addEventListener("tap", goHowTo2)



	sceneGroup:insert( background )
	for i = 1, 2, 1 do 
		sceneGroup:insert( gameUI[i] )
	end
	for i = 1, 3, 1 do
		sceneGroup:insert( text[i] )
	end
	sceneGroup:insert( player )
	sceneGroup:insert( gotoHowTo2 )

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
		composer.removeScene("HowTo1")
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