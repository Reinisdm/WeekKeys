local arrayOfElements = {}
local L = WeekKeys.L
local WeekFrame = WeekKeys.WeekFrame

local loot_btns = {}
local hide_frames = {}
local tabl = {}
local mythic_level = {
    nil, -- index 1 -> mythic 1?
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
local mlevel = 15
local wchest = true
local ilvl = 5868 + 16
--[[
local end_of_run_ilvl = {
    nil,
    5845,
    5848,
    5852,
    5852,
    5852,
    5858,
    5858,
    5858,
    5861,
    5861,
    5865,
    5865,
    5865,
    5868 --210  => 5658
}
--]]

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
-- instances
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

local function setunfind(...)
    local _, arg1,arg2 = ...
    if arg2 == 0 then
        if arg1 == "ITEM_MOD_STRENGTH_SHORT" then
            UIDropDownMenu_SetText(Stating3,SPEC_FRAME_PRIMARY_STAT_STRENGTH)
        elseif arg1 == "ITEM_MOD_AGILITY_SHORT" then
            UIDropDownMenu_SetText(Stating3,SPEC_FRAME_PRIMARY_STAT_AGILITY)
        elseif arg1 == "ITEM_MOD_INTELLECT_SHORT" then
            UIDropDownMenu_SetText(Stating3,SPEC_FRAME_PRIMARY_STAT_INTELLECT)
        elseif arg1 == "ITEM_MOD_CRIT_RATING_SHORT" then
            UIDropDownMenu_SetText(Stating3,STAT_CRITICAL_STRIKE)
        elseif arg1 == "ITEM_MOD_HASTE_RATING_SHORT" then
            UIDropDownMenu_SetText(Stating3,STAT_HASTE)
        elseif arg1 == "ITEM_MOD_VERSATILITY" then
            UIDropDownMenu_SetText(Stating3,STAT_VERSATILITY)
        elseif arg1 == "ITEM_MOD_MASTERY_RATING_SHORT" then
            UIDropDownMenu_SetText(Stating3,STAT_MASTERY)
        else
            UIDropDownMenu_SetText(Stating3,"-------")
        end
        LootFinder.stat1 = arg1
    elseif arg1 == 0 then
        if arg2 == "ITEM_MOD_STRENGTH_SHORT" then
            UIDropDownMenu_SetText(Stating4,SPEC_FRAME_PRIMARY_STAT_STRENGTH)
        elseif arg2 == "ITEM_MOD_AGILITY_SHORT" then
            UIDropDownMenu_SetText(Stating4,SPEC_FRAME_PRIMARY_STAT_AGILITY)
        elseif arg2 == "ITEM_MOD_INTELLECT_SHORT" then
            UIDropDownMenu_SetText(Stating4,SPEC_FRAME_PRIMARY_STAT_INTELLECT)
        elseif arg2 == "ITEM_MOD_CRIT_RATING_SHORT" then
            UIDropDownMenu_SetText(Stating4,STAT_CRITICAL_STRIKE)
        elseif arg2 == "ITEM_MOD_HASTE_RATING_SHORT" then
            UIDropDownMenu_SetText(Stating4,STAT_HASTE)
        elseif arg2 == "ITEM_MOD_VERSATILITY" then
            UIDropDownMenu_SetText(Stating4,STAT_VERSATILITY)
        elseif arg2 == "ITEM_MOD_MASTERY_RATING_SHORT" then
            UIDropDownMenu_SetText(Stating4,STAT_MASTERY)
        else
            UIDropDownMenu_SetText(Stating4,"-------")
        end
        LootFinder.stat2 = arg2
    end
    LootFinder:Find()
end
-- stat choose (later replace this)
---[[
function WeekKeys.WPDropDownDemo_Menu1(frame, level, menuList)
    local info = UIDropDownMenu_CreateInfo()
    info.text = OPTIONAL
    info.arg2 = 0
    info.func = setunfind
    UIDropDownMenu_AddButton(info)
    info.text,info.arg1, info.checked = SPEC_FRAME_PRIMARY_STAT_STRENGTH,"ITEM_MOD_STRENGTH_SHORT","ITEM_MOD_STRENGTH_SHORT" == LootFinder.stat1
    UIDropDownMenu_AddButton(info)
    info.text,info.arg1, info.checked = SPEC_FRAME_PRIMARY_STAT_AGILITY,"ITEM_MOD_AGILITY_SHORT", "ITEM_MOD_AGILITY_SHORT" == LootFinder.stat1
    UIDropDownMenu_AddButton(info)
    info.text,info.arg1, info.checked = SPEC_FRAME_PRIMARY_STAT_INTELLECT,"ITEM_MOD_INTELLECT_SHORT", "ITEM_MOD_INTELLECT_SHORT" == LootFinder.stat1
    UIDropDownMenu_AddButton(info)
    info.text,info.arg1, info.checked = STAT_CRITICAL_STRIKE,"ITEM_MOD_CRIT_RATING_SHORT", "ITEM_MOD_CRIT_RATING_SHORT" == LootFinder.stat1
    UIDropDownMenu_AddButton(info)
    info.text,info.arg1, info.checked = STAT_HASTE,"ITEM_MOD_HASTE_RATING_SHORT", "ITEM_MOD_HASTE_RATING_SHORT" == LootFinder.stat1
    UIDropDownMenu_AddButton(info)
    info.text,info.arg1, info.checked = STAT_VERSATILITY,"ITEM_MOD_VERSATILITY", "ITEM_MOD_VERSATILITY" == LootFinder.stat1
    UIDropDownMenu_AddButton(info)
    info.text,info.arg1, info.checked = STAT_MASTERY,"ITEM_MOD_MASTERY_RATING_SHORT", "ITEM_MOD_MASTERY_RATING_SHORT" == LootFinder.stat1
    UIDropDownMenu_AddButton(info)
end

function WeekKeys.WPDropDownDemo_Menu2(frame, level, menuList)
    local info = UIDropDownMenu_CreateInfo()
    info.text = OPTIONAL
    info.arg1 = 0
    info.func = setunfind
    UIDropDownMenu_AddButton(info)
    info.text,info.arg2, info.checked = SPEC_FRAME_PRIMARY_STAT_STRENGTH,"ITEM_MOD_STRENGTH_SHORT", "ITEM_MOD_STRENGTH_SHORT" == LootFinder.stat2
    UIDropDownMenu_AddButton(info)
    info.text,info.arg2, info.checked = SPEC_FRAME_PRIMARY_STAT_AGILITY,"ITEM_MOD_AGILITY_SHORT", "ITEM_MOD_AGILITY_SHORT" == LootFinder.stat2
    UIDropDownMenu_AddButton(info)
    info.text,info.arg2, info.checked = SPEC_FRAME_PRIMARY_STAT_INTELLECT,"ITEM_MOD_INTELLECT_SHORT", "ITEM_MOD_INTELLECT_SHORT" == LootFinder.stat2
    UIDropDownMenu_AddButton(info)
    info.text,info.arg2, info.checked = STAT_CRITICAL_STRIKE,"ITEM_MOD_CRIT_RATING_SHORT", "ITEM_MOD_CRIT_RATING_SHORT" == LootFinder.stat2
    UIDropDownMenu_AddButton(info)
    info.text,info.arg2, info.checked = STAT_HASTE,"ITEM_MOD_HASTE_RATING_SHORT", "ITEM_MOD_HASTE_RATING_SHORT" == LootFinder.stat2
    UIDropDownMenu_AddButton(info)
    info.text,info.arg2, info.checked = STAT_VERSATILITY,"ITEM_MOD_VERSATILITY", "ITEM_MOD_VERSATILITY" == LootFinder.stat2
    UIDropDownMenu_AddButton(info)
    info.text,info.arg2, info.checked = STAT_MASTERY,"ITEM_MOD_MASTERY_RATING_SHORT", "ITEM_MOD_MASTERY_RATING_SHORT" == LootFinder.stat2
    UIDropDownMenu_AddButton(info)
end
--]]

--ilvl choose
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
                ilvl = 5658 + chest
            else
                ilvl = 5658 + key
            end
            mlevel = id
            btn:SetText(mlevel .. (wchest and "|Tinterface/worldmap/treasurechest_64.blp:20:20|t" or ""))
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
            ilvl = 5658 + chest
        else
            ilvl = 5658 + key
        end
        wchest = checked
        btn:SetText(mlevel .. (wchest and "|Tinterface/worldmap/treasurechest_64.blp:20:20|t" or ""))
        LootFinder:Find()
    end);
    hide_frames[#hide_frames + 1] = back

    back:Hide()
    return back
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
    pvp_btn:SetPoint("Topleft",180,-30)
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
    keylevel:SetPoint("Topleft",180,-30)
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

    -- filters
    ---[[
    local stat1_choose = CreateFrame("Frame", "Stating3", WeekKeys.WeekFrame, "UIDropDownMenuTemplate")
    stat1_choose:SetPoint("TOPLEFT",240,-30)
    UIDropDownMenu_SetWidth(stat1_choose, 100)
    UIDropDownMenu_Initialize(stat1_choose, WeekKeys.WPDropDownDemo_Menu1)
    UIDropDownMenu_SetText(stat1_choose,OPTIONAL)
    stat1_choose:Hide()
    arrayOfElements[#arrayOfElements + 1] = stat1_choose

    local stat2_choose = CreateFrame("Frame", "Stating4", WeekKeys.WeekFrame, "UIDropDownMenuTemplate")
    stat2_choose:SetPoint("TOPLEFT",350,-30)
    UIDropDownMenu_SetWidth(stat2_choose, 100)
    UIDropDownMenu_Initialize(stat2_choose, WeekKeys.WPDropDownDemo_Menu2)
    UIDropDownMenu_SetText(stat2_choose,OPTIONAL)
    stat2_choose:Hide()
    arrayOfElements[#arrayOfElements + 1] = stat2_choose
--]]
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

--[[
    --]]
    -- result printing
    hooksecurefunc(LootFinder, "Find", function()  -- yes, I hook my function :D
        for i = #loot_btns, #LootFinder.LootList do -- loop to create new buttons, when lootcount > buttoncount
            local btn = WeekKeys.UI.Button(nil, arrayOfElements[1])
            loot_btns[#loot_btns + 1] = btn
            btn:SetSize(WeekKeys.WeekFrame:GetWidth()-8,20)
            btn:SetPoint("TOPLEFT",4,-(i)*20)

            btn.icon = btn:CreateTexture('textureName', 'CENTER')
            btn.icon:SetPoint("LEFT",5,0)
            btn.icon:SetSize(18,18)
            --btn.icon:SetPoint('TOPLEFT', 22, 0)

            -- dungeon
            btn.instance = btn:CreateFontString(nil , "ARTWORK", "GameFontNormal")
            btn.instance:SetPoint("LEFT",25,0)
            btn.instance:SetSize(200,20)
            btn.instance:SetJustifyH("LEFT")

            -- main atr
            btn.mainatr = btn:CreateFontString(nil , "ARTWORK", "GameFontNormal")
            btn.mainatr:SetPoint("LEFT",230,0)
            btn.mainatr:SetSize(50,20)

            -- crit
            btn.crit = btn:CreateFontString(nil , "ARTWORK", "GameFontNormal")
            btn.crit:SetPoint("LEFT",280,0)
            btn.crit:SetSize(50,20)

            -- haste
            btn.haste = btn:CreateFontString(nil , "ARTWORK", "GameFontNormal")
            btn.haste:SetPoint("LEFT",330,0)
            btn.haste:SetSize(50,20)

            -- mastery
            btn.mastery = btn:CreateFontString(nil , "ARTWORK", "GameFontNormal")
            btn.mastery:SetPoint("LEFT",380,0)
            btn.mastery:SetSize(50,20)

            -- vers
            btn.versality = btn:CreateFontString(nil , "ARTWORK", "GameFontNormal")
            btn.versality:SetPoint("LEFT",430,0)
            btn.versality:SetSize(50,20)

            btn.setdata = function(self,dungeon,itemlink)
                if mlevel ~= 0 then
                    itemlink = itemlink:gsub("%d+:3524:%d+:%d+:%d+","5:"..mythic_level[LootFinder.level]..":6652:1501:"..ilvl..":6646")
                end
                GetItemStats(itemlink,table.wipe(tabl or {}))
                -- texture
                local _, _, _, _, icon = GetItemInfoInstant(itemlink)
                self.icon:SetTexture(icon)

                -- dungeon
                self.instance:SetText(dungeon or "")

                -- atr
                self.mainatr:SetText(tabl.ITEM_MOD_STRENGTH_SHORT or tabl.ITEM_MOD_AGILITY_SHORT or tabl.ITEM_MOD_INTELLECT_SHORT or 0)
                self.crit:SetText(tabl.ITEM_MOD_CRIT_RATING_SHORT or 0)
                self.haste:SetText(tabl.ITEM_MOD_HASTE_RATING_SHORT or 0)
                self.mastery:SetText(tabl.ITEM_MOD_MASTERY_RATING_SHORT or 0)
                self.versality:SetText(tabl.ITEM_MOD_VERSATILITY or 0)

                self.itemlink = itemlink
            end
            btn:SetScript("OnEnter",function(self)
                GameTooltip:Hide()
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetHyperlink(self.itemlink)
                GameTooltip:Show()
            end)
            btn:SetScript("OnLeave",function()
                GameTooltip:Hide()
            end)

        end
        for i = 1, #loot_btns do -- hide all buttons for situation when buttoncoutn > lootcount
            loot_btns[i]:Hide()
        end
        for index,val in pairs(LootFinder.LootList)  do -- show and set information (self,dungeon,itemlink)
            loot_btns[index]:setdata(val[1],val[2])
            loot_btns[index]:Show()
        end
    end)

    WeekKeys.AddButton(L["lootfinder"],arrayOfElements)
end)
