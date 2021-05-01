--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:684735be06f4ba63742650edb4769961:753a79db5b8233220bef0314e2d1857a:cac907f6d2e014dd81be79062b98c18f$
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
            -- walking_right_1
            x=579,
            y=1,
            width=186,
            height=306,

            sourceX = 35,
            sourceY = 10,
            sourceWidth = 280,
            sourceHeight = 336
        },
        {
            -- walking_right_2
            x=1,
            y=1,
            width=186,
            height=310,

            sourceX = 35,
            sourceY = 6,
            sourceWidth = 280,
            sourceHeight = 336
        },
        {
            -- walking_right_3
            x=377,
            y=1,
            width=200,
            height=306,

            sourceX = 35,
            sourceY = 10,
            sourceWidth = 280,
            sourceHeight = 336
        },
        {
            -- walking_right_4
            x=189,
            y=1,
            width=186,
            height=310,

            sourceX = 35,
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

    ["walking_right_1"] = 1,
    ["walking_right_2"] = 2,
    ["walking_right_3"] = 3,
    ["walking_right_4"] = 4,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
