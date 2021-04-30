
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- variables
local button_sound
local credits_music

local credits_background
local credits_text

local back_btn

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	-- button sound
		button_sound = audio.loadSound("audio/button_sound.wav")

	-- background
		credits_background = display.newImageRect(sceneGroup,"images/jungle_background.jpg", display.contentWidth, display.contentHeight);
		credits_background.x=display.contentCenterX
		credits_background.y=display.contentCenterY
		credits_background.alpha=0
		transition.fadeIn(credits_background, {time=1000} )

	-- text
		credits_text = display.newEmbossedText(sceneGroup, "Game Developed by Aragorn\n\nMusic by Eric Matyas\nwww.soundimage.org", display.contentCenterX, display.contentCenterY, "Matura MT Script Capitals", 50);
		credits_text:setFillColor(0,0,255)
		transition.fadeIn(credits_text, {time=1000} )
	
	-- buttons
		-- back
			back_btn = display.newImageRect(sceneGroup, "images/back_btn.png", display.contentCenterX, display.contentCenterY);
			back_btn.width=237
			back_btn.height=70
			back_btn.x=890
			back_btn.y=150
			back_btn.alpha=0
			
			local function back_btn_listener( event )
				transition.fadeIn( back_btn, { time=2000 } )
			end
			timer.performWithDelay( 1000, back_btn_listener )

			local function back_to_menu(event)
				audio.play(button_sound)
				audio.stop(5);
				composer.removeScene("credits")
				composer.gotoScene( "menu", {time=1000, effect="crossFade"} )
			end
			back_btn:addEventListener("tap", back_to_menu)

		-- music
			credits_music = audio.loadStream("music/archive_halls.mp3");
			audio.play(credits_music, {channel=5, loops=-1, fadeIn=3000})

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

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

		-- music
			audio.stop(5);

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
