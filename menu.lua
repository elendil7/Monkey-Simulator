
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- variables
local button_sound
local menu_background
local game_title
local help_btn
local credits_btn
local highscores_btn
local play_btn
local menu_music

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
		menu_background = display.newImageRect(sceneGroup, "images/menu_background.jpg", display.contentWidth, display.contentHeight);
		menu_background.x = display.contentCenterX
		menu_background.y = display.contentCenterY
		menu_background.alpha=0
		transition.fadeIn( menu_background, { time=2000 } )

	-- title
		game_title = display.newImageRect(sceneGroup, "images/game_title.png", display.contentCenterX, display.contentCenterY);
		game_title.width=600
		game_title.height=86
		game_title.x=507
		game_title.y=325
		game_title.alpha=0
		transition.fadeIn( game_title, { time=2000 } )

	-- buttons
		-- help
			help_btn = display.newImageRect(sceneGroup, "images/help_btn.png", display.contentCenterX, display.contentCenterY);
			help_btn.width=230
			help_btn.height=70
			help_btn.x=132
			help_btn.y=625
			help_btn.alpha=0

			local function help_btn_listener( event )
				transition.fadeIn( help_btn, { time=2000 } )
			end
			timer.performWithDelay( 500, help_btn_listener )

			local function help_btn_tap(event)
				local button_sound = audio.loadSound("audio/button_sound.wav")
				audio.play(button_sound)
				composer.gotoScene("help", {time=1000, effect="crossFade"});
			end
			help_btn:addEventListener("tap", help_btn_tap)
			
		-- credits
			credits_btn = display.newImageRect(sceneGroup, "images/credits_btn.png", display.contentCenterX, display.contentCenterY);
			credits_btn.width=230
			credits_btn.height=70
			credits_btn.x=890
			credits_btn.y=625
			credits_btn.alpha=0
			
			local function credits_btn_listener( event )
				transition.fadeIn( credits_btn, { time=2000 } )
			end
			timer.performWithDelay( 1000, credits_btn_listener )

			local function credits_btn_tap(event)
				audio.play(button_sound)
				composer.gotoScene("credits", {time=1000, effect="crossFade"});
			end
			credits_btn:addEventListener("tap", credits_btn_tap)

		-- quit
			local quit_btn = display.newImageRect(sceneGroup, "images/quit_btn.png", display.contentCenterX, display.contentCenterY);
			quit_btn.width=230
			quit_btn.height=70
			quit_btn.x=890
			quit_btn.y=150
			quit_btn.alpha=0

			local function quit_btn_listener(event)
				transition.fadeIn( quit_btn, { time=2000 } )
			end
			timer.performWithDelay( 1500, quit_btn_listener )
			
			local function quit_btn_tap(event)
				audio.play(button_sound)
				composer.gotoScene("farewell_screen", { time=1000, effect="crossFade" });
			end
			quit_btn:addEventListener("tap", quit_btn_tap)

		-- highscores
			highscores_btn = display.newImageRect(sceneGroup, "images/highscores_btn.png", display.contentCenterX, display.contentCenterY);
			highscores_btn.width=230
			highscores_btn.height=70
			highscores_btn.x=132
			highscores_btn.y=150
			highscores_btn.alpha=0

			local function highscore_btn_listener( event )
				transition.fadeIn( highscores_btn, { time=2000 } )
			end
			timer.performWithDelay( 2000, highscore_btn_listener )

			local function highscores_btn_tap(event)
				audio.play(button_sound)
				composer.gotoScene("highscores", {time=1000, effect="crossFade"});
			end
			highscores_btn:addEventListener("tap", highscores_btn_tap)

		-- play
			play_btn = display.newImageRect(sceneGroup, "images/play_btn.png", display.contentCenterX, display.contentCenterY);
			play_btn.width=370
			play_btn.height=100
			play_btn.x=504
			play_btn.y=475
			play_btn.alpha=0

			local function play_btn_listener( event )
				transition.fadeIn( play_btn, { time=2000 } )
			end
			timer.performWithDelay( 3000, play_btn_listener )

			local function play_btn_tap(event)
				audio.dispose(help_music);
				audio.dispose(highscores_music);
				audio.dispose(credits_music);
				audio.play(button_sound)
				composer.gotoScene("game", { time=1000, effect="crossFade" });
			end
			play_btn:addEventListener( "tap", play_btn_tap )

		-- music
			menu_music = audio.loadStream("music/menu_music.mp3")
			audio.play(menu_music,{channel=1, loops=-1, fadeIn=3000});
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
			audio.stop(1)
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	-- music
		audio.dispose(menu_music)

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
