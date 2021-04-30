
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- variables
local farewell_background
local farewell_image

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	-- background
		farewell_background = display.newImageRect(sceneGroup, "images/space_background.jpg", display.contentWidth, display.contentHeight);
		farewell_background.x = display.contentCenterX
		farewell_background.y = display.contentCenterY
		farewell_background.alpha=0
		
		local function farewell_background_transition(event)
			transition.fadeIn( farewell_background, { time=1000 } )
		end
		timer.performWithDelay( 500, farewell_background_transition )

	-- image text
		farewell_image = display.newImageRect(sceneGroup, "images/thanks_for_playing.png", display.contentCenterX, display.contentCenterY);
		farewell_image.width=600
		farewell_image.height=130
		farewell_image.x = display.contentCenterX
		farewell_image.y = display.contentCenterY
		farewell_image.alpha=0
		transition.fadeIn( farewell_image, { time=1000 } )

		local function farewell_image_transition(event)
			transition.fadeIn( farewell_image, { time=1000 } )
		end
		timer.performWithDelay( 1000, farewell_image_transition )

end

-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

		-- quit game
			local function quit_game(event)
				native.requestExit()
			end
			timer.performWithDelay( 4000, quit_game )

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
