
local composer = require( "composer" )

local scene = composer.newScene()


-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

local resume_btn_overlay
local pause_overlay_background
local pause_overlay_text

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	-- overlay background
	pause_overlay_background = display.newImageRect(sceneGroup, "images/paused_background.png", display.contentWidth, display.contentHeight);
	pause_overlay_background.x = display.contentCenterX
	pause_overlay_background.y = display.contentCenterY
	pause_overlay_background.alpha=0.7

	-- overlay text
	pause_overlay_text = display.newImageRect(sceneGroup, "images/paused_text.png", 300, 100);
	pause_overlay_text.x = display.contentCenterX
	pause_overlay_text.y = display.contentCenterY
	pause_overlay_text.alpha=1

	-- fade in resume button
	resume_btn = display.newImageRect(sceneGroup, "images/resume_btn.png", 230, 70)
	resume_btn.x=132
	resume_btn.y=150
	resume_btn.alpha=0
	transition.fadeIn(resume_btn, {time=1000} )

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

		-- resume game function
		local function resume_game(event)
			parent:resumeGame()
		end
		resume_btn:addEventListener("tap", resume_game)
	
	end
end

-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase
	local parent = event.parent

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
