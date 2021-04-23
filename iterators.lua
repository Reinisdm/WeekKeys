-- my future loop iterators :D

WeekKeys.Iterators = {}
local Iterators = WeekKeys.Iterators

--- Return iterator to 'for ... in' loop
---@param list table @table with player data
---@param writeRealm boolean @bool write (*) or not
---@return function @loop iterator
function Iterators.FormatPlayerList(list,writeRealm)

    if #list == 0 then return function() end end

    local _, realm = UnitFullName("player")
    realm = realm or GetRealmName() or ""
    realm = realm:gsub(" ","")

    local i = 0
    ---'for ... in' iterator
    ---@return number i
    ---@return string faction @"A" or "H"
    ---@return number covenantID
    ---@return string colored_nickname @ |cffrrggbbNICKNAME|r (*),
    ---@return string realm
    ---@return number ilvl
    ---@return string record @??/??/?? or ??/?? or ??
    ---@return string keystone @Keystone name(lvl)
    ---@return boolean reward @have keystone reward or no
    return function()
        i = i + 1
        local char = list[i]
        if not char then return end

        local _, classFile, _ = GetClassInfo(char.classID)
        local _, _, _, argbHex = GetClassColor(classFile)
        local colored_nickname = "|c"..argbHex..char.name.."|r"
        if writeRealm and char.realm ~= realm then
            colored_nickname = colored_nickname .. "(*)"
        end

        local keystone = ""
        if char.keyID then
            keystone = string.format("%s (%d)",C_ChallengeMode.GetMapUIInfo(char.keyID), char.keyLevel)
            -- add icon if instance have covenant bonuss
            if char.keyID == 375 or char.keyID == 377 then
                keystone = "|Tinterface/icons/ui_sigil_nightfae.blp:20:20|t" .. keystone
            elseif char.keyID == 376 or char.keyID == 381 then
                keystone = "|Tinterface/icons/ui_sigil_kyrian.blp:20:20|t" .. keystone
            elseif char.keyID == 378 or char.keyID == 380 then
                keystone =  "|Tinterface/icons/ui_sigil_venthyr.blp:20:20|t" .. keystone
            elseif char.keyID == 379 or char.keyID == 382 then
                keystone =  "|Tinterface/icons/ui_sigil_necrolord.blp:20:20|t" .. keystone
            end
        end

        return i, char.faction, char.covenant, colored_nickname, char.realm, char.ilvl, char.record, keystone, char.reward
    end
end

function Iterators.FormatPlayerByIDList(db,list)
    -- don't loop
    if not db or #list == 0 then return function() end end

    -- get realm 
    local _, realm = UnitFullName("player")
    realm = realm or GetRealmName() or ""
    realm = realm:gsub(" ","")

    local i = 0
    return function()
        i = i + 1
        local db_index = list[i]
        local char = db[db_index]
        --get class hexcodes
        local _, classFile, _ = GetClassInfo(char.classID)
        local _, _, _, argbHex = GetClassColor(classFile)
        local colored_nickname = "|c"..argbHex..char.name.."|r"

        local keystone = ""
        if char.keyID then
            keystone = string.format("%s (%d)",C_ChallengeMode.GetMapUIInfo(char.keyID), char.keyLevel)
            -- add icon if instance have covenant bonuss
            if char.keyID == 375 or char.keyID == 377 then
                keystone = "|Tinterface/icons/ui_sigil_nightfae.blp:20:20|t" .. keystone
            elseif char.keyID == 376 or char.keyID == 381 then
                keystone = "|Tinterface/icons/ui_sigil_kyrian.blp:20:20|t" .. keystone
            elseif char.keyID == 378 or char.keyID == 380 then
                keystone =  "|Tinterface/icons/ui_sigil_venthyr.blp:20:20|t" .. keystone
            elseif char.keyID == 379 or char.keyID == 382 then
                keystone =  "|Tinterface/icons/ui_sigil_necrolord.blp:20:20|t" .. keystone
            end
        end
        return i, char.faction, char.covenant, colored_nickname, char.realm, char.ilvl, char.record, keystone, char.reward
    end
end
