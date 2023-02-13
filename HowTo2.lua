-----------------------------------------------------------------------------------------
--
-- HowTo2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )
local background
local gameUI = {}
local text = {}
local start 
local gotoHowTo1

function scene:create( event )
	local sceneGroup = self.view
	
	--배경
	background = display.newImageRect("image/BG2.png", display.contentWidth, display.contentHeight)
	background.x , background.y = display.contentWidth/2, display.contentHeight/2
	
	gameUI[1] = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
	gameUI[1]:setFillColor(0)
	gameUI[1].alpha = 0

	--게임 룰

	local function gameRule(event)
		gameUI[2] = display.newRect(display.contentWidth/2, display.contentHeight/2, 740, display.contentHeight)
		gameUI[2].alpha = 0.6

		text[1] = display.newImageRect("image/rule.png", 180, 60)
		text[1].x, text[1].y = 380, 50

		gameUI[3] = display.newImage("image/1.png")
		gameUI[3].x, gameUI[3].y = 500, 230

		text[3] = {}

		text[3][1] = display.newText("시작부분에서 출발하여 장애물에", 838, 135)
		text[3][2] = display.newText("맞지 않고 도착부분에 도착하면 성공", 853, 165)
		text[3][3] = display.newText("지정된 공간을 벗어나면", 803, 220)
		text[3][4] = display.newText("게임오버", 939, 220)

		for i = 1, 4, 1 do
			text[3][i]:setFillColor(0)
			text[3][i].size = 25
		end
		text[3][4]:setFillColor(1, 0.2, 0.2)

		gameUI[4]= display.newImage("image/2.png")
		gameUI[4].x, gameUI[4].y = 840, 330

		text[4] = display.newText("빨간부분 닿으면 게임오버", 840, 420)
		text[4]:setFillColor(0)
		text[4].size = 20

		text[5] = display.newText("1. 점수", 360, 380)
		text[5]:setFillColor(0)
		text[5].size = 35

		gameUI[5] = display.newImage("image/500.png")
		gameUI[5].x, gameUI[5].y = 380, 440

		text[6] = display.newText("시작은 500점", 505, 420)
		text[6]:setFillColor(0)
		text[6].size = 20
		text[7] = display.newText("0점 이하로 떨어질 경우", 537, 450)
		text[7]:setFillColor(0)
		text[7].size = 20
		text[8] = display.newText("게임오버", 660, 450)
		text[8]:setFillColor(1, 0.2, 0.2)
		text[8].size = 25

		text[9] = display.newText("2.", 330, 510)
		text[9]:setFillColor(0)
		text[9].size = 35

		gameUI[6] = display.newImageRect("image/fire1.png", 100, 100)
		gameUI[6].x, gameUI[6].y = 410, 550
		text[10] = display.newText(": 게임오버", 515, 550)
		text[10]:setFillColor(0)
		text[10].size = 25

		gameUI[7] = display.newImageRect("image/bomb.png", 50, 50)
		gameUI[7].x, gameUI[7].y = 410, 660
		text[11] = display.newText(": -250점", 515, 660)
		text[11]:setFillColor(0)
		text[11].size = 25

		--시작
  	 	start = display.newImageRect("image/start.png", 250, 71)
  	 	start.x, start.y = 880, 680

   		local function gotoStartGame()
			composer.gotoScene("Game")
		end

   		start:addEventListener("tap", gotoStartGame)
	end

	gameRule()

	local function goHowTo1( event )
		composer.gotoScene("HowTo1")
	end

	gotoHowTo1 = display.newImage("image/next2.png")
	gotoHowTo1.x, gotoHowTo1.y = 135, display.contentHeight/2
	gotoHowTo1.alpha = 0.7

	gotoHowTo1:addEventListener("tap", goHowTo1)


	sceneGroup:insert( background )
	for i = 1, 7, 1 do
		sceneGroup:insert( gameUI[i] )
	end
	sceneGroup:insert( text[1] )
	for i = 1, 4, 1 do
		sceneGroup:insert( text[3][i] )
	end
	for i = 4, 11, 1 do
		sceneGroup:insert( text[i] )
	end
	sceneGroup:insert( start )
	sceneGroup:insert( gotoHowTo1 )
	

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
		composer.removeScene("HowTo2")
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