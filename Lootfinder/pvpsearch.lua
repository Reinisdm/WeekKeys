local pvp_gear_list = {
    185125,
    185314,
    185202,
    185316,
    185199,
    185200,
    185315,
    185312,
    185301,
    185201,
    185317,
    185300,
    185203,
    185126,
    185177,
    185258,
    185186,
    185267,
    185165,
    185246,
    185193,
    185274,
    185175,
    185256,
    185189,
    185270,
    185181,
    185262,
    185170,
    185251,
    185198,
    185279,
    185283,
    185164,
    185245,
    185280,
    185313,
    185192,
    185273,
    185281,
    185304,
    185306,
    185305,
    185197,
    185278,
    185282
}
--[[
    for i = 1, GetMerchantNumItems() do
        local link = GetMerchantItemLink(i)
        local name = GetMerchantItemInfo(i)
        local itemType, itemSubType, _, _, iconID, _, classID, subclassID = select(6, GetItemInfo(link))
        testDB[#testDB + 1] = {
            itemlink = link,
            name = name,
            itemType = itemType,
            itemSubType = itemSubType,
            iconID = iconID,
            classID = classID,
            subclassID = subclassID
        }
    end
--]]

local pvprank = {
    6628, -- unranked
    6627, -- Combatant
    6626, -- Challenger
    6625, -- Rival
    6623, -- Duelist
    6624  -- Elite
}

local rating = {
    "0-1399",
    "1400-1599",
    "1600-1799",
    "1800-2099",
    "2100+",
}

