local complete = require("cc.shell.completion")
local CCPLPath = settings.get("ccpl.path"):sub(2)

local function fileIf(theShell, thisArg, prevArgs, text)
    if prevArgs[2] == text then
        return complete.file(theShell, thisArg)
    end
end

-- programs/gist.lua
shell.setCompletionFunction(CCPLPath.."ccpl/programs/gist.lua",complete.build(
    { complete.choice, {"install ", "update "} },
    { fileIf, "update " }
))

--programs/farm.lua
shell.setCompletionFunction(CCPLPath.."ccpl/programs/farm.lua",complete.build({ complete.choice, {"create ", "harvest "} }))

local function printCompletion(theShell, argument, prevArgs)
    for _, theArg in ipairs(prevArgs) do
        term.write(theArg.." ")
    end
    print()
    if #prevArgs == 0 then
        return complete.choice(theShell, argument, prevArgs, { "scan ", "print " })
    elseif prevArgs[1] == "print" or (prevArgs[1] == "scan" and #prevArgs == 4) then
        return complete.file(theShell, argument)
    end
end
--programs/3dprint.lua
shell.setCompletionFunction(CCPLPath.."ccpl/programs/3dprint.lua",complete.build({ printCompletion, many=true }))
