
local composer = require("composer")
local score = require("score")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- variables
local button_sound
local highscores_music

local highscores_background
local highscores_text

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
		highscores_background = display.newImageRect(sceneGroup,"images/jungle_background.jpg", display.contentWidth, display.contentHeight);
		highscores_background.x=display.contentCenterX
		highscores_background.y=display.contentCenterY
		highscores_background.alpha=0
		transition.fadeIn(highscores_background, {time=1000} )
	
	-- text
		highscores_text = display.newEmbossedText(sceneGroup, "Highscores:\n\n", display.contentCenterX, 300, "Matura MT Script Capitals", 50);
		highscores_text:setFillColor(0,0,255)
		transition.fadeIn(highscores_text, {time=1000} )

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
				audio.stop(4);
				composer.removeScene("highscores")
				composer.gotoScene( "menu", {time=1000, effect="crossFade"} )
			end
			back_btn:addEventListener("tap", back_to_menu)

		-- music
			highscores_music = audio.loadStream("music/archive_halls.mp3");
			audio.play(highscores_music, {channel=4, loops=-1, fadeIn=3000})

	-- loading & saving highscore data
			-- variables
			local json = require("json")
			local scores_table = {}
			local file_path = system.pathForFile("scores.json", system.DocumentsDirectory);

			-- load scores
			local function load_scores()
				
				local file = io.open(file_path, "r"); -- check if file path exists, r = read-only

				if file then -- if file exists execute code
					local contents = file:read("*a") -- read full file contents
					io.close(file) -- close file
					scores_table = json.decode(contents); -- decode contents
				end

				-- store .json contents in scores_table
				if ( scores_table == nil or #scores_table == 0 ) then
					scores_table = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
				end
			end

			-- save scores
			local function save_scores()

				-- clear useless scores (< 1 and > 10)
				for i = #scores_table, 11, -1 do 
					table.remove(scores_table, i)
				end

				-- open file, w = write / overwrite file
				local file = io.open(file_path, "w")
				
				if file then
					file:write( json.encode(scores_table) ); -- convert (encode) scores_table data to .json file
					io.close(file) -- close file
				end
			end

	-- calculate & save highscores
			-- load previous score
			load_scores()

			-- insert saved score from the last game into the table, then reset it
			table.insert(scores_table, composer.getVariable( "final_score" ) ); -- insert saved highscore from game
			composer.setVariable("final_score", 0) -- reset "final_score" to 0 for next round of game

			-- sort the table from highest to lowest scores
			local function compare(a, b) -- compare pairs of 2 variables functions, sorting mechanism
				return a > b -- returns highest of each of the variable pairs
			end
			table.sort(scores_table, compare) -- sorts table from highest to lowest scores using sorting mechanism

			-- save the highscores
			save_scores()

	-- display highscores
			-- calculate positioning of highscores
			for i = 1, 5 do -- loops the code for 1st - 5th value in the table
				if (scores_table[i] ) then            -- for every value in table
					local y_pos_left = 260 + ( i * 56 )    -- move it's position down a specified number of Y points
					
					-- rank number (1. to 5.)
					local rank_num_left = display.newText(sceneGroup, i .. ")", display.contentCenterX-150, y_pos_left, "Matura MT Script Capitals", 40)
					rank_num_left:setFillColor(0, 0, 255)
					rank_num_left.anchorX = 1 -- aligns rank_num.X to left

					-- actual score (next to rank number)
					local this_score_left = display.newText(sceneGroup, scores_table[i], display.contentCenterX-130, y_pos_left, "Matura MT Script Capitals", 40)
					this_score_left:setFillColor(0, 0, 255)
					this_score_left.anchorX = 0 -- aligns this_score.X to right
				end
			end

			for i = 6, 10 do -- loops the code for 1st - 5th value in the table
				if (scores_table[i] ) then
					local y_pos_right = -18 + ( i * 56 )
					
					-- rank number (6. to 10.)
					local rank_num_right = display.newText(sceneGroup, i .. ")", display.contentCenterX+130, y_pos_right, "Matura MT Script Capitals", 40)
					rank_num_right:setFillColor(0, 0, 255)
					rank_num_right.anchorX = 1

					-- actual score (next to rank number)
					local this_score_right = display.newText(sceneGroup, scores_table[i], display.contentCenterX+150, y_pos_right, "Matura MT Script Capitals", 40)
					this_score_right:setFillColor(0, 0, 255)
					this_score_right.anchorX = 0
				end
			end
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
			audio.stop(4);

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
