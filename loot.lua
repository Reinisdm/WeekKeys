LootFinder = LootFinder or {}

--[[
    GetMerchantNumItems()
    link = GetMerchantItemLink(index);
    name, texture, price, quantity, numAvailable, isPurchasable, isUsable, extendedCost = GetMerchantItemInfo(index)
    itemType, itemSubType, _, _, iconID, _, classID, subclassID = select(6, GetItemInfo(itemID))
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

    {id, itemID
    mainstat 0/1/2/3
    slotID
}
]]
--[[
local spec_main_atr = {

        [71] = "ITEM_MOD_STRENGTH_SHORT", -- arms
        [72] = "ITEM_MOD_STRENGTH_SHORT", -- fury
        [73] = "ITEM_MOD_STRENGTH_SHORT", -- protection

        [65] = "ITEM_MOD_INTELLECT_SHORT", -- holy
        [66] = "ITEM_MOD_STRENGTH_SHORT", -- protection
        [70] = "ITEM_MOD_STRENGTH_SHORT",  -- retribution

        [253] = "ITEM_MOD_AGILITY_SHORT", -- beast mastery
        [254] = "ITEM_MOD_AGILITY_SHORT", -- marksmanship
        [255] = "ITEM_MOD_AGILITY_SHORT",  -- survival

        [259] = "ITEM_MOD_AGILITY_SHORT", -- assassination
        [260] = "ITEM_MOD_AGILITY_SHORT", -- outlaw
        [261] = "ITEM_MOD_AGILITY_SHORT",  -- subtlety

        [256] = "ITEM_MOD_INTELLECT_SHORT", -- discipline
        [257] = "ITEM_MOD_INTELLECT_SHORT", -- holy
        [258] = "ITEM_MOD_INTELLECT_SHORT",  -- shadow

        [250] = "ITEM_MOD_STRENGTH_SHORT", -- blood
        [251] = "ITEM_MOD_STRENGTH_SHORT", -- frost
        [252] = "ITEM_MOD_STRENGTH_SHORT", -- unholy

        [262] = "ITEM_MOD_INTELLECT_SHORT", -- elemental
        [263] = "ITEM_MOD_AGILITY_SHORT", -- enchancement
        [264] = "ITEM_MOD_INTELLECT_SHORT", -- restoration

        [62] = "ITEM_MOD_INTELLECT_SHORT", -- arcane
        [63] = "ITEM_MOD_INTELLECT_SHORT", -- fire
        [64] = "ITEM_MOD_INTELLECT_SHORT",  -- frost

        [265] = "ITEM_MOD_INTELLECT_SHORT", -- affliction
        [266] = "ITEM_MOD_INTELLECT_SHORT", -- demonology
        [267] = "ITEM_MOD_INTELLECT_SHORT", -- destruction

        [268] = "ITEM_MOD_AGILITY_SHORT", -- brewmaster
        [270] = "ITEM_MOD_INTELLECT_SHORT", -- mistweaver
        [269] = "ITEM_MOD_AGILITY_SHORT",  -- windwalker

        [102] = "ITEM_MOD_INTELLECT_SHORT", -- balance
        [103] = "ITEM_MOD_AGILITY_SHORT", -- feral
        [104] = "ITEM_MOD_AGILITY_SHORT", -- guardian
        [105] = "ITEM_MOD_INTELLECT_SHORT",  -- restororation

        [577] = "ITEM_MOD_AGILITY_SHORT", -- havoc
        [581] = "ITEM_MOD_AGILITY_SHORT"  -- vengeance
}
--itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,
->itemEquipLoc<- head/back/trinket/off,main hand


, itemTexture, sellPrice, classID, subclassID, bindType, expacID, setID, isCraftingReagent
   = GetItemInfo(itemInfo)
local spec_weapons = {

        [71] = {}, -- arms
        [72] = {}, -- fury
        [73] = {}, -- protection

        [65] = {}, -- holy
        [66] = {}, -- protection
        [70] = {},  -- retribution

        [253] = {}, -- beast mastery
        [254] = {}, -- marksmanship
        [255] = {},  -- survival

        [259] = {}, -- assassination
        [260] = {}, -- outlaw
        [261] = {},  -- subtlety

        [256] = {}, -- discipline
        [257] = {}, -- holy
        [258] = {},  -- shadow

        [250] = {}, -- blood
        [251] = {}, -- frost
        [252] = {}, -- unholy

        [262] = {}, -- elemental
        [263] = {}, -- enchancement
        [264] = {}, -- restoration

        [62] = {}, -- arcane
        [63] = {}, -- fire
        [64] = {},  -- frost

        [265] = {}, -- affliction
        [266] = {}, -- demonology
        [267] = {}, -- destruction

        [268] = {}, -- brewmaster
        [270] = {}, -- mistweaver
        [269] = {},  -- windwalker

        [102] = {}, -- balance
        [103] = {}, -- feral
        [104] = {}, -- guardian
        [105] = {},  -- restororation

        [577] = {}, -- havoc
        [581] = {}  -- vengeance
}

local function GetPrimaryStats(tbl)
    if LootFinder.spec ~= 0 then
        local main_atr = spec_main_atr[LootFinder.spec]
        tbl[main_atr] = true
        return
    elseif LootFinder.class ~= 0 then
        for _, value in ipairs(LootFinder.class_spec[LootFinder.class]) do
            local main_atr = spec_main_atr[value]
            tbl[main_atr] = true
        end
    end
end

--]]
LootFinder.class_spec = {
    [1] = { -- warrior
        71, -- arms
        72, -- fury
        73  -- protection
    },
    [2] = { -- paladin
        65, -- holy
        66, -- protection
        70  -- retribution
    },
    [3] = { -- hunter
        253, -- beast mastery
        254, -- marksmanship
        255  -- survival
    },
    [4] = { --  rogue
        259, -- assassination
        260, -- outlaw
        261  -- subtlety
    },
    [5] = { -- priest
        256, -- discipline
        257, -- holy
        258  -- shadow
    },
    [6] = { -- death knight
        250, -- blood
        251, -- frost
        252  -- unholy
    },
    [7] = { -- shaman
        262, -- elemental
        263, -- enchancement
        264  -- restoration
    },
    [8] = { -- mage
        62, -- arcane
        63, -- fire
        64  -- frost
    },
    [9] = { -- warlock
        265, -- affliction
        266, -- demonology
        267  -- destruction
    },
    [10] = { -- monk
        268, -- brewmaster
        270, -- mistweaver
        269  -- windwalker
    },
    [11] = { -- druid
        102, -- balance
        103, -- feral
        104, -- guardian
        105  -- restororation
    },
    [12] = { -- demon hunter
        577, -- havoc
        581  -- vengeance
    }
}

