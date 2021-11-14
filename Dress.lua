local elements = {}
local function add(arg1)
    arg1:Hide()
    elements[#elements+1] = arg1
end
local L = WeekKeys.L

local btns = {}
local class_btn = nil
local spec_btn = nil
local slots = {}
local stat_labels = {}
local masteryval = {

	-- warrior
	[71] = 31.82, -- arms
	[72] = 24, -- fury
	[73] = 70,  -- protection

	-- paladin
    [65] = 23.33, -- holy
	[66] = 35, -- protection
	[70] = 21.88,  -- retribution

	-- monk
	[253] = 18.42, -- beast mastery
	[254] = 56, -- marksmanship
	[255] = 21.12,  -- survival

	-- rogue
	[259] = 20.59, -- assassination
	[260] = 24.14, -- outlaw
	[261] = 14.28,  -- subtlety

	-- priest
	[256] = 25.93, -- discipline
	[257] = 28, -- holy
	[258] = 70,  -- shadow

    -- death knight
	[250] = 17.5, -- blood
	[251] = 17.5, -- frost
	[252] = 15.5,  -- unholy

	 -- shaman
	[262] = 18.66, -- elemental
	[263] = 17.5, -- enchancement
	[264] = 11.66,  -- restoration

     -- mage
	[62] = 29.16, -- arcane
	[63] = 46.66, -- fire
	[64] = 35,  -- frost

     -- warlock
	[265] = 14, -- affliction
	[266] = 24.14, -- demonology
	[267] = 17.5,  -- destruction

    -- monk
	[268] = 35, -- brewmaster
	[270] = 8.33, -- mistweaver
	[269] = 28,  -- windwalker

     -- druid
	[102] = 31.8, -- balance
	[103] = 17.5, -- feral
	[104] = 70, -- guardian
	[105] = 70,  -- restororation

     -- demon hunter
	[577] = 19.44, -- havoc
	[581] = 14  -- vengeance

}
local function update(db, callback)
--icon, name, tooltip
    for i = #btns, #db do
        btns[#btns + 1] = WeekKeys.UI.IconNameButton(nil, btns[#btns] or elements[1])
    end
    for i = 1, #btns do
        btn = btns[i]
        if db[i] then
            btn:SetName(db[i].name)
            btn:SetIcon(db[i].icon,db[i].coords)
            btn:SetTooltip(db[i].tooltip)
            btn:SetScript("OnClick",callback)
            btn:SetID(db[i].ID or i)
            btn:SetTooltip(db[i].itemlink)
            btn:Show()
        else
            btn:Hide()
        end
    end

end


local function calc()
    local stats = {}
    local item_stats = {} --memory save
    for _, item in pairs(slots) do
        GetItemStats(item, item_stats)
        for stat, val in pairs(item_stats) do
            if stats[stat] then
                stats[stat] = stats[stat] + val
            else
                stats[stat] = val
            end
        end

        table.wipe(item_stats)
    end

    stat_labels[1]:SetText(string.format("%s : +%.2f%% (+%d)",STAT_CRITICAL_STRIKE, (stats.ITEM_MOD_CRIT_RATING_SHORT or 0) / 35, stats.ITEM_MOD_CRIT_RATING_SHORT or 0))
    stat_labels[2]:SetText(string.format("%s : +%.2f%% (+%d)",STAT_HASTE, (stats.ITEM_MOD_HASTE_RATING_SHORT or 0) / 33, stats.ITEM_MOD_HASTE_RATING_SHORT or 0))
    stat_labels[3]:SetText(string.format("%s : +%.2f%% (+%d)",STAT_MASTERY, (stats.ITEM_MOD_MASTERY_RATING_SHORT or 0) / (masteryval[LootFinder.spec] or 1), stats.ITEM_MOD_MASTERY_RATING_SHORT or 0))
    stat_labels[4]:SetText(string.format("%s : +%.2f%% (+%d)",STAT_VERSATILITY, (stats.ITEM_MOD_VERSATILITY or 0) / 40, stats.ITEM_MOD_VERSATILITY or 0))
end
--[[
    INVTYPE_HEAD    interface/paperdoll/ui-paperdoll-slot-head.blp
    INVTYPE_NECK	interface/paperdoll/ui-paperdoll-slot-neck.blp
    INVTYPE_SHOULDER    interface/paperdoll/ui-paperdoll-slot-shoulder.blp
    INVTYPE_CLOAK    interface/paperdoll/ui-paperdoll-slot-chest.blp
    INVTYPE_CHEST    interface/paperdoll/ui-paperdoll-slot-chest.blp
    INVTYPE_WRIST    interface/paperdoll/ui-paperdoll-slot-wrists.blp
    INVTYPE_HAND    interface/paperdoll/ui-paperdoll-slot-hands.blp
    INVTYPE_WAIST    interface/paperdoll/ui-paperdoll-slot-waist.blp
    INVTYPE_LEGS    interface/paperdoll/ui-paperdoll-slot-legs.blp
    INVTYPE_FEET    interface/paperdoll/ui-paperdoll-slot-feet.blp
    INVTYPE_FINGER    interface/paperdoll/ui-paperdoll-slot-finger.blp
    INVTYPE_FINGER    interface/paperdoll/ui-paperdoll-slot-finger.blp
    INVTYPE_TRINKET    interface/paperdoll/ui-paperdoll-slot-trinket.blp
    INVTYPE_TRINKET    interface/paperdoll/ui-paperdoll-slot-trinket.blp

    INVTYPE_WEAPONMAINHAND    interface/paperdoll/ui-paperdoll-slot-mainhand.blp
    INVTYPE_SHIELD    interface/paperdoll/ui-paperdoll-slot-secondaryhand.blp
]]
local classlist = {
   -- {name = "none", icon = QUESTION_MARK_ICON},
}

WeekKeys.AddInit(
function()
    for i = 1, 12 do
        local localized, english, id = GetClassInfo(i)
        classlist[id] = {}
        classlist[id].name = localized
        classlist[id].icon = "Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES"
        classlist[id].coords = CLASS_ICON_TCOORDS[english]
    end

    local scrframe = CreateFrame('Frame',nil,WeekKeys.WeekFrame.ScrollFrame)
    scrframe:SetFrameStrata("BACKGROUND")
    scrframe:SetSize(250,5)
    WeekKeys.WeekFrame.ScrollFrame:SetScrollChild(scrframe)
    scrframe:SetScript("OnShow",function()

        WeekKeys.WeekFrame.ScrollFrame:ClearAllPoints()
        WeekKeys.WeekFrame.ScrollFrame:SetPoint("TOPLEFT", WeekKeys.WeekFrame, "TOPLEFT", 300, -60);
        WeekKeys.WeekFrame.ScrollFrame:SetPoint("BOTTOMRIGHT",  WeekKeys.WeekFrame, "BOTTOMRIGHT", -5, 5);
    end)
    scrframe:SetScript("OnHide",function()
         end)

    add(scrframe)

    local btn = WeekKeys.UI.Button(nil,WeekKeys.WeekFrame)
    btn:SetPoint("TOPLEFT",20,-40)
    btn:SetSize(40,40)
    btn:SetScript("OnEnter",function(self)
        GameTooltip:Hide();
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if self.link then
            GameTooltip:SetHyperlink(self.link)
        else
            GameTooltip:AddLine(INVTYPE_HEAD)
        end
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave",function()
        GameTooltip:Hide()
    end)
    btn.texture:SetTexture("interface/paperdoll/ui-paperdoll-slot-head.blp")
    btn:SetScript("OnClick",function()
        local callback = function(self)
            local id = self:GetID()
            local item = LootFinder.loot_list[id]
            btn.texture:SetTexture(item.icon or QUESTION_MARK_ICON)
            btn.link = item.itemlink
            slots[1] = item.itemlink
            calc()
        end
        LootFinder.class = class_btn:GetID()
        LootFinder.spec = spec_btn:GetID()
        LootFinder.milvl = C_MythicPlus.GetRewardLevelForDifficultyLevel(15)
        LootFinder.mlevel = 15
        LootFinder.slot = 0
        LootFinder:Find()

        update(LootFinder.loot_list,callback)
    end)
    add(btn)

    local btn = WeekKeys.UI.Button(nil,WeekKeys.WeekFrame)
    btn:SetPoint("TOPLEFT",60,-40)
    btn:SetSize(40,40)
    btn:SetScript("OnEnter",function(self)
        GameTooltip:Hide();
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if self.link then
            GameTooltip:SetHyperlink(self.link)
        else
            GameTooltip:AddLine(INVTYPE_NECK)
        end
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave",function()
        GameTooltip:Hide()
    end)
    btn.texture:SetTexture("interface/paperdoll/ui-paperdoll-slot-neck.blp")
    btn:SetScript("OnClick",function()
        local callback = function(self)
            local id = self:GetID()
            local item = LootFinder.loot_list[id]
            btn.texture:SetTexture(item.icon or QUESTION_MARK_ICON)
            btn.link = item.itemlink
            slots[2] = item.itemlink
            calc()
        end
        LootFinder.class = class_btn:GetID()
        LootFinder.spec = spec_btn:GetID()
        LootFinder.slot = 1
        LootFinder:Find()

        update(LootFinder.loot_list,callback)
    end)
    add(btn)

    local btn = WeekKeys.UI.Button(nil,WeekKeys.WeekFrame)
    btn:SetPoint("TOPLEFT",100,-40)
    btn:SetSize(40,40)
    btn:SetScript("OnEnter",function(self)
        GameTooltip:Hide();
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if self.link then
            GameTooltip:SetHyperlink(self.link)
        else
            GameTooltip:AddLine(INVTYPE_SHOULDER)
        end
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave",function()
        GameTooltip:Hide()
    end)
    btn.texture:SetTexture("interface/paperdoll/ui-paperdoll-slot-shoulder.blp")
    btn:SetScript("OnClick",function()
        local callback = function(self)
            local id = self:GetID()
            local item = LootFinder.loot_list[id]
            btn.texture:SetTexture(item.icon or QUESTION_MARK_ICON)
            btn.link = item.itemlink
            slots[3] = item.itemlink
            calc()
        end
        LootFinder.class = class_btn:GetID()
        LootFinder.spec = spec_btn:GetID()
        LootFinder.slot = 2
        LootFinder:Find()

        update(LootFinder.loot_list,callback)
    end)
    add(btn)

    local btn = WeekKeys.UI.Button(nil,WeekKeys.WeekFrame)
    btn:SetPoint("TOPLEFT",140,-40)
    btn:SetSize(40,40)
    btn:SetScript("OnEnter",function(self)
        GameTooltip:Hide();
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if self.link then
            GameTooltip:SetHyperlink(self.link)
        else
            GameTooltip:AddLine(INVTYPE_CLOAK)
        end
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave",function()
        GameTooltip:Hide()
    end)
    btn.texture:SetTexture("interface/paperdoll/ui-paperdoll-slot-chest.blp")
    btn:SetScript("OnClick",function()
        local callback = function(self)
            local id = self:GetID()
            local item = LootFinder.loot_list[id]
            btn.texture:SetTexture(item.icon or QUESTION_MARK_ICON)
            btn.link = item.itemlink
            slots[4] = item.itemlink
            calc()
        end
        LootFinder.class = class_btn:GetID()
        LootFinder.spec = spec_btn:GetID()
        LootFinder.slot = 3
        LootFinder:Find()

        update(LootFinder.loot_list,callback)
    end)
    add(btn)

    local btn = WeekKeys.UI.Button(nil,WeekKeys.WeekFrame)
    btn:SetPoint("TOPLEFT",20,-80)
    btn:SetSize(40,40)
    btn:SetScript("OnEnter",function(self)
        GameTooltip:Hide();
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if self.link then
            GameTooltip:SetHyperlink(self.link)
        else
            GameTooltip:AddLine(INVTYPE_CHEST)
        end
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave",function()
        GameTooltip:Hide()
    end)
    btn.texture:SetTexture("interface/paperdoll/ui-paperdoll-slot-chest.blp")
    btn:SetScript("OnClick",function()
        local callback = function(self)
            local id = self:GetID()
            local item = LootFinder.loot_list[id]
            btn.texture:SetTexture(item.icon or QUESTION_MARK_ICON)
            btn.link = item.itemlink
            slots[5] = item.itemlink
            calc()
        end
        LootFinder.class = class_btn:GetID()
        LootFinder.spec = spec_btn:GetID()
        LootFinder.slot = 4
        LootFinder:Find()
        --local slots = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,15}
        -- head neck shoulders back chest wrist hands waist legs boots main off ring trinket
        update(LootFinder.loot_list,callback)
    end)
    add(btn)

    local btn = WeekKeys.UI.Button(nil,WeekKeys.WeekFrame)
    btn:SetPoint("TOPLEFT",60,-80)
    btn:SetSize(40,40)
    btn:SetScript("OnEnter",function(self)
        GameTooltip:Hide();
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if self.link then
            GameTooltip:SetHyperlink(self.link)
        else
            GameTooltip:AddLine(INVTYPE_WRIST)
        end
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave",function()
        GameTooltip:Hide()
    end)
    btn.texture:SetTexture("interface/paperdoll/ui-paperdoll-slot-wrists.blp")
    btn:SetScript("OnClick",function()
        local callback = function(self)
            local id = self:GetID()
            local item = LootFinder.loot_list[id]
            btn.texture:SetTexture(item.icon or QUESTION_MARK_ICON)
            btn.link = item.itemlink
            slots[6] = item.itemlink
            calc()
        end
        LootFinder.class = class_btn:GetID()
        LootFinder.spec = spec_btn:GetID()
        LootFinder.slot = 5
        LootFinder:Find()

        update(LootFinder.loot_list,callback)
    end)
    add(btn)

    local btn = WeekKeys.UI.Button(nil,WeekKeys.WeekFrame)
    btn:SetPoint("TOPLEFT",100,-80)
    btn:SetSize(40,40)
    btn:SetScript("OnEnter",function(self)
        GameTooltip:Hide();
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if self.link then
            GameTooltip:SetHyperlink(self.link)
        else
            GameTooltip:AddLine(INVTYPE_HAND)
        end
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave",function()
        GameTooltip:Hide()
    end)
    btn.texture:SetTexture("interface/paperdoll/ui-paperdoll-slot-hands.blp")
    btn:SetScript("OnClick",function()
        local callback = function(self)
            local id = self:GetID()
            local item = LootFinder.loot_list[id]
            btn.texture:SetTexture(item.icon or QUESTION_MARK_ICON)
            btn.link = item.itemlink
            slots[7] = item.itemlink
            calc()
        end
        LootFinder.class = class_btn:GetID()
        LootFinder.spec = spec_btn:GetID()
        LootFinder.slot = 6
        LootFinder:Find()

        update(LootFinder.loot_list,callback)
    end)
    add(btn)

    local btn = WeekKeys.UI.Button(nil,WeekKeys.WeekFrame)
    btn:SetPoint("TOPLEFT",140,-80)
    btn:SetSize(40,40)
    btn:SetScript("OnEnter",function(self)
        GameTooltip:Hide();
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if self.link then
            GameTooltip:SetHyperlink(self.link)
        else
            GameTooltip:AddLine(INVTYPE_WAIST)
        end
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave",function()
        GameTooltip:Hide()
    end)
    btn.texture:SetTexture("interface/paperdoll/ui-paperdoll-slot-waist.blp")
    btn:SetScript("OnClick",function()
        local callback = function(self)
            local id = self:GetID()
            local item = LootFinder.loot_list[id]
            btn.texture:SetTexture(item.icon or QUESTION_MARK_ICON)
            btn.link = item.itemlink
            slots[8] = item.itemlink
            calc()
        end
        LootFinder.class = class_btn:GetID()
        LootFinder.spec = spec_btn:GetID()
        LootFinder.slot = 7
        LootFinder:Find()

        update(LootFinder.loot_list,callback)
    end)
    add(btn)

    local btn = WeekKeys.UI.Button(nil,WeekKeys.WeekFrame)
    btn:SetPoint("TOPLEFT",20,-120)
    btn:SetSize(40,40)
    btn:SetScript("OnEnter",function(self)
        GameTooltip:Hide();
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if self.link then
            GameTooltip:SetHyperlink(self.link)
        else
            GameTooltip:AddLine(INVTYPE_LEGS)
        end
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave",function()
        GameTooltip:Hide()
    end)
    btn.texture:SetTexture("interface/paperdoll/ui-paperdoll-slot-legs.blp")
    btn:SetScript("OnClick",function()
        local callback = function(self)
            local id = self:GetID()
            local item = LootFinder.loot_list[id]
            btn.texture:SetTexture(item.icon or QUESTION_MARK_ICON)
            btn.link = item.itemlink
            slots[9] = item.itemlink
            calc()
        end
        LootFinder.class = class_btn:GetID()
        LootFinder.spec = spec_btn:GetID()
        LootFinder.slot = 8
        LootFinder:Find()

        update(LootFinder.loot_list,callback)
    end)
    add(btn)

    local btn = WeekKeys.UI.Button(nil,WeekKeys.WeekFrame)
    btn:SetPoint("TOPLEFT",60,-120)
    btn:SetSize(40,40)
    btn:SetScript("OnEnter",function(self)
        GameTooltip:Hide();
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if self.link then
            GameTooltip:SetHyperlink(self.link)
        else
            GameTooltip:AddLine(INVTYPE_FEET)
        end
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave",function()
        GameTooltip:Hide()
    end)
    btn.texture:SetTexture("interface/paperdoll/ui-paperdoll-slot-feet.blp")
    btn:SetScript("OnClick",function()
        local callback = function(self)
            local id = self:GetID()
            local item = LootFinder.loot_list[id]
            btn.texture:SetTexture(item.icon or QUESTION_MARK_ICON)
            btn.link = item.itemlink
            slots[10] = item.itemlink
            calc()
        end
        LootFinder.class = class_btn:GetID()
        LootFinder.spec = spec_btn:GetID()
        LootFinder.slot = 9
        LootFinder:Find()

        update(LootFinder.loot_list,callback)
    end)
    add(btn)

    local btn = WeekKeys.UI.Button(nil,WeekKeys.WeekFrame)
    btn:SetPoint("TOPLEFT",100,-120)
    btn:SetSize(40,40)
    btn:SetScript("OnEnter",function(self)
        GameTooltip:Hide();
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if self.link then
            GameTooltip:SetHyperlink(self.link)
        else
            GameTooltip:AddLine(INVTYPE_FINGER)
        end
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave",function()
        GameTooltip:Hide()
    end)
    btn.texture:SetTexture("interface/paperdoll/ui-paperdoll-slot-finger.blp")
    btn:SetScript("OnClick",function()
        local callback = function(self)
            local id = self:GetID()
            local item = LootFinder.loot_list[id]
            btn.texture:SetTexture(item.icon or QUESTION_MARK_ICON)
            btn.link = item.itemlink
            slots[11] = item.itemlink
            calc()
        end
        LootFinder.class = class_btn:GetID()
        LootFinder.spec = spec_btn:GetID()
        LootFinder.slot = 12
        LootFinder:Find()

        update(LootFinder.loot_list,callback)
    end)
    add(btn)

    local btn = WeekKeys.UI.Button(nil,WeekKeys.WeekFrame)
    btn:SetPoint("TOPLEFT",140,-120)
    btn:SetSize(40,40)
    btn:SetScript("OnEnter",function(self)
        GameTooltip:Hide();
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if self.link then
            GameTooltip:SetHyperlink(self.link)
        else
            GameTooltip:AddLine(INVTYPE_FINGER)
        end
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave",function()
        GameTooltip:Hide()
    end)
    btn.texture:SetTexture("interface/paperdoll/ui-paperdoll-slot-finger.blp")
    btn:SetScript("OnClick",function()
        local callback = function(self)
            local id = self:GetID()
            local item = LootFinder.loot_list[id]
            btn.texture:SetTexture(item.icon or QUESTION_MARK_ICON)
            btn.link = item.itemlink
            slots[12] = item.itemlink
            calc()
        end
        LootFinder.class = class_btn:GetID()
        LootFinder.spec = spec_btn:GetID()
        LootFinder.slot = 12
        LootFinder:Find()

        update(LootFinder.loot_list,callback)
    end)
    add(btn)

    local btn = WeekKeys.UI.Button(nil,WeekKeys.WeekFrame)
    btn:SetPoint("TOPLEFT",20,-160)
    btn:SetSize(40,40)
    btn:SetScript("OnEnter",function(self)
        GameTooltip:Hide();
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if self.link then
            GameTooltip:SetHyperlink(self.link)
        else
            GameTooltip:AddLine(INVTYPE_TRINKET)
        end
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave",function()
        GameTooltip:Hide()
    end)
    btn.texture:SetTexture("interface/paperdoll/ui-paperdoll-slot-trinket.blp")
    btn:SetScript("OnClick",function()
        local callback = function(self)
            local id = self:GetID()
            local item = LootFinder.loot_list[id]
            btn.texture:SetTexture(item.icon or QUESTION_MARK_ICON)
            btn.link = item.itemlink
            slots[13] = item.itemlink
            calc()
        end
        LootFinder.class = class_btn:GetID()
        LootFinder.spec = spec_btn:GetID()
        LootFinder.slot = 13
        LootFinder:Find()

        update(LootFinder.loot_list,callback)
    end)
    add(btn)

    local btn = WeekKeys.UI.Button(nil,WeekKeys.WeekFrame)
    btn:SetPoint("TOPLEFT",60,-160)
    btn:SetSize(40,40)
    btn:SetScript("OnEnter",function(self)
        GameTooltip:Hide();
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if self.link then
            GameTooltip:SetHyperlink(self.link)
        else
            GameTooltip:AddLine(INVTYPE_TRINKET)
        end
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave",function()
        GameTooltip:Hide()
    end)
    btn.texture:SetTexture("interface/paperdoll/ui-paperdoll-slot-trinket.blp")
    btn:SetScript("OnClick",function()
        local callback = function(self)
            local id = self:GetID()
            local item = LootFinder.loot_list[id]
            btn.texture:SetTexture(item.icon or QUESTION_MARK_ICON)
            btn.link = item.itemlink
            slots[14] = item.itemlink
            calc()
        end
        LootFinder.class = class_btn:GetID()
        LootFinder.spec = spec_btn:GetID()
        LootFinder.slot = 13
        LootFinder:Find()

        update(LootFinder.loot_list,callback)
    end)
    add(btn)

    local btn = WeekKeys.UI.Button(nil,WeekKeys.WeekFrame)
    btn:SetPoint("TOPLEFT",100,-160)
    btn:SetSize(40,40)
    btn:SetScript("OnEnter",function(self)
        GameTooltip:Hide();
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if self.link then
            GameTooltip:SetHyperlink(self.link)
        else
            GameTooltip:AddLine(INVTYPE_WEAPONMAINHAND)
        end
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave",function()
        GameTooltip:Hide()
    end)
    btn.texture:SetTexture("interface/paperdoll/ui-paperdoll-slot-mainhand.blp")
    btn:SetScript("OnClick",function()
        local callback = function(self)
            local id = self:GetID()
            local item = LootFinder.loot_list[id]
            btn.texture:SetTexture(item.icon or QUESTION_MARK_ICON)
            btn.link = item.itemlink
            slots[15] = item.itemlink
            calc()
        end
        LootFinder.class = class_btn:GetID()
        LootFinder.spec = spec_btn:GetID()
        LootFinder.slot = 10
        LootFinder:Find()

        update(LootFinder.loot_list,callback)
    end)
    add(btn)

    local btn = WeekKeys.UI.Button(nil,WeekKeys.WeekFrame)
    btn:SetPoint("TOPLEFT",140,-160)
    btn:SetSize(40,40)
    btn:SetScript("OnEnter",function(self)
        GameTooltip:Hide();
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        if self.link then
            GameTooltip:SetHyperlink(self.link)
        else
            GameTooltip:AddLine(INVTYPE_SHIELD)
        end
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave",function()
        GameTooltip:Hide()
    end)
    btn.texture:SetTexture("interface/paperdoll/ui-paperdoll-slot-secondaryhand.blp")
    btn:SetScript("OnClick",function()
        local callback = function(self)
            local id = self:GetID()
            local item = LootFinder.loot_list[id]
            btn.texture:SetTexture(item.icon or QUESTION_MARK_ICON)
            btn.link = item.itemlink
            slots[16] = item.itemlink
            calc()
        end
        LootFinder.class = class_btn:GetID()
        LootFinder.spec = spec_btn:GetID()
        LootFinder.slot = 11
        LootFinder:Find()

        update(LootFinder.loot_list,callback)
    end)
    add(btn)


    local fontstr = WeekKeys.WeekFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    fontstr:SetPoint("TOPLEFT",30,-220)
    fontstr:SetText(CLASS)
    add(fontstr)

    local btn = WeekKeys.UI.Button(nil,WeekKeys.WeekFrame)
    btn:SetPoint("TOPLEFT",150,-210)
    btn:SetSize(30,30)
    btn.texture:SetTexture(QUESTION_MARK_ICON)
    btn:SetScript("OnClick",function()
        local callback = function(clicked)
            local classid = clicked:GetID()
            btn.texture:SetTexture(classlist[classid].icon)
            btn.texture:SetTexCoord(unpack(classlist[classid].coords))
            btn:SetID(classid)
            LootFinder.class = classid
        end
        update(classlist,callback)
    end)
    class_btn = btn
    add(btn)

    local fontstr = WeekKeys.WeekFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    fontstr:SetPoint("TOPLEFT",30,-260)
    fontstr:SetText(SPECIALIZATION)
    add(fontstr)

    local btn = WeekKeys.UI.Button(nil,WeekKeys.WeekFrame)
    btn:SetPoint("TOPLEFT",150,-250)
    btn:SetSize(30,30)
    btn.texture:SetTexture(QUESTION_MARK_ICON)
    btn:SetScript("OnClick",function()

        local callback = function(self)
            local id = self:GetID()
            if id == 0 then
                btn.texture:SetTexture(QUESTION_MARK_ICON)
            else
                local id, _, _, icon = GetSpecializationInfoByID(id)
                btn.texture:SetTexture(icon)
            end
            btn:SetID(id)
            LootFinder.spec = spec_btn:GetID()
            calc()
        end
        -- print(class_btn:GetID())
        local spec_ids = LootFinder.class_spec[class_btn:GetID()]
        -- id, name, description, icon, role, classFile, className     = GetSpecializationInfoByID(specID)
        local tbl = {}
        for i = 1, #spec_ids do
            local id, name, _, icon = GetSpecializationInfoByID(spec_ids[i])
            tbl[#tbl + 1] = {name = name, icon = icon, ID = id}
        end
        update(tbl, callback)

    end)
    spec_btn = btn
    add(btn)

    local fontstr = WeekKeys.WeekFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    fontstr:SetPoint("TOPLEFT",20,-290)
    stat_labels[1] = fontstr
    add(fontstr)

    local fontstr = WeekKeys.WeekFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    fontstr:SetPoint("TOPLEFT",20,-310)
    stat_labels[2] = fontstr
    add(fontstr)

    local fontstr = WeekKeys.WeekFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    fontstr:SetPoint("TOPLEFT",20,-330)
    stat_labels[3] = fontstr
    add(fontstr)

    local fontstr = WeekKeys.WeekFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    fontstr:SetPoint("TOPLEFT",20,-350)
    stat_labels[4] = fontstr
    add(fontstr)


    WeekKeys.AddButton(L["Dressingtab"],elements)
end)
