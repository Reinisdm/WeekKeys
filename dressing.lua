
local elements = {}
local function add(arg1)
    elements[#elements+1] = arg1
	arg1:Hide()
end

local L = WeekKeys.L
local res = {}
local stats = {}
local specID = 0

--[[ Icon list for future
136530 wrists
136529 waist
136528 trinket
136526 shoulder
136525 shirt
136524 secondaryhand
136523 rfinger
136519 neck
136518 mainhand
136517 legs
136516 head
136515 hands
136513 feet
136512 chest

--]]
local doubleweapon = {
	[72] = true,
	[259] = true,
	[260] = true,
	[261] = true,
	[251] = true,
	[263] = true,
	[268] = true,
	[269] = true,
	[577] = true,
	[581] = true
}
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
local function update()
	LootFinder:Find()
	for i=7,22 do 
		elements[i].reset()
	end
end

local function calculate()
	table.wipe(res)
	res.ITEM_MOD_CRIT_RATING_SHORT = 0
	res.ITEM_MOD_HASTE_RATING_SHORT = 0
	res.ITEM_MOD_VERSATILITY = 0
	res.ITEM_MOD_MASTERY_RATING_SHORT = 0
	for i=7,22 do 
		if elements[i].link then
			GetItemStats(elements[i].link,stats)
			for a,b in pairs(stats) do
				res[a] = res[a] or 0
				res[a] = res[a] + b
			end
			table.wipe(stats)
		end
	end
	elements[2]:SetData(res["ITEM_MOD_CRIT_RATING_SHORT"],res["ITEM_MOD_CRIT_RATING_SHORT"]/35)
	elements[3]:SetData(res["ITEM_MOD_HASTE_RATING_SHORT"],res["ITEM_MOD_HASTE_RATING_SHORT"]/33)
	elements[4]:SetData(res["ITEM_MOD_VERSATILITY"],res["ITEM_MOD_VERSATILITY"]/40)
	elements[5]:SetData(res["ITEM_MOD_MASTERY_RATING_SHORT"],res["ITEM_MOD_MASTERY_RATING_SHORT"]/masteryval[specID])
end
WeekKeys.AddInit(
function()
	local scrframe = CreateFrame('Frame',nil,WeekKeys.WeekFrame.ScrollFrame)
    scrframe:SetFrameStrata("BACKGROUND")
    scrframe:SetSize(480,5)
    WeekKeys.WeekFrame.ScrollFrame:SetScrollChild(scrframe)
    scrframe:SetScript("OnShow",function()
		WeekKeys.WeekFrame.ScrollFrame:ClearAllPoints()
        WeekKeys.WeekFrame.ScrollFrame:SetPoint("TOPLEFT", WeekKeys.WeekFrame, "TOPLEFT", 4, -110);
        WeekKeys.WeekFrame.ScrollFrame:SetPoint("BOTTOMRIGHT",  WeekKeys.WeekFrame, "BOTTOMRIGHT", -5, 5);
    end)
    scrframe:SetScript("OnHide",function()

    end)
	add(scrframe)

	local crit = WeekKeys.WeekFrame:CreateFontString(nil , "ARTWORK", "GameFontNormal")
    crit:SetPoint("TOPLEFT", 20,-30)
    crit:SetText(STAT_CRITICAL_STRIKE)
	crit.SetData = function(self,val,perc) self:SetFormattedText("%s :|cffffffff %d (+%.2f%%) ",STAT_CRITICAL_STRIKE,val or 0,perc or 0.00)end
    add(crit)

	local haste = WeekKeys.WeekFrame:CreateFontString(nil , "ARTWORK", "GameFontNormal")
    haste:SetPoint("TOPLEFT", 20,-50)
    haste:SetText(STAT_HASTE)
	haste.SetData = function(self,val,perc) self:SetFormattedText("%s :|cffffffff %d (+%.2f%%)",STAT_HASTE,val or 0,perc or 0.00)end
    add(haste)

	local versa = WeekKeys.WeekFrame:CreateFontString(nil , "ARTWORK", "GameFontNormal")
    versa:SetPoint("TOPLEFT", 20,-70)
    versa:SetText(STAT_VERSATILITY)
	versa.SetData = function(self,val,perc) self:SetFormattedText("%s :|cffffffff %d (+%.2f%%)",STAT_VERSATILITY,val or 0,perc or 0.00)end
    add(versa)

	local mastery = WeekKeys.WeekFrame:CreateFontString(nil , "ARTWORK", "GameFontNormal")
    mastery:SetPoint("TOPLEFT", 20,-90)
    mastery:SetText(STAT_MASTERY)
	mastery.SetData = function(self,val,perc) self:SetFormattedText("%s :|cffffffff %d (+%.2f%%)",STAT_MASTERY,val or 0,perc or 0.00)end
    add(mastery)

	LootFinder:Find()

	local icons = {133070,133292,135061,133771,132751,132616,132939,132511,134584,132535,135317,134959,801523,801523,133441,133441}
	local slots = {0,1,2,3,4,5,6,7,8,9,10,11,12,12,13,13}
	--12
	local _, _, classID = UnitClass("player")
	LootFinder.class = classID
	LootFinder.spec = LootFinder.class_spec[classID][GetSpecialization()]
	specID = LootFinder.spec

	local issbtn = WeekKeys.UI.Button(nil,WeekKeys.WeekFrame,true)
	issbtn:SetSize(100,30)
	issbtn:SetPoint("TOPLEFT",350,-25)
	issbtn:SetText(L["info"])
	issbtn:SetScript("OnEnter",function(self)
		GameTooltip:Hide();
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetWidth(200)
		GameTooltip:AddLine(L["info tooltip"],1,1,1)
		GameTooltip:Show()
	end)
	issbtn:SetScript("OnLeave",function(self)
		GameTooltip:Hide();
	end)
	add(issbtn)

	for a,b in pairs(icons) do
		--C_Timer.After(a,function()
		local btn = WeekKeys.UI.Button(nil,scrframe)
		btn:SetSize(30,30)
		btn.texture:SetTexture(b)
		btn:SetPoint("TOPLEFT",10,30-30*a)

		btn:SetScript("OnEnter",function(self)
			if not self.link then return end
			GameTooltip:Hide();
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetHyperlink(self.link,1,1,1)
			GameTooltip:Show()
		end)

		btn:SetScript("OnLeave",function(self)
			GameTooltip:Hide();
		end)
		btn:SetID(slots[a])
		btn.btnlist = {}
		local pattern = "5:7214:6652:1501:5868:6646"
		btn.reset = function ()
			local id = btn:GetID()
			if (id == 11) and doubleweapon[LootFinder.spec] then
				id = 10
			else
				LootFinder.slot = id
				LootFinder:Find()
			end

			for c,d in pairs(LootFinder.LootList) do
				local linkstr = d[2]:gsub("%d+:3524:%d+:%d+:%d+:",pattern)
				local _,_,_,_,_,_,_,_,_,iconid,_,_,subtypeID = GetItemInfo(d[2])
				if not btn.btnlist[c] then
					itembtn = WeekKeys.UI.Button(nil,scrframe)
					itembtn:SetSize(30,30)
					itembtn:SetPoint("TOPLEFT",40+30*c,30-30*a)
					
					itembtn:SetID(6+a)
					itembtn:SetScript("OnClick",function(self) 
						local myid = self:GetID()
						elements[myid].texture:SetTexture(self.iconid)
						elements[myid].link = self.itemstr
						calculate()
					end)
					
					itembtn:SetScript("OnEnter",function(self)
						GameTooltip:Hide();
						GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
						GameTooltip:SetHyperlink(self.itemstr,1,1,1)
						GameTooltip:Show()
					end)
					itembtn:SetScript("OnLeave",function(self)
						GameTooltip:Hide();
					end)
					btn.btnlist[c] = itembtn
				end
				btn.btnlist[c].texture:SetTexture(iconid)
				btn.btnlist[c].itemstr = linkstr
				btn.btnlist[c].iconid = iconid

				btn.btnlist[c]:Show()
			end
			for i = #LootFinder.LootList+1, #btn.btnlist do
				btn.btnlist[i]:Hide()
			end
		end
		add(btn)
	end
	local from = #elements + 1
	for i = 1, #LootFinder.class_spec[classID] do
		local specbtn = WeekKeys.UI.Button(nil,WeekKeys.WeekFrame,true)
		specbtn.texture2:SetColorTexture(1,1,1,0)
		specbtn:SetPoint("TOPLEFT",300+35*i,-60)
		specbtn:SetSize(35,35)
		specbtn:SetID(LootFinder.class_spec[classID][i])
		specbtn:SetScript("OnClick",function(self)
			for j = from, #elements do 
				elements[j].texture2:SetColorTexture(1,1,1,0)
			end
			self.texture2:SetColorTexture(1,1,1,0.4)
			LootFinder.class = classID 
			LootFinder.spec = self:GetID()
			update()
		end)
		local _, _, _, icon, _, _ = GetSpecializationInfoByID(LootFinder.class_spec[classID][i])
		specbtn.texture:SetTexture(icon)
		if GetSpecialization() == i then specbtn:Click() end
		add(specbtn)
	end
	C_Timer.After(1,update)
    WeekKeys.AddButton(DRESSUP_FRAME,elements)
end)
