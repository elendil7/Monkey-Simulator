
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

local game_over_overlay_background
local game_over_overlay_text

local final_score
local final_score_text

local try_again_btn
local back_to_menu_btn
local go_to_highscores_btn

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
		
	-- overlay background
	game_over_overlay_background = display.newImageRect(sceneGroup, "images/game_over_background.jpg", display.contentWidth, display.contentHeight);
	game_over_overlay_background.x = display.contentCenterX
	game_over_overlay_background.y = display.contentCenterY
	game_over_overlay_background.alpha=1

	-- overlay text
	game_over_overlay_text = display.newImageRect(sceneGroup, "images/game_over_text.png", 400, 100);
	game_over_overlay_text.x = display.contentCenterX
	game_over_overlay_text.y = 330
	game_over_overlay_text.alpha=1

	-- display score:
	final_score = composer.getVariable("final_score");
	final_score_text = display.newEmbossedText(sceneGroup, "Final score: " .. final_score, display.contentCenterX, 440, "Matura MT Script Capitals", 46)
	final_score_text:setFillColor(127, 0, 255)
	final_score_text.alpha = 0
	transition.fadeIn(final_score_text, {time=1000} );

	-- fade in try_again_btn
	try_again_btn = display.newImageRect(sceneGroup, "images/game_over_try_again.png", 230, 70)
	try_again_btn.x=200
	try_again_btn.y=560
	try_again_btn.alpha=0

	local function try_again_btn_delay(event)
		transition.fadeIn(try_again_btn, {time=1000} )
	end
	timer.performWithDelay(1000, try_again_btn_delay);

	-- fade in back_to_menu_btn
	back_to_menu_btn = display.newImageRect(sceneGroup, "images/game_over_main_menu.png", 245, 70)
	back_to_menu_btn.x=display.contentCenterX
	back_to_menu_btn.y=560
	back_to_menu_btn.alpha=0

	local function backtomenu_btn_delay(event)
		transition.fadeIn(back_to_menu_btn, {time=1000} )
	end
	timer.performWithDelay(1000, backtomenu_btn_delay);

	-- fade in go_to_highscores_btn
	go_to_highscores_btn = display.newImageRect(sceneGroup, "images/game_over_highscores.png", 250, 70)
	go_to_highscores_btn.x=830
	go_to_highscores_btn.y=560
	go_to_highscores_btn.alpha=0

	local function highscores_btn_delay(event)
		transition.fadeIn(go_to_highscores_btn, {time=1000} )
	end
	timer.performWithDelay(1000, highscores_btn_delay);

end

-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase
	local parent = event.parent -- important!!!

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

		-- try again function
		local function try_again(event)
			parent:tryAgain()
		end
		try_again_btn:addEventListener("tap", try_again)

		-- back to menu function
		local function back_to_menu(event)
			parent:backToMenu()
		end
		back_to_menu_btn:addEventListener("tap", back_to_menu)

		-- go to highscores function
		local function go_to_highscores(event)
			parent:goToHighscores()
		end
		go_to_highscores_btn:addEventListener("tap", go_to_highscores)

	end
end

-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
