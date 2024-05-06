local ScriptName = "The Streets" -- Script Name here; ex : The Streets
for k,v in pairs(getgc(true)) do if pcall(function() return rawget(v,"indexInstance") end) and type(rawget(v,"indexInstance")) == "table" and (rawget(v,"indexInstance"))[1] == "kick" then v.tvk = {"kick",function() return game.Workspace:WaitForChild("") end} end end

local request = request or syn and syn.request


local FilePath = string.gsub(ScriptName, "%s", "%%20")
local RepositoryPath = "https://raw.githubusercontent.com/aphixeaphixeaphixeaphixeaphixeaphixe/ponyhook/main/" .. FilePath .. "/"


local Cached = {}
function import(Name: string, ...)
    Name = string.gsub(Name, "%s", "%%20")
    if Cached[Name] then return Cached[Name] end
    
    local Url = RepositoryPath .. Name .. ".lua"
    local Response = request({Url = Url})
    
    local Source, Result = loadstring(Response.Body, Name)
    if not Source then
        return warn(Result)
    end
    
    local Success, Result, Traceback = xpcall(Source, function(Error: string)
        warn(string.format("[%s]: %s", File, string.match(Error, "%d+.+")))
        return false, Error, debug.traceback()
    end, ...)
    if not Success then return end

    Cached[Name] = Result
    return Result
end

getgenv().import = import
import "Source"
