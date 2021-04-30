-- Hide status bar
display.setStatusBar( display.HiddenStatusBar )

-- Seed the random number generator
math.randomseed( os.time() )

-- load composer scene management library
local composer = require( "composer" )

-- reserve music channel
audio.reserveChannels(8);
-- set channel volume
audio.setVolume(0.5,{channel=1}); -- menu
audio.setVolume(0.75,{channel=2}); -- game
audio.setVolume(0.5,{channel=3}); -- help
audio.setVolume(0.5,{channel=4}); -- highscores
audio.setVolume(0.5,{channel=5}); -- credits
audio.setVolume(0.5,{channel=6}); -- scamper sound
audio.setVolume(0.4,{channel=7}); -- lose life
audio.setVolume(0.5,{channel=8}); -- banana caught

-- system events
local function onSystemEvent( event )
        
    local eventType = event.type
    
    if ( eventType == "applicationStart" ) then
        -- Occurs when the application is launched and all code in "main.lua" is executed
    elseif ( eventType == "applicationExit" ) then
        -- Occurs when the user or OS task manager quits the application
    elseif ( eventType == "applicationSuspend" ) then
        -- Perform all necessary actions for when the device suspends the application, i.e. during a phone call
    elseif ( eventType == "applicationResume" ) then
        -- Perform all necessary actions for when the app resumes from a suspended state
    end
end
Runtime:addEventListener( "system", onSystemEvent )

-- recycle on scene change
composer.recycleOnSceneChange = true

-- Go to the menu screen
composer.gotoScene( "menu" )

