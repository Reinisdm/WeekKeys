
 local TorghastInfo
 local TorghastWidgets = {
    {nameID = 2925, levelID = 2930}, -- Fracture Chambers
    {nameID = 2926, levelID = 2932}, -- Skoldus Hall
    {nameID = 2924, levelID = 2934}, -- Soulforges
    {nameID = 2927, levelID = 2936}, -- Coldheart Interstitia
    {nameID = 2928, levelID = 2938}, -- Mort'regar
    {nameID = 2929, levelID = 2940}, -- The Upper Reaches
 }
local tbl = {}
function WeekKeys.PlayerData()
    if UnitLevel("player") == 60 then
        -------------------
        -- name, realm
        -------------------
        local name, realm = UnitFullName("player") -- player name
        realm = realm or GetRealmName() or ""
        realm = realm:gsub(" ","")
        tbl.name = name
        tbl.realm = realm

        -------------------
        -- ilvl
        -------------------
        local _, ilvl = GetAverageItemLevel() -- equipeed ilvl
        ilvl = math.floor(ilvl)
        tbl.ilvl = ilvl

        --------------------
        -- faction
        -------------------
        local faction
        if UnitFactionGroup("player") == "Alliance" then
            faction = "A" -- A -> Alliance
        else
            faction = "H" -- H -> Horde
        end
        tbl.faction = faction


        ----------------------
        -- classID
        ----------------------
        local _, classname, classID = UnitClass("player")
        if not classID then
            classFilename, classID = UnitClassBase("player")
        end
        tbl.classID = classID


        -----------------------
        -- record
        -----------------------
        local record = C_MythicPlus.GetWeeklyChestRewardLevel()
        local recordtable = C_MythicPlus.GetRunHistory(false,true)
        table.sort(recordtable, function(a,b)
            return a.level > b.level
        end)
        -- C_PlayerInfo.MythicPlusRatingSummary
        if #recordtable >= 10 then
            record = recordtable[1].level .. "/" .. recordtable[4].level .. "/" .. recordtable[8].level
        elseif #recordtable >= 4 then
            record = recordtable[1].level .. "/" .. recordtable[4].level
        elseif #recordtable >= 1 then
            record = recordtable[1].level
        end
        tbl.record = record

        ------------------------
        -- keystone info
        ------------------------

        local keyID = C_MythicPlus.GetOwnedKeystoneChallengeMapID()
        local keyLevel = C_MythicPlus.GetOwnedKeystoneLevel()
        tbl.keyID = keyID
        tbl.keyLevel = keyLevel

        -----------------------
        -- covenant ID
        -----------------------
        local covenantID = C_Covenants.GetActiveCovenantID()
        tbl.covenant = covenantID


        if not C_MythicPlus.IsWeeklyRewardAvailable() then
            WeekKeys.DB.RemoveReward()
        end
        -----------------------
        -- M+ score
        -----------------------

        tbl.mscore = C_PlayerInfo.GetPlayerMythicPlusRatingSummary("player").currentSeasonScore
        --[[ mythic score?
            C_PlayerInfo.GetPlayerMythicPlusRatingSummary(name).currentSeasonScore
            C_PlayerInfo.GetPlayerMythicPlusRatingSummary("target").currentSeasonScore
            C_PlayerInfo.GetPlayerMythicPlusRatingSummary("player").currentSeasonScore
        ]]


        ---------------------
        -- torghast
        ---------------------
        local torghast_number = 1

        if not TorghastInfo then
            TorghastInfo = C_AreaPoiInfo.GetAreaPOIInfo(1543, 6640)
        end

        if TorghastInfo and C_QuestLog.IsQuestFlaggedCompleted(60136) then
            local torghastHeader
            for _, value in pairs(TorghastWidgets) do
                local nameInfo = C_UIWidgetManager.GetTextWithStateWidgetVisualizationInfo(value.nameID)
                if nameInfo and nameInfo.shownState == 1 then
                    local nameText = nameInfo.text
                    local levelInfo = C_UIWidgetManager.GetTextWithStateWidgetVisualizationInfo(value.levelID)
                    local levelText = AVAILABLE
                    if levelInfo and levelInfo.shownState == 1 then levelText = (levelInfo.text) end

                    WeekKeys.DB.InsertTorghast(WeekKeysDB.Characters,name,realm,"torghast"..torghast_number,levelText:gsub("|r",""):gsub("|n",""):gsub("|c........",""):match("%d+"))
                    torghast_number = torghast_number + 1

                end
            end
        end
        if IsInGuild() then
            local astralweeks
            local time
            if GetCurrentRegion() == 3 then -- if in EU region
                astralweeks = math.floor((GetServerTime() - 1500447600) / 604800) 
                time = math.floor((GetServerTime() - 1500447600) % 604800) 
            else -- if not EU region
                astralweeks = math.floor((GetServerTime() - 1500390000) / 604800)
                time = math.floor((GetServerTime() - 1500390000) % 604800)
            end
            if recordtable and recordtable[1] then
                WeekKeys:SendCommMessage("AstralKeys","sync5 "..name.."-"..realm..":"..classname..":"..(keyID or "")..":"..(keyLevel or "")..":"..(recordtable[1].level or "0")..":"..astralweeks..":"..time,"GUILD")
            else
                WeekKeys:SendCommMessage("AstralKeys","sync5 "..name.."-"..realm..":"..classname..":"..(keyID or "")..":"..(keyLevel or "")..":0:"..astralweeks..":"..time,"GUILD")
            end
        end
        WeekKeys.DB.SaveTable(WeekKeysDB.Characters,tbl)
        table.wipe(tbl)
        --WeekKeys.DB.SaveVars2(WeekKeysDB.Characters,name,realm,classID,ilvl,record,keyID,keyLevel,faction,covenantID)
        return name, realm, classID, ilvl, record, keyID, keyLevel, faction, covenantID
    end
end
