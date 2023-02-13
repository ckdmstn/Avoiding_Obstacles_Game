-----------------------------------------------------------------------------------------
--
-- start.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	--배경
	local background = display.newImageRect("image/BG.png", display.contentWidth, display.contentHeight)
	background.x , background.y = display.contentWidth/2, display.contentHeight/2

	
   	--시작
   	local start = display.newImage("image/start.png")
   	start.x, start.y = 1050, 500

   	local function gotoStartGame()
		composer.gotoScene("Game")
	end
	start:addEventListener("tap", gotoStartGame)


   	--게임 방법
   	local howto = display.newImage("image/howto.png")
   	howto.x, howto.y = start.x, 630

	local function gotoHowTo()
		composer.gotoScene("HowTo1")
	end
	howto:addEventListener("tap", gotoHowTo)


	sceneGroup:insert ( background )
	sceneGroup:insert( start )
	sceneGroup:insert ( howto )
	
	
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
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
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