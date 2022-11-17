

function WeekKeys:ADDON_LOADED(eve,addon) -- insert keystone
    if addon == "Blizzard_ChallengesUI" or eve == "Blizzard_ChallengesUI" then
        hooksecurefunc(ChallengesKeystoneFrame,"Show",function()
            for container = 0, 4 do
                for slot=1, C_Container.GetContainerNumSlots(container) do
                    local link = C_Container.GetContainerItemLink(container, slot)
                    if link and link:find("keystone") then
                        PickupContainerItem(container, slot)
                        if (CursorHasItem()) then
                            C_ChallengeMode.SlotKeystone()
                        end
                    end
                end
            end
        end)
    end
end
function WeekKeys:PLAYER_ENTERING_WORLD()
    C_MythicPlus.RequestRewards()
end
function WeekKeys:CHALLENGE_MODE_MAPS_UPDATE()
    WeekKeys.PlayerData()
end

function WeekKeys:CHAT_MSG_PARTY(msg,arg1)
    if msg:find("CHAT_MSG_PARTY") then msg = arg1 end
    if WeekKeysDB.Settings.pkeyslink and string.lower(msg) == "!keys" then
        for container = 0, 4 do
            for slot=1, C_Container.GetContainerNumSlots(container) do
                local item = C_Container.GetContainerItemLink(container, slot)
                if item and item:match("|Hkeystone:") then
                    SendChatMessage("WeekKeys "..item,"party")
                end
            end
        end
    elseif WeekKeysDB.Settings.covenant and (string.lower(msg) == "!covenant" or string.lower(msg) == "!cov") then
        local data = C_Covenants.GetCovenantData(C_Covenants.GetActiveCovenantID())
        if not data then return end
		SendChatMessage("WeekKeys: "..data.textureKit.." - "..data.name,"party")
    end
end

function WeekKeys:CHAT_MSG_INSTANCE_CHAT(msg,arg1)
    if msg:find("CHAT_MSG_INSTANCE_CHAT") then msg = arg1 end
    if WeekKeysDB.Settings.covenant and (string.lower(msg) == "!covenant" or string.lower(msg) == "!cov") then
        local data = C_Covenants.GetCovenantData(C_Covenants.GetActiveCovenantID())
        if not data then return end
		SendChatMessage("WeekKeys: "..data.textureKit.." - "..data.name,"INSTANCE_CHAT")
    end
end
--C_ChallengeMode.GetMapUIInfo(C_LFGList.GetOwnedKeystoneActivityAndGroupAndLevel(true))
--C_LFGList.GetOwnedKeystoneActivityAndGroupAndLevel(true)

function WeekKeys:CHAT_MSG_LOOT() -- looting weekly chest
    C_Timer.After(1,function()
        C_MythicPlus.RequestRewards()
        C_MythicPlus.RequestMapInfo()
    end)
end

function WeekKeys:MYTHIC_PLUS_CURRENT_AFFIX_UPDATE()
    WeekKeys.Affixes.init()
end
