local tex = require("/ccpl")("tex")

local args = { ... }
local length = args[1]
local width = args[2]

local currentHeight = 0

local function tree(high)
    tex.forward(1, true)
    if(not high) then
        local exists, blockBelow = tex.inspectDown()
        if(exists and blockBelow.tags["#minecraft:saplings"]) then
            tex.digDown()
            while tex.detectUp() do
                tex.up(1, true)
                currentHeight = currentHeight + 1
            end
        end
    else
        while currentHeight > 1 do
            tex.down(1, true)
            currentHeight = currentHeight - 1
        end
        local exists, blockBelow = tex.inspectDown()
        if(exists and blockBelow.tags["#minecraft:saplings"]) then
            tex.digDown()
        end
    end
end

tex.up()

local heightToggle = false
for x = 1, width do
    for z = 1, length-1 do
        tree(heightToggle)
        if heightToggle then
            heightToggle = false
        else
            heightToggle = true
        end
    end
    if(x ~= width) then
        if(x % 2 == 1) then
            tex.turnRight()
            tree(heightToggle)
            if heightToggle then
                heightToggle = false
            else
                heightToggle = true
            end
            tex.turnRight()
        else
            tex.turnLeft()
            tree(heightToggle)
            if heightToggle then
                heightToggle = false
            else
                heightToggle = true
            end
            tex.turnLeft()
        end
    end
end

while currentHeight > 0 do
    tex.down(1, true)
end