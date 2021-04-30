local M = {}
M.score = 0

-- options
function M.init(options)

    local custom_options = options or {}
    local option = {}

    option.fontSize = custom_options.fontSize or 40
    option.font = custom_options.font or "Matura MT Script Capitals"
    option.x = custom_options.x or 80
    option.y = custom_options.y or 280
    option.maxDigits = custom_options.maxDigits or 6

    local prefix = ""
    M.format = "%" .. prefix .. option.maxDigits .. "d"

    M.scoreText = display.newText( string.format ( M.format, 0 ), option.x, option.y, option.font, option.fontSize );

    return M.scoreText
end

-- update score
function M.set(value)
    M.score = tonumber(value)
    M.scoreText.text = string.format(M.format, M.score)
end

--[[ -- get current score
function M.get()
    return M.score
end

-- add to score
function M.add(amount)
    M.score = M.score + tonumber(amount)
    M.scoreText.text = string.format(M.format, M.score)
end

-- save score
function M.save()
    local saved = system.setPreferences( "app", {currentScore = M.score} )
    print(currentScore)
    if (saved == false) then
        print("Error, could not save score.")
    end
end

-- load score
function M.load()
    local score = system.getPreference( "app", "currentScore", "number" );

    if (score) then
        return tonumber(score)
    else
        print( "Error: could not load score (score may no longer exist in storage)" )
    end
end ]]

return M