
local composer = require("composer")
local score = require("score")

local scene = composer.newScene()

-- options
local pause_overlay_options = {
	isModal=true, -- prevents objects from being touched through overlay
	effect="fade",
	time=400,
}

local game_over_overlay_options = {
	isModal=true,
	effect="fade",
	time=400
}

local overlay_button_options = {
	isModal=true,
	effect="crossFade",
	time=1000
}

-- variables
local physics

local walking_left_sheet_data
local monkey_walking_left_sheet
local monkey_walking_left_sequence_data
local monkey_walking_left_animation

local walking_right_sheet_data
local monkey_walking_right_sheet
local monkey_walking_right_sequence_data
local monkey_walking_right_animation

local button_sound
local scamper_sound
local banana_caught
local life_lost_sound
local game_over_sound

local sound_table
local random_number_function
local music_choice
local game_music

local game_background
local grass
local tree1_name
local tree2_name
local tree1_outline
local tree2_outline
local tree1
local tree2

local monkey_name
local monkey_outline
local monkey_facing_forward
local monkey_happy
local monkey_dead

local score_text
local lives_text

local banana_life_1
local banana_life_2
local banana_life_3
local red_cross_1
local red_cross_2
local red_cross_3

local left_btn
local right_btn
local left_overlay_btn
local right_overlay_btn

local back_btn
local pause_btn

local motionX=0
local motionY=0
local speed=5

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- physics:
physics = require ("physics")
physics.start(noSleep);
physics.setDrawMode("normal")
physics.setGravity(0, 1);

-- monkey left right sprite sheets
	-- sequences
	sequence_data = {
		name = "walking", 
		start=1, 
		count=4, 
		time=270
	}

	-- sheet data
	monkey_sheet_data = {
		width = 280, -- frame width
		height = 336, -- frame height
		numFrames = 4, -- frames
		sheetContentWidth = 1120, -- sheet width
		sheetContentHeight = 336 -- sheet height
	}

-- walking left
	-- file
	monkey_walking_left_sheet = graphics.newImageSheet("sprites/walking_left/sprite_sheet.png", monkey_sheet_data);

	-- animation
	monkey_walking_left_animation = display.newSprite(monkey_walking_left_sheet, sequence_data);
	monkey_walking_left_animation.x=display.contentCenterX
	monkey_walking_left_animation.y=525
	monkey_walking_left_animation.xScale=0.3
	monkey_walking_left_animation.yScale=0.3
	monkey_walking_left_animation:setSequence("walking_left")
	monkey_walking_left_animation.alpha=0

-- walking right
	-- file
	monkey_walking_right_sheet = graphics.newImageSheet("sprites/walking_right/sprite_sheet.png", monkey_sheet_data);

	-- animation
	monkey_walking_right_animation = display.newSprite(monkey_walking_right_sheet, sequence_data);
	monkey_walking_right_animation.x=display.contentCenterX
	monkey_walking_right_animation.y=525
	monkey_walking_right_animation.xScale=0.3
	monkey_walking_right_animation.yScale=0.3
	monkey_walking_right_animation:setSequence("walking_right")
	monkey_walking_right_animation.alpha=0


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	-- button sound
		button_sound = audio.loadSound("audio/button_sound.wav")
		scamper_sound = audio.loadSound("audio/scamper.mp3")
		banana_caught_sound = audio.loadSound("audio/banana_caught.mp3")
		life_lost_sound = audio.loadSound("audio/lose_life.mp3")
		game_over_sound = audio.loadSound("audio/sad_trombone.mp3")

	-- background
		game_background = display.newImageRect(sceneGroup, "images/game_background.png", display.contentWidth, display.contentHeight);
        game_background.x = display.contentCenterX
        game_background.y = display.contentCenterY
        game_background.alpha=0
		transition.fadeIn( game_background, { time=2000 } )

	-- grass
		grass = display.newImageRect(sceneGroup, "images/grass.png", 750, 140)
		grass.myName = "grass"
	    grass.x = display.contentCenterX
        grass.y = 640
        grass.alpha=0
		transition.fadeIn( grass, { time=2000 } )

	-- trees & outlines
		tree1_name = "images/tree1.png"
		tree1_outline = graphics.newOutline(2, tree1_name);

        tree1 = display.newImage(sceneGroup, tree1_name)
		tree1.myName = "tree1"
        tree1.width=178
        tree1.height=300
        tree1.x=190
        tree1.y=420
        tree1.alpha=0
		transition.fadeIn( tree1, { time=1000 } )

		tree2_name = "images/tree2.png"
		tree2_outline = graphics.newOutline(2, tree2_name);

		tree2 = display.newImage(sceneGroup, tree2_name)
		tree2.myName = "tree2"
        tree2.width=178
        tree2.height=300
        tree2.x=850
        tree2.y=420
        tree2.alpha=0
		transition.fadeIn( tree2, { time=2000 } )

	-- display score
		local score_text = display.newEmbossedText(sceneGroup, "Score:", 80, 230, "Matura MT Script Capitals", 40)
		score_text.alpha = 0
		score_text:setFillColor(0, 0, 255)
		transition.fadeIn(score_text, {time=1000} );

		local scoreText = score.init(
		{
			fontSize = 40,
			font = "Matura MT Script Capitals",
			x = 80,
			y = 280,
			maxDigits = 6,
		})
		scoreText:setFillColor(0, 0, 225)
		sceneGroup:insert(scoreText)

