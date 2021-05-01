--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:445862dd4e165c3b78f60632271d2d3e:2234890035e324bba404779fa387e451:cac907f6d2e014dd81be79062b98c18f$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- walking_left_1
            x=579,
            y=1,
            width=186,
            height=306,

            sourceX = 59,
            sourceY = 10,
            sourceWidth = 280,
            sourceHeight = 336
        },
        {
            -- walking_left_2
            x=1,
            y=1,
            width=186,
            height=310,

            sourceX = 59,
            sourceY = 6,
            sourceWidth = 280,
            sourceHeight = 336
        },
        {
            -- walking_left_3
            x=377,
            y=1,
            width=200,
            height=306,

            sourceX = 45,
            sourceY = 10,
            sourceWidth = 280,
            sourceHeight = 336
        },
        {
            -- walking_left_4
            x=189,
            y=1,
            width=186,
            height=310,

            sourceX = 59,
            sourceY = 6,
            sourceWidth = 280,
            sourceHeight = 336
        },
    },

    sheetContentWidth = 766,
    sheetContentHeight = 312
}

SheetInfo.frameIndex =
{

    ["walking_left_1"] = 1,
    ["walking_left_2"] = 2,
    ["walking_left_3"] = 3,
    ["walking_left_4"] = 4,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
