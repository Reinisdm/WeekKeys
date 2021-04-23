LootFinder = LootFinder or {}

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

LootFinder.class = 0
LootFinder.spec = 0
LootFinder.slot = 15
LootFinder.expansion = 9
LootFinder.instances = {}
LootFinder.level = 15
LootFinder.LootList = {}
function LootFinder:GetFilters()
    self.class, self.spec = EJ_GetLootFilter()
    self.slot = EJ_GetSlotFilter()
end

function LootFinder.SetStat2(self,arg1,arg2,checked)
    if arg2 == 0 then
        if arg1 == "ITEM_MOD_STRENGTH_SHORT" then
            UIDropDownMenu_SetText(Stating1,SPEC_FRAME_PRIMARY_STAT_STRENGTH)
        elseif arg1 == "ITEM_MOD_AGILITY_SHORT" then
            UIDropDownMenu_SetText(Stating1,SPEC_FRAME_PRIMARY_STAT_AGILITY)
        elseif arg1 == "ITEM_MOD_INTELLECT_SHORT" then
            UIDropDownMenu_SetText(Stating1,SPEC_FRAME_PRIMARY_STAT_INTELLECT)
        elseif arg1 == "ITEM_MOD_CRIT_RATING_SHORT" then
            UIDropDownMenu_SetText(Stating1,STAT_CRITICAL_STRIKE)
        elseif arg1 == "ITEM_MOD_HASTE_RATING_SHORT" then
            UIDropDownMenu_SetText(Stating1,STAT_HASTE)
        elseif arg1 == "ITEM_MOD_VERSATILITY" then
            UIDropDownMenu_SetText(Stating1,STAT_VERSATILITY)
        elseif arg1 == "ITEM_MOD_MASTERY_RATING_SHORT" then
            UIDropDownMenu_SetText(Stating1,STAT_MASTERY)
        else
            UIDropDownMenu_SetText(Stating1,"-------")
        end
        LootFinder.stat1 = arg1
    elseif arg1 == 0 then
        if arg2 == "ITEM_MOD_STRENGTH_SHORT" then
            UIDropDownMenu_SetText(Stating2,SPEC_FRAME_PRIMARY_STAT_STRENGTH)
        elseif arg2 == "ITEM_MOD_AGILITY_SHORT" then
            UIDropDownMenu_SetText(Stating2,SPEC_FRAME_PRIMARY_STAT_AGILITY)
        elseif arg2 == "ITEM_MOD_INTELLECT_SHORT" then
            UIDropDownMenu_SetText(Stating2,SPEC_FRAME_PRIMARY_STAT_INTELLECT)
        elseif arg2 == "ITEM_MOD_CRIT_RATING_SHORT" then
            UIDropDownMenu_SetText(Stating2,STAT_CRITICAL_STRIKE)
        elseif arg2 == "ITEM_MOD_HASTE_RATING_SHORT" then
            UIDropDownMenu_SetText(Stating2,STAT_HASTE)
        elseif arg2 == "ITEM_MOD_VERSATILITY" then
            UIDropDownMenu_SetText(Stating2,STAT_VERSATILITY)
        elseif arg2 == "ITEM_MOD_MASTERY_RATING_SHORT" then
            UIDropDownMenu_SetText(Stating2,STAT_MASTERY)
        else
            UIDropDownMenu_SetText(Stating2,"-------")
        end
        LootFinder.stat2 = arg2
    end
    CloseDropDownMenus()
end

-- LootFinder.LootList
function LootFinder:Find()
    EJ_SetDifficulty(23)
    EJ_SelectTier(LootFinder.expansion)
    if EncounterJournal_ListInstances then
        EncounterJournal_ListInstances()
    end

    --C_EncounterJournal.SetPreviewMythicPlusLevel(0)
    --C_EncounterJournal.SetPreviewMythicPlusLevel(LootFinder.level)
    self.LootList = {}
    self.class = self.class or 0
    self.spec = self.spec or 0
    self.slot = self.slot or 0
    EJ_SetLootFilter(self.class,self.spec )
    C_EncounterJournal.SetSlotFilter(self.slot)
    local iIndex = 1
    local stat1 = self.stat1
    local stat2 = self.stat2
    while EJ_GetInstanceByIndex(iIndex, false) ~= nil do
        if LootFinder.instances[iIndex] == nil then LootFinder.instances[iIndex] = true end
        if LootFinder.instances[iIndex] then
            local instanceID, name = EJ_GetInstanceByIndex(iIndex, false)
            EJ_SelectInstance(instanceID)
            for i=1,EJ_GetNumLoot() do
                local itemInfo = C_EncounterJournal.GetLootInfoByIndex(i)
                if not itemInfo.link then -- sometimes link is nil
                    i = i - 1
                else
                    local stats = GetItemStats(itemInfo.link)
                    if stat1 ~= nil and stat2 ~= nil then
                        if stats[stat1] ~= nil and stats[stat2] ~= nil then
                            tinsert(self.LootList,{name,itemInfo.link,stats[stat1]})
                        end
                    elseif stat1 and stat2 == nil and stats[stat1] then
                        tinsert(self.LootList,{name,itemInfo.link,stats[stat1]})
                    elseif stat1 == nil and stat2 and stats[stat2] then
                        tinsert(self.LootList,{name,itemInfo.link,stats[stat2]})
                    elseif stat1 == nil and stat2 == nil then
                        tinsert(self.LootList,{name,itemInfo.link})
                    end
                end
            end
        end
        iIndex=iIndex+1
    end
    if stat1 or stat2 then
        table.sort(self.LootList, function(a,b)
            return a[3] > b[3]
        end)
    end
    if EncounterJournal_ListInstances then
        EncounterJournal_ListInstances()
    end
    return self.LootList
end