-- atr armor weapon
-- str {}    {}






local mythic_level = {
    6808, -- I know m+ id
    6808,-- index 2 -> mythic 2
    6809,
    7203,
    7204,
    7205,
    7206,
    7207,
    7208,
    7209,
    7210,
    7211,
    7212,
    7213,
    7214
}

LootFinder.class = 0
LootFinder.spec = 0
LootFinder.slot = 15
LootFinder.expansion = 9

LootFinder.instances = {}
LootFinder.milvl = 226
LootFinder.mlevel = 15

LootFinder.raids = {}
LootFinder.raid_difficult = 16

--[[
    LootFinder.raids = {}
    LootFinder.raid_difficult = 16
    14 - normal
    15 - heroic
    16 - mythic
    17 - looking for raid
]]

LootFinder.loot_list = {}
LootFinder.sort_by = false

LootFinder.stats = {}
--[[
    SPEC_FRAME_PRIMARY_STAT_STRENGTH    'ITEM_MOD_STRENGTH_SHORT'
    SPEC_FRAME_PRIMARY_STAT_AGILITY     'ITEM_MOD_AGILITY_SHORT'
    SPEC_FRAME_PRIMARY_STAT_INTELLECT   'ITEM_MOD_INTELLECT_SHORT'
    STAT_CRITICAL_STRIKE                'ITEM_MOD_CRIT_RATING_SHORT'
    STAT_HASTE                          'ITEM_MOD_HASTE_RATING_SHORT'
    STAT_VERSATILITY                    'ITEM_MOD_VERSATILITY'
    STAT_MASTERY                        'ITEM_MOD_MASTERY_RATING_SHORT'
]]
--- Add loot to list
---@param source string instance/raid
---@param name string instance name
---@param boss string boss name
---@param itemlink string itemlink
---@param icon integer iconID
---@param mainstat integer str/agi/int value
---@param crit integer crit value
---@param haste integer haste value
---@param mastery integer mastery value
---@param versality integer versality value
function LootFinder:AddResult(source, name, boss, itemlink, icon, mainstat, crit, haste, mastery, versality)
    local tbl = {source = source, name = name, boss = boss, itemlink = itemlink, icon = icon, mainstat = mainstat, crit = crit, haste = haste, mastery = mastery, versality = versality}
    LootFinder.loot_list[#LootFinder.loot_list+1] = tbl
end

---Get table size
---@param tbl table
---@return integer table_size
local function getsize(tbl)
    local size = 0
    for _, _ in pairs(tbl or LootFinder.stats) do
        size = size + 1
    end
    return size
end

local itemtstats = {}
--- Start find loot, results stored in Lootfinde.loot_list
function LootFinder:Find()
    EJ_SetDifficulty(23)
    --EJ_SelectTier(LootFinder.expansion)
    EJ_SetDifficulty(LootFinder.raid_difficult)
    if EncounterJournal_ListInstances then
        EncounterJournal_ListInstances()
    end
    self.class = self.class or 0
    self.spec = self.spec or 0
    self.slot = self.slot or 0
    EJ_SetLootFilter(self.class,self.spec )
    C_EncounterJournal.SetSlotFilter(self.slot)
    table.wipe(LootFinder.loot_list)

    -- instnaces
    local index = 1
    ---[[
    while EJ_GetInstanceByIndex(index, false) ~= nil do -- for each instance
        if LootFinder.instances[index] == nil then LootFinder.instances[index] = true end
        if LootFinder.instances[index] then -- if not black-listed
            local instanceID, instancename = EJ_GetInstanceByIndex(index, false) -- get instanceID and instance name
            EJ_SelectInstance(instanceID) -- select instance
            for i=1,EJ_GetNumLoot() do -- each loot
                table.wipe(itemtstats) -- wipe previous results
                local itemInfo = C_EncounterJournal.GetLootInfoByIndex(i) -- get loot info
                if not itemInfo.link then -- sometimes link is nil
                    i = i - 1
                else
                    --modify link
                    --if LootFinder.mlevel ~= 0 then
                        itemInfo.link = itemInfo.link:gsub("%d+:3524:%d+:%d+:%d+","5:"..mythic_level[max(LootFinder.mlevel,1)]..":6652:1501:"..(LootFinder.milvl + 5658)..":6646")
                    --end
                    --boss name
                    local bossname = EJ_GetEncounterInfo(itemInfo.encounterID)

                    --add or not to lootlist
                    itemtstats = GetItemStats(itemInfo.link, itemtstats)
                    --if #LootFinder.stats > 0 then
                    if getsize() > 1 then
                        local count = 0
                        for key, _ in pairs(LootFinder.stats) do
                            if  itemtstats[key] then
                                count = count + 1
                            end
                        end
                        if count >= 2 then
                            LootFinder:AddResult("instance", instancename, bossname,
                                        itemInfo.link, itemInfo.icon, itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0, 
                                        itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                        itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                        end
                    elseif getsize() == 1 then
                        for key, _ in pairs(LootFinder.stats) do
                            if itemtstats[key] then
                                LootFinder:AddResult("instance", instancename, bossname,
                                        itemInfo.link, itemInfo.icon, itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0, 
                                        itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                        itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                                break
                            end
                        end
                    else
                        LootFinder:AddResult("instance", instancename, bossname,
                                itemInfo.link, itemInfo.icon,
                                itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0, 
                                itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                    end
                end
            end -- for each loot
        end -- if not black lsited
        index = index + 1
    end -- for each instance
--]]
    -- raids
    EJ_SetDifficulty(LootFinder.raid_difficult)
    index = 1
    while EJ_GetInstanceByIndex(index, true) ~= nil do -- for each instance
        if LootFinder.raids[index] == nil then LootFinder.raids[index] = false end
        if LootFinder.raids[index] then -- if not black-listed
            local instanceID, instancename = EJ_GetInstanceByIndex(index, true) -- get instanceID and instance name
            EJ_SelectInstance(instanceID) -- select instance
            for i=1,EJ_GetNumLoot() do -- each loot
                table.wipe(itemtstats) -- wipe previous results
                local itemInfo = C_EncounterJournal.GetLootInfoByIndex(i) -- get loot info
                if not itemInfo.link then -- sometimes link is nil
                    i = i - 1
                else
                    --boss name
                    local bossname = EJ_GetEncounterInfo(itemInfo.encounterID)

                    --add or not to lootlist
                    itemtstats = GetItemStats(itemInfo.link, itemtstats)
                    --if #LootFinder.stats > 0 then
                    if getsize() > 1 then
                        local count = 0
                        for key, _ in pairs(LootFinder.stats) do
                            if  itemtstats[key] then
                                count = count + 1
                            end
                        end
                        if count >= 2 then
                            LootFinder:AddResult("raid", instancename, bossname,
                                        itemInfo.link, itemInfo.icon, itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0, 
                                        itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                        itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                        end
                    elseif getsize() == 1 then
                        for key, _ in pairs(LootFinder.stats) do
                            if itemtstats[key] then
                                LootFinder:AddResult("raid", instancename, bossname,
                                        itemInfo.link, itemInfo.icon, itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0, 
                                        itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                        itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                                break
                            end
                        end
                    else
                        LootFinder:AddResult("raid", instancename, bossname,
                                itemInfo.link, itemInfo.icon,
                                itemtstats.ITEM_MOD_STRENGTH_SHORT or itemtstats.ITEM_MOD_AGILITY_SHORT or itemtstats.ITEM_MOD_INTELLECT_SHORT or 0, 
                                itemtstats.ITEM_MOD_CRIT_RATING_SHORT or 0, itemtstats.ITEM_MOD_HASTE_RATING_SHORT or 0,
                                itemtstats.ITEM_MOD_MASTERY_RATING_SHORT or 0, itemtstats.ITEM_MOD_VERSATILITY or 0)
                    end
                end
            end -- for each loot
        end -- if not black lsited
        index = index + 1
    end -- for each instance


end

