local arrayOfElements = {}
local L = WeekKeys.L
local WeekFrame = WeekKeys.WeekFrame

local loot_btns = {}
local hide_frames = {}
local mlevel = 15
local wchest = true


--- Function to create frame with class icons
---@param btn Frame @frame/button to anchor
---@return Frame class_frame @Frame with class icons
local function createmyclasslist(btn)
    -- background for class buttons
    local back = CreateFrame("Frame",nil,btn,"InsetFrameTemplate")
    back:SetPoint("BOTTOMLEFT",0,30)
    local btnsize = 30
    back:SetSize(btnsize * 4 + 20, btnsize * 3 + 20)
    -- class buttons with onclick script
    for i = 1, 12 do
        local button = WeekKeys.UI.Button(nil, back)
        button:SetPoint("TOPLEFT",(i-1)%4*btnsize+10,-1*math.floor((i-1)/4)*btnsize-10)
        button:SetSize(btnsize,btnsize)
        button:SetID(i)
        local _, class, _ = GetClassInfo(i)
        button.texture:SetTexture("Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES")
        local coords = CLASS_ICON_TCOORDS[class]
        button.texture:SetTexCoord(unpack(coords))

        button:SetScript("onclick",function(self)
            LootFinder.class = self:GetID()
            LootFinder.spec = 0
            -- specrefresh()
            btn.texture:SetTexture(self.texture:GetTexture())
            local _, class, _ = GetClassInfo(self:GetID())
            local coords = CLASS_ICON_TCOORDS[class]
            btn.texture:SetTexCoord(unpack(coords))
            back:Hide()
            LootFinder:Find()
        end)
    end
    hide_frames[#hide_frames + 1] = back
  --  back:SetScript("OnLeave",function(self) self:Hide() end)
    back:Hide()
    return back
end

--- Function to create frame with spec list
---@param btn Frame @frame/button to anchor
---@return Frame spec_frame @Frame with class specializations
local function createspeclist(btn)
    local spec_btn_list = {}
    -- background for spec buttons
    local back = CreateFrame("Frame",nil,btn,"InsetFrameTemplate")
    back:SetPoint("BOTTOMLEFT",0,30)
    local btnsize = 30
    back:SetSize(btnsize * 3 + 20, btnsize * 2 + 20)
    for i = 1, 5 do
        local button = WeekKeys.UI.Button(nil, back)
        button:SetPoint("TOPLEFT",(i-1)%3*btnsize+2,-1*math.floor((i-1)/3)*btnsize-2)
        button:SetSize(btnsize,btnsize)
        button:SetScript("OnClick",function(self)
            LootFinder.spec = self:GetID()
            btn.texture:SetTexture(self.texture:GetTexture())
            back:Hide()
            LootFinder:Find()
        end)
        spec_btn_list[i] = button
    end

    back:SetScript("OnShow",function(self) 
        local len = #LootFinder.class_spec[LootFinder.class] 
        if len == 0 then self:Hide() end -- hide if no class choosen
        local spec_ids = LootFinder.class_spec[LootFinder.class]
        if len == 2 then back:SetSize(btnsize * 3 + 10, btnsize * 1 + 10) else back:SetSize(btnsize * 3 + 10, btnsize * 2 + 10) end
        for i = 1, len do
           local _, _, _, icon, _, _ = GetSpecializationInfoByID(spec_ids[i])
           spec_btn_list[i]:SetID(spec_ids[i])
           spec_btn_list[i].texture:SetTexture(icon)
           spec_btn_list[i]:Show()
        end
        spec_btn_list[len+1]:SetID(0)
        spec_btn_list[len+1].texture:SetTexture(QUESTION_MARK_ICON)
        spec_btn_list[len+1]:Show()
        for i = len + 2, 5 do
            spec_btn_list[i]:Hide()
        end
    end)
    hide_frames[#hide_frames + 1] = back
    --back:SetScript("OnLeave",function(self) self:Hide() end)
    back:Hide()
    return back
end

--- Function to create frame with clot list
---@param btn Frame @frame/button to anchor
---@return Frame slot_frame @Frame with slots
local function createslotlist(btn)
    -- background for spec buttons
    local back = CreateFrame("Frame",nil,btn,"InsetFrameTemplate")
    back:SetPoint("BOTTOMLEFT",0,30)
    local btnsize = 30
    back:SetSize(btnsize * 4 + 20, btnsize * 4 + 20) -- change to setpoint
    local icons = {133070,133292,135061,133771,132751,132616,132939,132511,134584,132535,135317,134959,801523,133441,QUESTION_MARK_ICON}
    local slots = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,15}

    for i = 1, #icons do 
        local button = WeekKeys.UI.Button(nil, back)
        button:SetPoint("TOPLEFT",(i-1)%4*btnsize+10,-1*math.floor((i-1)/4)*btnsize-10)
        button:SetSize(btnsize,btnsize)
        button.texture:SetTexture(icons[i])
        button:SetID(slots[i])
        button:SetScript("OnClick",function(self)
            LootFinder.slot = self:GetID()
            btn.texture:SetTexture(self.texture:GetTexture())
            back:Hide()
            LootFinder:Find()
        end)
    end
    hide_frames[#hide_frames + 1] = back
    --back:SetScript("OnLeave",function(self) self:Hide() end)
    back:Hide()
    return back
end

--- Function to create frame with instance list
---@param btn Frame @frame/button to anchor
---@return Frame instance_frame @Frame with instances
local function createinstancelist(btn)

    local back = CreateFrame("Frame",nil,btn,"InsetFrameTemplate")
    back:SetPoint("BOTTOMLEFT",0,30)
    local btnsize = 30
    back:SetSize(btnsize * 4 + 20, btnsize * 4 + 20)

    local i = 1
    EJ_SelectTier(LootFinder.expansion)
    while EJ_GetInstanceByIndex(i, false) ~= nil do
        LootFinder.instances[i] = true
        local _, name, _, _, _, _, buttonImage2 = EJ_GetInstanceByIndex(i, false)
        local button = WeekKeys.UI.Button(nil, back)
        button.name = name
        button:SetPoint("TOPLEFT",(i-1)%4*btnsize+10,-1*math.floor((i-1)/4)*btnsize-10)
        button:SetSize(btnsize,btnsize)
        button:SetID(i)
        button.texture:SetTexture(buttonImage2)
        button.find = true

        function button:enable(bool)
            if bool then
                LootFinder.instances[self:GetID()] = true
                self.texture:SetAlpha(1)
            else
                LootFinder.instances[self:GetID()] = false
                self.texture:SetAlpha(0.3)
            end
            self.find = bool
        end

        button:SetScript("OnClick",function(self)
            self:enable(not self.find)
            LootFinder:Find()
        end)

        button:SetScript("OnEnter",function(self)
            GameTooltip:Hide();
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:AddLine(self.name)
            GameTooltip:Show()
        end)

        button:SetScript("OnLeave",function()
            GameTooltip:Hide();
        end)

        i = i + 1
    end
    back:SetHeight(math.floor((i-1)/4)*btnsize+20)

    hide_frames[#hide_frames + 1] = back
    --back:SetScript("OnLeave",function(self) self:Hide() end)
    back:Hide()
    return back
end

--- Function to create frame with m+ levels
---@param btn Frame @frame/button to anchor
---@return Frame mplus_frame @frame with m+ choose
local function createmlevel(btn)
    local back = CreateFrame("Frame",nil,btn,"InsetFrameTemplate")
    back:SetPoint("BOTTOMLEFT",0,30)
    local btnsize = 30
    back:SetSize(btnsize * 5 + 20, btnsize * 4 + 20)

    for i = 1, 15 do
        local button = WeekKeys.UI.Button(nil, back)
        button:SetSize(btnsize, btnsize)
        button:SetPoint("TOPLEFT",(i-1)%5*btnsize+10,-1*math.floor((i-1)/5)*btnsize-10)

        button:SetText(i == 1 and 0 or i)
        button:SetID(i == 1 and 0 or i)

        button:SetScript("OnClick",function (self)
            local id = self:GetID()
            local chest, key = C_MythicPlus.GetRewardLevelForDifficultyLevel(max(1,id))
            if wchest then
                LootFinder.milvl = chest
            else
                LootFinder.milvl = key
            end
            LootFinder.mlevel = id
            btn:SetText(LootFinder.mlevel .. (wchest and "|Tinterface/worldmap/treasurechest_64.blp:20:20|t" or ""))
            LootFinder:Find()
        end)

    end
    local chesckbtn = CreateFrame("CheckButton", "WeekKeys_WeeklyReward", back, "ChatConfigCheckButtonTemplate");
    chesckbtn:SetPoint("TOPLEFT", 10, -btnsize * 3 -10);
    WeekKeys_WeeklyRewardText:SetText(MYTHIC_PLUS_WEEKLY_BEST);
    chesckbtn:SetChecked(true)
    chesckbtn:SetScript("OnClick",function(self)
        local checked = self:GetChecked()
        local chest, key = C_MythicPlus.GetRewardLevelForDifficultyLevel(max(1,mlevel))
        if checked == true then
            LootFinder.milvl = chest
        else
            LootFinder.milvl = key
        end
        wchest = checked
        btn:SetText(LootFinder.mlevel .. (wchest and "|Tinterface/worldmap/treasurechest_64.blp:20:20|t" or ""))
        LootFinder:Find()
    end);
    hide_frames[#hide_frames + 1] = back

    back:Hide()
    return back
end

--- Function to create frame with stat choose
---@param btn Frame @frame to anchor
---@return Frame stat_frame @stat frame
local function createfilters(btn)
    local back = CreateFrame("Frame",nil,btn,"InsetFrameTemplate")
    back:SetPoint("BOTTOMLEFT",0,30)

    local displayname = {
    --    SPEC_FRAME_PRIMARY_STAT_STRENGTH, -- comment out because useless
    --    SPEC_FRAME_PRIMARY_STAT_AGILITY, -- comment out because useless
    --    SPEC_FRAME_PRIMARY_STAT_INTELLECT, -- comment out because useless
        STAT_CRITICAL_STRIKE,
        STAT_HASTE,
        STAT_VERSATILITY,
        STAT_MASTERY
    }
    local values = {
    --    'ITEM_MOD_STRENGTH_SHORT', -- comment out because useless
    --    'ITEM_MOD_AGILITY_SHORT', -- comment out because useless
    --    'ITEM_MOD_INTELLECT_SHORT', -- comment out because useless
        'ITEM_MOD_CRIT_RATING_SHORT',
        'ITEM_MOD_HASTE_RATING_SHORT',
        'ITEM_MOD_VERSATILITY',
        'ITEM_MOD_MASTERY_RATING_SHORT'
    }
    back:SetSize(150,10 + #values * 20)
    for i = 1, #values do
        local checkbtn = CreateFrame("CheckButton", "WeekKeys_StatChoose"..i, back, "ChatConfigCheckButtonTemplate")
        checkbtn:SetPoint("TOPLEFT", 5, -i*20+15)
        checkbtn.val = values[i]
        _G["WeekKeys_StatChoose"..i.."Text"]:SetText(displayname[i])
        checkbtn:SetScript("OnClick",function(self)
            local checked = self:GetChecked()
            if checked == true then
                LootFinder.stats[self.val] = true
            else
                LootFinder.stats[self.val] = nil
            end
            LootFinder:Find()
        end)
    end
    hide_frames[#hide_frames + 1] = back
    back:Hide()
    return back
    --[[
        SPEC_FRAME_PRIMARY_STAT_STRENGTH    'ITEM_MOD_STRENGTH_SHORT'
        SPEC_FRAME_PRIMARY_STAT_AGILITY     'ITEM_MOD_AGILITY_SHORT'
        SPEC_FRAME_PRIMARY_STAT_INTELLECT   'ITEM_MOD_INTELLECT_SHORT'
        STAT_CRITICAL_STRIKE                'ITEM_MOD_CRIT_RATING_SHORT'
        STAT_HASTE                          'ITEM_MOD_HASTE_RATING_SHORT'
        STAT_VERSATILITY                    'ITEM_MOD_VERSATILITY'
        STAT_MASTERY                        'ITEM_MOD_MASTERY_RATING_SHORT'
    ]]
end


--[[ TO DO

local function createraidlist(self)

end

local function createpvpdlist(self)

end

--]]
--mylist = nil
WeekKeys.AddInit(function()
    arrayOfElements[1] = CreateFrame('Frame')
   -- mylist = arrayOfElements[1]
    arrayOfElements[1]:SetFrameStrata("BACKGROUND")
    arrayOfElements[1]:SetSize(10,10)
    arrayOfElements[1]:SetScript("OnShow",function()
        WeekKeys.WeekFrame.ScrollFrame:ClearAllPoints()
        WeekKeys.WeekFrame.ScrollFrame:SetPoint("TOPLEFT", WeekKeys.WeekFrame, "TOPLEFT", 4, -80);
        WeekKeys.WeekFrame.ScrollFrame:SetPoint("BOTTOMRIGHT", WeekKeys.WeekFrame, "BOTTOMRIGHT", -5, 5);
    end)
    arrayOfElements[1]:Hide()

    -- class btn
    local class_btn = WeekKeys.UI.Button(nil, WeekKeys.WeekFrame)
    class_btn:SetSize(30,30)
    class_btn:SetPoint("TopLeft",20,-30)
    class_btn.texture:SetTexture(QUESTION_MARK_ICON)
    class_btn:SetScript("OnClick",function(self)
        self.showframe = self.showframe or createmyclasslist(self)
        if self.showframe:IsShown() then
            return self.showframe:Hide()
        end
        for _,v in pairs(hide_frames) do v:Hide() end
        self.showframe:Show()
    end)
    class_btn:Hide()
    arrayOfElements[#arrayOfElements + 1] = class_btn

    -- spec btn
    local spec_btn = WeekKeys.UI.Button(nil, WeekKeys.WeekFrame)
    spec_btn:SetSize(30,30)
    spec_btn:SetPoint("Topleft",60,-30)
    spec_btn.texture:SetTexture(QUESTION_MARK_ICON)
    spec_btn:SetScript("OnClick",function(self)
        self.showframe = self.showframe or createspeclist(self)
        if self.showframe:IsShown() then
            return self.showframe:Hide()
        end
        for _,v in pairs(hide_frames) do v:Hide() end
        self.showframe:Show()
    end)
    spec_btn:Hide()
    arrayOfElements[#arrayOfElements + 1] = spec_btn

    -- slot btn
    local slot_btn = WeekKeys.UI.Button(nil, WeekKeys.WeekFrame)
    slot_btn:SetSize(30,30)
    slot_btn:SetPoint("Topleft",100,-30)
    slot_btn.texture:SetTexture(QUESTION_MARK_ICON)
    slot_btn:SetScript("OnClick",function(self)
        self.showframe = self.showframe or createslotlist(self)
        if self.showframe:IsShown() then
            return self.showframe:Hide()
        end
        for _,v in pairs(hide_frames) do v:Hide() end
        self.showframe:Show()
    end)
    slot_btn:Hide()
    arrayOfElements[#arrayOfElements + 1] = slot_btn

    -- instances
    local instance_btn = WeekKeys.UI.Button(nil, WeekKeys.WeekFrame)
    instance_btn:SetSize(30,30)
    instance_btn:SetPoint("Topleft",140,-30)
    instance_btn.texture:SetTexture('interface/minimap/objecticonsatlas.blp')
    instance_btn.texture:SetTexCoord(0.24609375,0.267578125,0.951171875,0.994140625)
    instance_btn:SetScript("OnClick",function(self)
        self.showframe = self.showframe or createinstancelist(self)
        if self.showframe:IsShown() then
            return self.showframe:Hide()
        end
        for _,v in pairs(hide_frames) do v:Hide() end
        self.showframe:Show()
    end)
    instance_btn:Hide()
    arrayOfElements[#arrayOfElements + 1] = instance_btn

    --[[
    local raid_btn = WeekKeys.UI.Button(nil, WeekKeys.WeekFrame)
    raid_btn:SetSize(30,30)
    raid_btn:SetPoint("Topleft",180,-30)
    raid_btn.texture:SetTexture('interface/minimap/objecticonsatlas.blp')
    raid_btn.texture:SetTexCoord(0.283203125, 0.3046875, 0.94140625, 0.984375)
    raid_btn:SetScript("OnClick",function(self)
        self.showframe = self.showframe or createraidlist(self)
        if self.showframe:IsShown() then
            return self.showframe:Hide()
        end
        for _,v in pairs(hide_frames) do v:Hide() end
        self.showframe:Show()
    end)
    raid_btn:Hide()
    arrayOfElements[#arrayOfElements + 1] = raid_btn
    --]]

    --[[
    local pvp_btn = WeekKeys.UI.Button(nil, WeekKeys.WeekFrame)
    pvp_btn:SetSize(30,30)
    pvp_btn:SetPoint("Topleft",220,-30)
    pvp_btn.texture:SetTexture('????')
    pvp_btn.texture:SetTexCoord(some_text_coords_if_need)
    pvp_btn:SetScript("OnClick",function(self)
        self.showframe = self.showframe or createpvplist(self)
        if self.showframe:IsShown() then
            return self.showframe:Hide()
        end
        for _,v in pairs(hide_frames) do v:Hide() end
        self.showframe:Show()
    end)
    pvp_btn:Hide()
    arrayOfElements[#arrayOfElements + 1] = pvp_btn
    --]]


    -- keylevel
    local keylevel = WeekKeys.UI.Button(nil, WeekKeys.WeekFrame)
    keylevel:SetSize(30,30)
    keylevel:SetPoint("Topleft",260,-30)
    keylevel:SetText(15 .. "|Tinterface/worldmap/treasurechest_64.blp:20:20|t")
    keylevel:SetScript("OnClick",function(self)
        self.showframe = self.showframe or createmlevel(self)
        if self.showframe:IsShown() then
            return self.showframe:Hide()
        end
        for _,v in pairs(hide_frames) do v:Hide() end
        self.showframe:Show()
    end)
    keylevel:Hide()
    arrayOfElements[#arrayOfElements + 1] = keylevel

    -- stat filters
    local statfilter = WeekKeys.UI.Button(nil, WeekKeys.WeekFrame)
    statfilter:SetSize(30,30)
    statfilter:SetPoint("Topleft",300,-30)
    statfilter:SetText("???")
    statfilter:SetScript("OnClick",function(self)
        self.showframe = self.showframe or createfilters(self)
        if self.showframe:IsShown() then
            return self.showframe:Hide()
        end
        for _,v in pairs(hide_frames) do v:Hide() end
        self.showframe:Show()
    end)
    statfilter:Hide()
    arrayOfElements[#arrayOfElements + 1] = statfilter


    -- "dungeons"
    local label = WeekKeys.WeekFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    label:SetPoint("TOPLEFT",25,-60)
    label:SetSize(200,20)
    label:SetText(DUNGEONS)
    label:Hide()
    arrayOfElements[#arrayOfElements + 1] = label
    -- list of globalstrings dungeon/instance
    -- CALENDAR_TYPE_DUNGEON
    -- INSTANCE_CHAT
    -- INSTANCE_CHAT_MESSAGE
    -- ENCOUNTER_JOURNAL_INSTANCE
    -- DUNGEONS
    -- INSTANCE
    -- CHAT_MSG_INSTANCE_CHAT
    -- GUILD_CHALLENGE_TYPE1
    -- GUILD_INTEREST_DUNGEON
    -- VOICE_CHANNEL_NAME_INSTANCE
    -- LFG_TYPE_DUNGEON

    label = WeekKeys.WeekFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    label:SetPoint("TOPLEFT",230,-60)
    label:SetSize(50,20)
    label:SetFormattedText(SPEC_FRAME_PRIMARY_STAT,"")
    label:Hide()
    arrayOfElements[#arrayOfElements + 1] = label

    label = WeekKeys.WeekFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    label:SetPoint("TOPLEFT",280,-60)
    label:SetSize(50,20)
    label:SetText(SPELL_CRIT_CHANCE)
    label:Hide()
    arrayOfElements[#arrayOfElements + 1] = label

    label = WeekKeys.WeekFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    label:SetPoint("TOPLEFT",330,-60)
    label:SetSize(50,20)
    label:SetText(STAT_HASTE)
    label:Hide()
    arrayOfElements[#arrayOfElements + 1] = label

    label = WeekKeys.WeekFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    label:SetPoint("TOPLEFT",380,-60)
    label:SetSize(50,20)
    label:SetText(STAT_MASTERY)
    label:Hide()
    arrayOfElements[#arrayOfElements + 1] = label

    label = WeekKeys.WeekFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    label:SetPoint("TOPLEFT",430,-60)
    label:SetSize(50,20)
    label:SetText(STAT_VERSATILITY)
    label:Hide()
    arrayOfElements[#arrayOfElements + 1] = label

    -- result printing
    hooksecurefunc(LootFinder, "Find", function()
        for i = #loot_btns, #LootFinder.loot_list do
            local btn = WeekKeys.UI.LootFinderButton(nil, arrayOfElements[1])
            loot_btns[#loot_btns + 1] = btn
            btn:SetSize(492,20)
            btn:SetPoint("TOPLEFT",4,-(i)*20)
        end
        for i = 1, #loot_btns do -- hide all buttons
            loot_btns[i]:Hide()
        end
        for index, source, name, boss, itemlink, icon, mainstat, crit, haste, mastery, versality in WeekKeys.Iterators.LootList() do
            local btn = loot_btns[index]
            btn:SetIcon(icon)
            btn:SetDungeon(name)
            btn.link = itemlink
            btn:SetMainAtr(mainstat)
            btn:SetCrit(crit)
            btn:SetHaste(haste)
            btn:SetMastery(mastery)
            btn:SetVersality(versality)
            btn:Show()
        end
    end)

    WeekKeys.AddButton(L["lootfinder"],arrayOfElements)
end)
