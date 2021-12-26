function LF:MPlusSearch()
    local index = 0
    while EJ_GetInstanceByIndex(index, false) ~= nil do -- for each instance

        if not self:IsBlacklisted("m+", index) then

            local instanceID, instancename = EJ_GetInstanceByIndex(index, false)
            EJ_SelectInstance(instanceID)

            for i=1, EJ_GetNumLoot() do
                local itemInfo = C_EncounterJournal.GetLootInfoByIndex(i)
                if not itemInfo.link then
                    i = i - 1 -- item not loaded, step back
                elseif self:FilterCheck(itemInfo.link) then
                    self:AddResult("instance", instancename, bossname,iteminfo.link)
                end
            end
        end
        index = index + 1
    end
-----------------------------------------------------------------------------------------------------------
-- LootFinder.selectedstats

end