local pvpilvl = {
    220,  -- unranked
    226,  -- Combatant
    233,  -- Challenger
    240,  -- Rival
    246,  -- Duelist
}
function LF:PvPSearch()
    for _, id in ipairs(pvp_gear_list) do
        table.wipe(itemtstats) -- wipe previous results
            local itemlink, _,_,_,_,_,_,itemtype, icon, _, classID, subclassID = select(2, GetItemInfo(id))
            local pvprating = rating[LootFinder.pvptier]
            if itemtype == "INVTYPE_NECK" and LootFinder.slot == 1 then
                local link = itemlink:gsub("%d+:%d+:::::","60:258::14:3:".. pvprank[LootFinder.pvptier] ..":"..(1272 + pvpilvl[LootFinder.pvptier]) .. ":6646:1:28:807:::")

                --add or not to lootlist
                itemtstats = GetItemStats(link, itemtstats)
                --if #LootFinder.stats > 0 then
                if getsize() > 1 then
                    local count = 0
                    for key, _ in pairs(LootFinder.stats) do
                        if  itemtstats[key] then
                            count = count + 1
                        end
                    end
                    if count >= 2 then
                        LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                        link, icon, itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                                    itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                    itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                    end
                elseif getsize() == 1 then
                    for key, _ in pairs(LootFinder.stats) do
                        if itemtstats[key] then
                            LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                            link, icon, itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                                    itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                    itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                            break
                        end
                    end
                else
                    LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                    link, icon,
                            itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                            itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                            itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                end
            elseif itemtype == "INVTYPE_FINGER" and LootFinder.slot == 12 then
                    local link = itemlink:gsub("%d+:%d+:::::","60:258::14:3:".. pvprank[LootFinder.pvptier] ..":"..(1272 + pvpilvl[LootFinder.pvptier]) .. ":6646:1:28:807:::")


                    --add or not to lootlist
                    itemtstats = GetItemStats(link, itemtstats)
                    --if #LootFinder.stats > 0 then
                    if getsize() > 1 then
                        local count = 0
                        for key, _ in pairs(LootFinder.stats) do
                            if  itemtstats[key] then
                                count = count + 1
                            end
                        end
                        if count >= 2 then
                            LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                            link, icon, itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                                        itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                        itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                        end
                    elseif getsize() == 1 then
                        for key, _ in pairs(LootFinder.stats) do
                            if itemtstats[key] then
                                LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                                link, icon, itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                                        itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                        itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                                break
                            end
                        end
                    else
                        LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                        link, icon,
                                itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                                itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                    end
            elseif itemtype == "INVTYPE_TRINKET" and LootFinder.slot == 13 then
                local link = itemlink:gsub("%d+:%d+:::::","60:258::14:3:".. pvprank[LootFinder.pvptier] ..":"..(1272 + pvpilvl[LootFinder.pvptier]) .. ":6646:1:28:807:::")


                --add or not to lootlist
                itemtstats = GetItemStats(link, itemtstats)
                --if #LootFinder.stats > 0 then
                if getsize() > 1 then
                    local count = 0
                    for key, _ in pairs(LootFinder.stats) do
                        if  itemtstats[key] then
                            count = count + 1
                        end
                    end
                    if count >= 2 then
                        LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                        link, icon, itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                                    itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                    itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                    end
                elseif getsize() == 1 then
                    for key, _ in pairs(LootFinder.stats) do
                        if itemtstats[key] then
                            LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                            link, icon, itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                                    itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                    itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                            break
                        end
                    end
                else
                    LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                    link, icon,
                            itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                            itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                            itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                end
            elseif itemtype == "INVTYPE_SHIELD" and LootFinder.slot == 11 and (shields[LootFinder.spec] or (LootFinder.spec == 0 and shields[LootFinder.class])) then
                local link = itemlink:gsub("%d+:%d+:::::","60:258::14:3:".. pvprank[LootFinder.pvptier] ..":"..(1272 + pvpilvl[LootFinder.pvptier]) .. ":6646:1:28:807:::")


                --add or not to lootlist
                itemtstats = GetItemStats(link, itemtstats)
                --if #LootFinder.stats > 0 then
                if getsize() > 1 then
                    local count = 0
                    for key, _ in pairs(LootFinder.stats) do
                        if  itemtstats[key] then
                            count = count + 1
                        end
                    end
                    if count >= 2 then
                        LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                        link, icon, itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                                    itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                    itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                    end
                elseif getsize() == 1 then
                    for key, _ in pairs(LootFinder.stats) do
                        if itemtstats[key] then
                            LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                            link, icon, itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                                    itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                    itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                            break
                        end
                    end
                else
                    LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                    link, icon,
                            itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                            itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                            itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                end
            elseif itemtype == "INVTYPE_HOLDABLE" and LootFinder.slot == 11 and (offhand[LootFinder.spec] or (LootFinder.spec == 0 and offhand[LootFinder.class])) then
                local link = itemlink:gsub("%d+:%d+:::::","60:258::14:3:".. pvprank[LootFinder.pvptier] ..":"..(1272 + pvpilvl[LootFinder.pvptier]) .. ":6646:1:28:807:::")


                --add or not to lootlist
                itemtstats = GetItemStats(link, itemtstats)
                --if #LootFinder.stats > 0 then
                if getsize() > 1 then
                    local count = 0
                    for key, _ in pairs(LootFinder.stats) do
                        if  itemtstats[key] then
                            count = count + 1
                        end
                    end
                    if count >= 2 then
                        LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                        link, icon, itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                                    itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                    itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                    end
                elseif getsize() == 1 then
                    for key, _ in pairs(LootFinder.stats) do
                        if itemtstats[key] then
                            LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                            link, icon, itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                                    itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                    itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                            break
                        end
                    end
                else
                    LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                    link, icon,
                            itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                            itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                            itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                end
            elseif (itemtype == "INVTYPE_CHEST" or itemtype == "INVTYPE_ROBE") and LootFinder.slot == 4 and subclassID == gear_type[LootFinder.class] then

                local link = itemlink:gsub("%d+:%d+:::::","60:258::14:3:".. pvprank[LootFinder.pvptier] ..":"..(1272 + pvpilvl[LootFinder.pvptier]) .. ":6646:1:28:807:::")


                --add or not to lootlist
                itemtstats = GetItemStats(link, itemtstats)
                --if #LootFinder.stats > 0 then
                if getsize() > 1 then
                    local count = 0
                    for key, _ in pairs(LootFinder.stats) do
                        if  itemtstats[key] then
                            count = count + 1
                        end
                    end
                    if count >= 2 then
                        LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                        link, icon, itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                                    itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                    itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                    end
                elseif getsize() == 1 then
                    for key, _ in pairs(LootFinder.stats) do
                        if itemtstats[key] then
                            LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                            link, icon, itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                                    itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                    itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                            break
                        end
                    end
                else
                    LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                    link, icon,
                            itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                            itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                            itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                end
            elseif itemtype == "INVTYPE_CLOAK" and LootFinder.slot == 3 then
                local link = itemlink:gsub("%d+:%d+:::::","60:258::14:3:".. pvprank[LootFinder.pvptier] ..":"..(1272 + pvpilvl[LootFinder.pvptier]) .. ":6646:1:28:807:::")


                --add or not to lootlist
                itemtstats = GetItemStats(link, itemtstats)
                --if #LootFinder.stats > 0 then
                if getsize() > 1 then
                    local count = 0
                    for key, _ in pairs(LootFinder.stats) do
                        if  itemtstats[key] then
                            count = count + 1
                        end
                    end
                    if count >= 2 then
                        LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                        link, icon, itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                                    itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                    itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                    end
                elseif getsize() == 1 then
                    for key, _ in pairs(LootFinder.stats) do
                        if itemtstats[key] then
                            LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                            link, icon, itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                                    itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                    itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                            break
                        end
                    end
                else
                    LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                    link, icon,
                            itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                            itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                            itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                end


            elseif classID == 4 and subclassID == gear_type[LootFinder.class] and itemtype:find(slotids[LootFinder.slot] or "") then
                local link = itemlink:gsub("%d+:%d+:::::","60:258::14:3:".. pvprank[LootFinder.pvptier] ..":"..(1272 + pvpilvl[LootFinder.pvptier]) .. ":6646:1:28:807:::")


                --add or not to lootlist
                itemtstats = GetItemStats(link, itemtstats)
                --if #LootFinder.stats > 0 then

                if getsize() > 1 then
                    local count = 0
                    for key, _ in pairs(LootFinder.stats) do
                        if  itemtstats[key] then
                            count = count + 1
                        end
                    end
                    if count >= 2 then
                        LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                        link, icon, itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                                    itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                    itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                    end
                elseif getsize() == 1 then
                    for key, _ in pairs(LootFinder.stats) do
                        if itemtstats[key] then
                            LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                            link, icon, itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                                    itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                    itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                            break
                        end
                    end
                else
                    LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                    link, icon,
                            itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                            itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                            itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                end

            elseif classID == 2 and LootFinder.slot == 10 and (weapons[subclassID][LootFinder.spec] or (LootFinder.spec == 0 and weapons[subclassID][LootFinder.class])) then
                local link = itemlink:gsub("%d+:%d+:::::","60:258::14:3:".. pvprank[LootFinder.pvptier] ..":"..(1272 + pvpilvl[LootFinder.pvptier]) .. ":6646:1:28:807:::")


                --add or not to lootlist
                itemtstats = GetItemStats(link, itemtstats)
                --if #LootFinder.stats > 0 then

                if spec_main_atr[LootFinder.spec] and itemtstats[spec_main_atr[LootFinder.spec]] then
                    if getsize() > 1 then
                        local count = 0
                        for key, _ in pairs(LootFinder.stats) do
                            if  itemtstats[key] then
                                count = count + 1
                            end
                        end
                        if count >= 2 then
                            LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                            link, icon, itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                                        itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                        itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                        end
                    elseif getsize() == 1 then
                        for key, _ in pairs(LootFinder.stats) do
                            if itemtstats[key] then
                                LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                                link, icon, itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                                        itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                        itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                                break
                            end
                        end
                    else
                        LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                        link, icon,
                                itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                                itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                    end
                elseif LootFinder.spec == 0 and LootFinder.class > 0 then
                    for _, spec in pairs(LootFinder.class_spec[LootFinder.class]) do
                        if spec_main_atr[spec] and itemtstats[spec_main_atr[spec]] then
                            if getsize() > 1 then
                                local count = 0
                                for key, _ in pairs(LootFinder.stats) do
                                    if  itemtstats[key] then
                                        count = count + 1
                                    end
                                end
                                if count >= 2 then
                                    LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                                    link, icon, itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                                                itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                                itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                                end
                            elseif getsize() == 1 then
                                for key, _ in pairs(LootFinder.stats) do
                                    if itemtstats[key] then
                                        LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                                        link, icon, itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                                                itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                                itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                                        break
                                    end
                                end
                            else
                                LootFinder:AddResult("pvp", PLAYER_V_PLAYER, pvprating,
                                link, icon,
                                        itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0,
                                        itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                        itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                            end
                            break
                        end
                    end
                end
            end
    end
end