--[[ 	-- drifting text
	local function make_drifting_text()
		if points > 0 then
			local points_symbol = "+"
		elseif points < 0 then
			local points_symbol = "-"
		end

		local drifting_text = display.newText(sceneGroup, ( points_symbol ..points ), display.contentCenterX, display.contentCenterY, "Matura MT Script Capitals", 18)
		drifting_text:setFillColor(math.random(0, 255), math.random(0, 255), math.random(0, 255))

		local function remove_drifting_text(drifting_text)
		display.remove(drifting_text)
			drifting_text=nil
			points = 0
		end
		timer.performWithDelay(1000, remove_drifting_text)
	end
	make_drifting_text() -- make drifting text ]]
	

	-- lives
		-- text
		lives_text = display.newEmbossedText(sceneGroup, "Lives:", 938, 230, "Matura MT Script Capitals", 40);
		lives_text:setFillColor(0,0,255)
		transition.fadeIn(lives_text, {time=2000} )

		-- bananas
		banana_life_1 = display.newImageRect(sceneGroup,"images/banana_life.png", 130, 70);
		banana_life_1.x=938
		banana_life_1.y=300
		banana_life_1.alpha=0
		transition.fadeIn(banana_life_1, {time=2000} )

		banana_life_2 = display.newImageRect(sceneGroup,"images/banana_life.png", 130, 70);
		banana_life_2.x=938
		banana_life_2.y=380
		banana_life_2.alpha=0
		transition.fadeIn(banana_life_2, {time=2000} )

		banana_life_3 = display.newImageRect(sceneGroup,"images/banana_life.png", 130, 70);
		banana_life_3.x=938
		banana_life_3.y=460
		banana_life_3.alpha=0
		transition.fadeIn(banana_life_3, {time=2000} )

		-- crosses
		red_cross_1 = display.newImageRect(sceneGroup,"images/red_cross.png", 110, 72);
		red_cross_1.x=938
		red_cross_1.y=300
		red_cross_1.alpha=0

		red_cross_2 = display.newImageRect(sceneGroup,"images/red_cross.png", 110, 72);
		red_cross_2.x=938
		red_cross_2.y=380
		red_cross_2.alpha=0

		red_cross_3 = display.newImageRect(sceneGroup,"images/red_cross.png", 110, 72);
		red_cross_3.x=938
		red_cross_3.y=460
		red_cross_3.alpha=0

	-- monkey
    	-- facing forward
		monkey_name = "sprites/standing_still/facing_forward.png"
		monkey_outline = graphics.newOutline(2, monkey_name);

		monkey_facing_forward = display.newImageRect(sceneGroup, monkey_name, 110, 110);
		monkey_facing_forward.myName = "monkey"
		monkey_facing_forward.x=display.contentCenterX
		monkey_facing_forward.y=525
		monkey_facing_forward.alpha=1
		transition.fadeIn(monkey_facing_forward, {time=1000} );

		-- banana caught
		monkey_happy = display.newImageRect(sceneGroup, "sprites/banana_caught/happy.png", 110, 110);
		monkey_happy.x=display.contentCenterX
		monkey_happy.y=525
		monkey_happy.alpha=0

		-- game over (lives gone)
		monkey_dead = display.newImageRect(sceneGroup, "sprites/game_over/dead.png", 110, 110);
		monkey_dead.x=display.contentCenterX
		monkey_dead.y=525
		monkey_dead.alpha=0
		
	-- buttons		
		-- left
			left_btn = display.newImageRect(sceneGroup,"images/left.png", 133, 133);
			left_btn.x=132
			left_btn.y=600
			left_btn.alpha=0
			transition.fadeIn(left_btn, {time=2000} ); 

			-- left overlay button
			left_overlay_btn = display.newImageRect(sceneGroup, "images/left_overlay.png", 133, 133);
			left_overlay_btn.x=132
			left_overlay_btn.y=600
			left_overlay_btn.alpha=0

		-- right
			right_btn = display.newImageRect(sceneGroup,"images/right.png", 133, 133);
			right_btn.x=890
			right_btn.y=600
			right_btn.alpha=0
			transition.fadeIn(right_btn, {time=2000} );

			-- right overlay button
			right_overlay_btn = display.newImageRect(sceneGroup, "images/right_overlay.png", 133, 133);
			right_overlay_btn.x=890
			right_overlay_btn.y=600
			right_overlay_btn.alpha=0

		-- monkey movement
			-- on left tap
				local function left_btn_tap(event)
					motionX=-speed
					motionY=0

					transition.fadeIn(left_overlay_btn, {time=100} ); 

					monkey_happy.alpha = 0
					monkey_dead.alpha = 0
					monkey_facing_forward.alpha=0
					monkey_walking_right_animation.alpha=0

					monkey_walking_left_animation.alpha=1
					monkey_walking_left_animation:play("walking")

					audio.play(scamper_sound, {channel=6, loops=-1} )
				end
				left_btn:addEventListener("touch", left_btn_tap)

			-- on right tap
				local function right_btn_tap(event)
					motionX=speed
					motionY=0

					transition.fadeIn(right_overlay_btn, {time=100} ); 
					
					monkey_happy.alpha = 0
					monkey_dead.alpha = 0
					monkey_facing_forward.alpha=0
					monkey_walking_left_animation.alpha=0

					monkey_walking_right_animation.alpha=1
					monkey_walking_right_animation:play("walking")

					audio.play(scamper_sound, {channel=6, loops=-1} )
				end
				right_btn:addEventListener("touch", right_btn_tap)

			-- move the monkey
				local function move_the_monkey(event)
					monkey_facing_forward.x = monkey_facing_forward.x + motionX
					monkey_facing_forward.y = monkey_facing_forward.y + motionY

					monkey_walking_left_animation.x = monkey_walking_left_animation.x + motionX
					monkey_walking_left_animation.y = monkey_walking_left_animation.y + motionY

					monkey_walking_right_animation.x = monkey_walking_right_animation.x + motionX
					monkey_walking_right_animation.y = monkey_walking_right_animation.y + motionY

					monkey_happy.x = monkey_happy.x + motionX
					monkey_happy.y = monkey_happy.y + motionY

					monkey_dead.x = monkey_dead.x + motionX
					monkey_dead.y = monkey_dead.y + motionY

					if monkey_facing_forward.x < 240 then
						monkey_facing_forward.x = 240
					elseif monkey_facing_forward.x > 800 then
						monkey_facing_forward.x = 800
					end

					if monkey_walking_left_animation.x < 240 then
						monkey_walking_left_animation.x = 240
					elseif monkey_walking_left_animation.x > 800 then
						monkey_walking_left_animation.x = 800
					end

					if monkey_walking_right_animation.x < 240 then
						monkey_walking_right_animation.x = 240
					elseif monkey_walking_right_animation.x > 800 then
						monkey_walking_right_animation.x = 800
					end
					
					if monkey_happy.x < 240 then
						monkey_happy.x = 240
					elseif monkey_happy.x > 800 then
						monkey_happy.x = 800
					end
					
					if monkey_dead.x < 240 then
						monkey_dead.x = 240
					elseif monkey_dead.x > 800 then
						monkey_dead.x = 800
					end
				end
				Runtime:addEventListener("enterFrame", move_the_monkey)

			-- stop moving monkey
				local function stop_moving_monkey(event)
					if event.phase == "ended" then
						motionX=0
						motionY=0

						transition.fadeOut(left_overlay_btn, {time=100} ); 
						transition.fadeOut(right_overlay_btn, {time=100} ); 

						monkey_facing_forward.alpha=1
						monkey_dead.alpha=0
						monkey_happy.alpha=0
						monkey_walking_left_animation.alpha=0
						monkey_walking_right_animation.alpha=0

						monkey_walking_left_animation:pause("walking")
						monkey_walking_right_animation:pause("walking")

						audio.stop(6);
					end
				end
				Runtime:addEventListener("touch", stop_moving_monkey)

	-- physics objects (bodies)
	physics.addBody(tree1, "static", {outline=tree1_outline} )
	physics.addBody(tree2, "static", {outline=tree2_outline} )
			
	physics.addBody(grass, "static", {density=1.0, friction=0.3, sensor=true})

	physics.addBody(monkey_facing_forward, "static", {outline=monkey_outline, sensor=true})

	-- music
	sound_table = {"music/game1.mp3", "music/game2.mp3", "music/game3.mp3", "music/game4.mp3"}
	random_number_function = math.random
	music_choice = (sound_table[random_number_function(1,4)]);
	game_music = audio.loadStream(music_choice)

	audio.play(game_music, {channel=2, loops=-1, fadeIn=3000})

	-- gameplay
		-- variables
		local points
		local total_points

		local banana_name
		local banana_outline
		local banana_table
		local banana_number
		
		local new_falling_banana

		local banana_delay
		local banana_lives

		local create_banana_timer
		local banana_loop

		-- create falling banana function
		banana_table = {}
		banana_delay = 3000

		local function create_banana()
			banana_name = "images/banana.png"
			banana_outline = graphics.newOutline(2, banana_name);

			new_falling_banana = display.newImageRect(sceneGroup, banana_name, 65, 37);
			table.insert(banana_table, new_falling_banana)
			physics.addBody(new_falling_banana, "dynamic", {density=1.0, friction=0.5, bounce=0.05, radius=15, outline=banana_outline, sensor=true} );
			new_falling_banana.myName = "falling_banana"

			new_falling_banana.x = math.random(300, 700);
			new_falling_banana.y = -37

			new_falling_banana:applyTorque(math.random(-6, 6))
			new_falling_banana:setLinearVelocity(math.random(0, 0.5), math.random(0, 0.75))
		end

		-- endless bananas mechanic & cleanup mechanic
		function banana_loop()
			create_banana()
		end
		create_banana_timer = timer.performWithDelay(banana_delay, banana_loop, -1)

		-- banana collision mechanic
		banana_lives = 3
		points = 0
		total_points = 0

		function on_collision(event)
			if (event.phase == "began") then

				local remove_monkey_happy
				local remove_monkey_dead

				local obj1 = event.object1
				local obj2 = event.object2
					
				if ( ( obj1.myName == "falling_banana" and obj2.myName == "grass" ) or
					( obj1.myName == "grass" and obj2.myName == "falling_banana" ) )
				then
					banana_lives = banana_lives - 1
					points = points + (math.random(2, 6))
					total_points = total_points - points
					score.set(total_points)

					audio.play(life_lost_sound, {channel=7})

					if ( (monkey_walking_left_animation.alpha == 1) or
						( monkey_walking_right_animation.alpha == 1 ) ) then
						monkey_dead.alpha = 0
					else
						monkey_dead.alpha = 1
					end
					monkey_facing_forward.alpha = 0
					monkey_happy.alpha = 0

					function remove_monkey_dead()
						monkey_dead.alpha = 0
						monkey_facing_forward.alpha = 1
					end
					timer.performWithDelay(1000, remove_monkey_dead);

					if obj1.myName == "falling_banana" then
						display.remove(obj1)
					elseif obj2.myName == "falling_banana" then
						display.remove(obj2)
					end

					for banana_number = #banana_table, 1, -1 do
						if ( banana_table[banana_number] == obj1 or banana_table[banana_number] == obj2 ) then
							table.remove( banana_table, banana_number )
							break
						end
					end

					if banana_lives == 2 then
						transition.fadeIn(red_cross_1, {time=400} );
					elseif banana_lives == 1 then
						transition.fadeIn(red_cross_2, {time=400} );
					elseif banana_lives == 0  then
						transition.fadeIn(red_cross_3, {time=400} );
						monkey_facing_forward.alpha = 0
						physics.pause();
					end
						
					-- game over overlay mechanic
					if banana_lives == 0 then
						audio.stop(2)
						physics.pause()
						timer.cancel(create_banana_timer)
						
						composer.setVariable("final_score", total_points);

						for banana = #banana_table, 1, -1 do
							local this_banana = banana_table[banana]
							display.remove(this_banana)
							table.remove(banana_table, banana)
						end

						local function pause_before_overlay()
							audio.stop(6)
							audio.play(game_over_sound)

							Runtime:removeEventListener( "enterFrame", move_the_monkey)
							Runtime:removeEventListener("touch", stop_moving_monkey)
							Runtime:removeEventListener("collision", on_collision)

							display.remove(monkey_facing_forward);
							display.remove(monkey_dead);
							display.remove(monkey_happy);
							display.remove(monkey_walking_left_animation);
							display.remove(monkey_walking_right_animation);
							monkey_walking_left_animation:pause("walking")
							monkey_walking_right_animation:pause("walking")

							composer.showOverlay("gameover", game_over_overlay_options)
						end
						timer.performWithDelay(500, pause_before_overlay, game_over_overlay_options);
					end
				
				elseif ( ( obj1.myName == "falling_banana" and obj2.myName == "monkey" ) or
						( obj1.myName == "monkey" and obj2.myName == "falling_banana" ) )
				then
					points = 0
					points = points + (math.random(7, 15))
					total_points = total_points + points
					score.set(total_points)

					audio.play(banana_caught_sound, {channel=8})
					
					if ( (monkey_walking_left_animation.alpha == 1) or
						( monkey_walking_right_animation.alpha == 1 ) ) then
					else
						monkey_happy.alpha = 1
					end
					monkey_facing_forward.alpha = 0
					monkey_dead.alpha = 0

					function remove_monkey_happy()
						monkey_happy.alpha = 0
						monkey_facing_forward.alpha = 1
					end
					timer.performWithDelay(1000, remove_monkey_happy);

					if obj1.myName == "falling_banana" then
						display.remove(obj1)
					elseif obj2.myName == "falling_banana" then
						display.remove(obj2)
					end

					for banana_number = #banana_table, 1, -1 do
						if ( banana_table[banana_number] == obj1 or banana_table[banana_number] == obj2 ) then
							table.remove( banana_table, banana_number )
							break
						end
					end
				end
			end
		end
		Runtime:addEventListener("collision", on_collision)

	-- timer functions
		-- pause banana timer
		local function pause_banana_timer(event)
			timer.pause(create_banana_timer)
		end

		-- resume banana timer
		local function resume_banana_timer(event)
			timer.resume(create_banana_timer)
		end

		-- cancel banana timer
		local function cancel_banana_timer(event)
			timer.cancel(create_banana_timer)
		end

	-- game over overlay button functions
		-- try again btn function
		function scene:tryAgain()
			composer.removeScene("game", false)
			composer.gotoScene("game", overlay_button_options)
		end

		-- main menu btn function
		function scene:backToMenu()
			composer.removeScene("game", false)
			composer.gotoScene("menu", overlay_button_options)
		end

		-- highscores btn function
		function scene:goToHighscores()
			composer.removeScene("game", false)
			composer.gotoScene("highscores", overlay_button_options)
		end

	-- overlays
		-- pause game
		pause_btn = display.newImageRect(sceneGroup, "images/pause_btn.png", 230, 70);
		pause_btn.x=132
		pause_btn.y=150
		pause_btn.alpha=0

		local function pause_btn_listener( event )
			transition.fadeIn( pause_btn, { time=2000 } )
		end
		timer.performWithDelay( 1000, pause_btn_listener )

		local function pause_game(event)
			pause_banana_timer()
			audio.play(button_sound)
			audio.setVolume(0.2,{channel=2});
			physics.pause()
			transition.fadeOut( pause_btn, {time=1000} )
			composer.showOverlay("pause", pause_overlay_options)
		end
		pause_btn:addEventListener("tap", pause_game)

		-- resume game function
		function scene:resumeGame()
			resume_banana_timer()
			audio.play(button_sound)
			audio.setVolume(0.75,{channel=2});
			physics.start()
			transition.fadeIn( pause_btn, {time=1000} )
			composer.hideOverlay("pause", pause_overlay_options )
		end

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
			audio.stop(2)
			audio.play(button_sound)

			physics.pause()
			timer.cancel(create_banana_timer)

			composer.setVariable("final_score", total_points);

			for banana = #banana_table, 1, -1 do
				local this_banana = banana_table[banana]
				display.remove(this_banana)
				table.remove(banana_table, banana)
			end
			
			local function back_to_menu_delay()
				Runtime:removeEventListener( "enterFrame", move_the_monkey)
				Runtime:removeEventListener("touch", stop_moving_monkey)
				Runtime:removeEventListener("collision", on_collision)

				display.remove(monkey_facing_forward);
				display.remove(monkey_dead);
				display.remove(monkey_happy);
				display.remove(monkey_walking_left_animation);
				display.remove(monkey_walking_right_animation);
				monkey_walking_left_animation:pause("walking")
				monkey_walking_right_animation:pause("walking")

				composer.removeScene("game", false)
				composer.gotoScene("menu", {time=1000, effect="crossFade"} )
			end
			timer.performWithDelay(10, back_to_menu_delay);
		end
		back_btn:addEventListener("tap", back_to_menu)
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

		-- cancel the timers

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		-- music
			audio.stop(2)
	end
end

-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	-- music
		audio.dispose(game_music)

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
