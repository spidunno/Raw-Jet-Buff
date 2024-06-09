
local ____modules = {}
local ____moduleCache = {}
local ____originalRequire = require
local function require(file, ...)
    if ____moduleCache[file] then
        return ____moduleCache[file].value
    end
    if ____modules[file] then
        local module = ____modules[file]
        ____moduleCache[file] = { value = (select("#", ...) > 0) and module(...) or module(file) }
        return ____moduleCache[file].value
    else
        if ____originalRequire then
            return ____originalRequire(file)
        else
            error("module '" .. file .. "' not found")
        end
    end
end
____modules = {
["src.util"] = function(...) 
local ____exports = {}
____exports.RAW_JET = "PFB_JetEngine [Server]"
____exports.DEFAULT_STRENGTH = 2250
return ____exports
 end,
["src.main"] = function(...) 
local ____exports = {}
local ____util = require("src.util")
local RAW_JET = ____util.RAW_JET
local DEFAULT_STRENGTH = ____util.DEFAULT_STRENGTH
_G.update = function()
    local players = tm.players:CurrentPlayers()
    for ____, ____value in ipairs(players) do
        local playerId = ____value.playerId
        local structures = tm.players:GetPlayerStructuresInBuild(playerId)
        for ____, structure in ipairs(structures) do
            local blocks = structure:GetBlocks()
            for ____, block in ipairs(blocks) do
                local blockName = block:GetName()
                if blockName == RAW_JET then
                    block:SetJetPower(DEFAULT_STRENGTH)
                end
            end
        end
    end
end
return ____exports
 end,
}
return require("src.main", ...)
