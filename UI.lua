WeekKeys.UI = {}


function WeekKeys.UI.Button(name, parent, bool)
    local button = CreateFrame('Button', name, parent)


    local txt = button:CreateTexture('textureName', 'BACKGROUND')
    txt:SetPoint('TOPLEFT', 2, 0)
    txt:SetPoint('bottomright', -2, 0)
    txt:SetColorTexture(1,1,1,0.2)
    button:SetHighlightTexture(txt)

    button.texture = button:CreateTexture('textureName', 'CENTER')
    button.texture:SetPoint('TOPLEFT', 2, 0)
    button.texture:SetPoint('bottomright', -2, 0)
    button.texture:SetColorTexture(0.2, 0.2, 0.2, 0)

    button:DisableDrawLayer("BORDER")
    button:SetNormalFontObject('GameFontNormal')

    if parent and parent:GetObjectType() == "Frame" then
        button:SetSize(parent:GetWidth()-4, 20)
        button:SetPoint("TOPLEFT",0,-parent:GetHeight())
    elseif parent and parent:GetObjectType() == "Button" then
        button:SetSize(parent:GetSize())
        button:SetPoint("TOPLEFT",0,-parent:GetHeight())
    end

    if bool then
        button.texture2 = button:CreateTexture('textureName2', 'ARTWORK')
        button.texture2:SetAllPoints(true)
        button.texture2:SetColorTexture(0.2, 0.2, 0.2, 1)
        button:SetNormalTexture(texture2)
    end

    return button
end

function WeekKeys.UI.CharacterButton(name, parent)
    local btn = WeekKeys.UI.Button(name, parent)
    local height = btn:GetHeight()
    btn:RegisterForClicks("RightButtonUp","LeftButtonUp")
    --------------------- faction -----------------
    btn.faction = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.faction:SetPoint("LEFT", 0,-2)
    btn.faction:SetSize(25, height)
    function btn:SetFaction(faction)
        if faction == "A" or faction == "Alliance" then
            self.faction:SetText("|Tinterface/groupframe/ui-group-pvp-alliance.blp:20:20|t")
        elseif faction == "H" or faction == "Horde" then
            self.faction:SetText("|Tinterface/battlefieldframe/battleground-horde.blp:20:20|t")
        else
            self.faction:SetText("")
        end
    end

    --------------------- name ----------------------
    btn.name = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.name:SetPoint("LEFT",20,0)
    btn.name:SetSize(160,height)
    btn.name:SetJustifyH("LEFT")
    function btn:SetName(name,realm)
        self.name:SetText(name or "")
    end

    --------------------- ilvl ----------------------
    btn.ilvl = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.ilvl:SetPoint("LEFT",180,0)
    btn.ilvl:SetSize(60,height)
    function btn:Setilvl(ilvl)
        self.ilvl:SetText(ilvl or "")
    end

    --------------------- record ----------------------
    btn.record = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.record:SetPoint("LEFT",240,0)
    btn.record:SetSize(50,height)
    function btn:SetRecord(record)
        self.record:SetText(record or "")
    end

    --------------------- keystone ----------------------
    btn.keystone = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.keystone:SetPoint("LEFT",290,0) -- 470
    btn.keystone:SetSize(180,height)
    btn.keystone:SetJustifyH("LEFT")
    btn.keystone:SetTextColor(1,1,1)
    function btn:SetKeystone(keystone)
        self.keystone:SetText(keystone or "")
    end

    --------------------- reward ----------------------
    btn.reward = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.reward:SetPoint("RIGHT",-30,0) -- 470
    btn.reward:SetSize(30,height)
    function btn:SetReward(bool)
        if bool then
            btn.reward:SetText("|Tinterface/worldmap/treasurechest_64.blp:20:20|t")
        else
            btn.reward:SetText("")
        end
    end

    return btn
end

function WeekKeys.UI.ThorgastButton(name, parent)
    local btn = WeekKeys.UI.Button(name, parent)
    local height = btn:GetHeight()

    --------------------- faction -----------------
    btn.faction = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.faction:SetPoint("LEFT", 0,-2)
    btn.faction:SetSize(25, height)
    function btn:SetFaction(faction)
        if faction == "A" or faction == "Alliance" then
            self.faction:SetText("|Tinterface/groupframe/ui-group-pvp-alliance.blp:20:20|t")
        elseif faction == "H" or faction == "Horde" then
            self.faction:SetText("|Tinterface/battlefieldframe/battleground-horde.blp:20:20|t")
        else
            self.faction:SetText("")
        end
    end

    --------------------- name ----------------------
    btn.name = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.name:SetPoint("LEFT",20,0)
    btn.name:SetSize(160,height)
    btn.name:SetJustifyH("LEFT")
    function btn:SetName(name,realm)
        self.name:SetText(name or "")
    end
   


    --------------------- record ----------------------
    btn.record = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.record:SetPoint("LEFT",200,0)
    btn.record:SetSize(50,height)
    btn.record:SetTextColor(1,1,1)

    --------------------- record2 ----------------------
    btn.record2 = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.record2:SetPoint("LEFT",250,0)
    btn.record2:SetSize(50,height)
    btn.record2:SetTextColor(1,1,1)
    function btn:SetRecords(record,record2)
        record = record or 0
        record2 = record2 or 0

        self.record:SetText(record .. "/8")
        self.record2:SetText(record2 .. "/8")
    end

    

    return btn
end

function WeekKeys.UI.FactionCovenantButton(name, parent)
    local btn = WeekKeys.UI.Button(name, parent)
    local height = btn:GetHeight()
    btn:RegisterForClicks("RightButtonUp","LeftButtonUp")

    --------------------- faction -----------------
    btn.faction = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.faction:SetPoint("LEFT", 0,-2)
    btn.faction:SetSize(25, height)
    function btn:SetFaction(faction)
        if faction == "A" or faction == "Alliance" then
            self.faction:SetText("|Tinterface/groupframe/ui-group-pvp-alliance.blp:20:20|t")
        elseif faction == "H" or faction == "Horde" then
            self.faction:SetText("|Tinterface/battlefieldframe/battleground-horde.blp:20:20|t")
        else
            self.faction:SetText("")
        end
    end
    ------------------------ covenant ---------------
    btn.covenant = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.covenant:SetPoint("LEFT", 20,-2)
    btn.covenant:SetSize(25, height)
    function btn:SetCovenant(covenantID)
        covenantID = tonumber(covenantID)
        if covenantID == 1 then
            self.covenant:SetText("|Tinterface/icons/ui_sigil_kyrian.blp:20:20|t")
        elseif covenantID == 2 then
            self.covenant:SetText("|Tinterface/icons/ui_sigil_venthyr.blp:20:20|t")
        elseif covenantID == 3 then
            self.covenant:SetText("|Tinterface/icons/ui_sigil_nightfae.blp:20:20|t")
        elseif covenantID == 4 then
            self.covenant:SetText("|Tinterface/icons/ui_sigil_necrolord.blp:20:20|t")
        else
            self.covenant:SetText("")
        end
    end

    --------------------- name ----------------------
    btn.name = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.name:SetPoint("LEFT",45,0)
    btn.name:SetSize(140,height)
    btn.name:SetJustifyH("LEFT")
    function btn:SetName(name,realm)
        self.name:SetText(name or "")
    end
     ----------------- faction -----------------------
     btn.realm = ""
     function btn:SetRealm(str)
         self.realm = str
     end

     function btn:GetNameFaction()
         local name = self.name:GetText():gsub(" %(%*%)",""):sub(11,-3)
         return name, self.realm
     end

    --------------------- ilvl ----------------------
    btn.ilvl = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.ilvl:SetPoint("LEFT",180,0)
    btn.ilvl:SetSize(60,height)
    function btn:Setilvl(ilvl)
        self.ilvl:SetText(ilvl or "")
    end

    --------------------- record ----------------------
    btn.record = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.record:SetPoint("LEFT",240,0)
    btn.record:SetSize(50,height)
    function btn:SetRecord(record)
        self.record:SetText(record or "")
    end

    --------------------- keystone ----------------------
    btn.keystone = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.keystone:SetPoint("LEFT",290,0) -- 470
    btn.keystone:SetSize(180,height)
    btn.keystone:SetJustifyH("LEFT")
    btn.keystone:SetTextColor(1,1,1)
    function btn:SetKeystone(keystone)
        self.keystone:SetText(keystone or "")
    end

    --------------------- reward ----------------------
    btn.reward = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.reward:SetPoint("RIGHT",-30,0) -- 470
    btn.reward:SetSize(30,height)
    function btn:SetReward(bool)
        if bool then
            btn.reward:SetText("|Tinterface/worldmap/treasurechest_64.blp:20:20|t")
        else
            btn.reward:SetText("")
        end
    end

    return btn
end

function WeekKeys.UI.CovenantButton(name, parent)
    local btn = WeekKeys.UI.Button(name, parent)
    local height = btn:GetHeight()
    btn:RegisterForClicks("RightButtonUp","LeftButtonUp")

    
    ------------------------ covenant ---------------
    btn.covenant = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.covenant:SetPoint("LEFT", 0,-2)
    btn.covenant:SetSize(25, height)
    function btn:SetCovenant(covenantID)
        if covenantID == 1 then
            self.covenant:SetText("|Tinterface/icons/ui_sigil_kyrian.blp:20:20|t")
        elseif covenantID == 2 then
            self.covenant:SetText("|Tinterface/icons/ui_sigil_venthyr.blp:20:20|t")
        elseif covenantID == 3 then
            self.covenant:SetText("|Tinterface/icons/ui_sigil_nightfae.blp:20:20|t")
        elseif covenantID == 4 then
            self.covenant:SetText("|Tinterface/icons/ui_sigil_necrolord.blp:20:20|t")
        else
            self.covenant:SetText("")
        end
    end

    --------------------- name ----------------------
    btn.name = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.name:SetPoint("LEFT",25,0)
    btn.name:SetSize(160,height)
    btn.name:SetJustifyH("LEFT")
    function btn:SetName(name,realm)
        self.name:SetText(name or "")
    end
     ----------------- faction -----------------------
     btn.realm = ""
     function btn:SetRealm(str)
         self.realm = str
     end
 
     function btn:GetNameFaction()
         local name = self.name:GetText():gsub(" %(%*%)",""):sub(11,-3) 
         return name, self.realm
     end

    --------------------- ilvl ----------------------
    btn.ilvl = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.ilvl:SetPoint("LEFT",180,0)
    btn.ilvl:SetSize(60,height)
    function btn:Setilvl(ilvl)
        self.ilvl:SetText(ilvl or "???")
    end

    --------------------- record ----------------------
    btn.record = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.record:SetPoint("LEFT",240,0)
    btn.record:SetSize(50,height)
    function btn:SetRecord(record)
        self.record:SetText(record or "")
    end

    --------------------- keystone ----------------------
    btn.keystone = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.keystone:SetPoint("LEFT",290,0) -- 470
    btn.keystone:SetSize(180,height)
    btn.keystone:SetJustifyH("LEFT")
    btn.keystone:SetTextColor(1,1,1)
    function btn:SetKeystone(keystone)
        self.keystone:SetText(keystone or "")
    end

    --------------------- reward ----------------------
    btn.reward = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.reward:SetPoint("RIGHT",-30,0) -- 470
    btn.reward:SetSize(30,height)
    function btn:SetReward(bool)
        if bool then
            btn.reward:SetText("|Tinterface/worldmap/treasurechest_64.blp:20:20|t")
        else
            btn.reward:SetText("")
        end
    end

    return btn
end

function WeekKeys.UI.MTableButton(name,parent,bool)
    local btn = WeekKeys.UI.Button(name, parent, bool)
    local height = btn:GetHeight()

    btn.level = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.level:SetPoint("LEFT", 20,0)
    btn.level:SetSize(35, height)
    btn.level:SetTextColor(1,1,1)

    btn.week = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.week:SetPoint("LEFT", 55,0)
    btn.week:SetSize(135, height)
    btn.week:SetTextColor(1,1,1)

    btn.push = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.push:SetPoint("LEFT", 190,0)
    btn.push:SetSize(125, height)
    btn.push:SetTextColor(1,1,1)

    btn.rio = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.rio:SetPoint("LEFT", 315,0)
    btn.rio:SetSize(50, height)
    btn.rio:SetTextColor(1,1,1)

    btn.mod = btn:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    btn.mod:SetPoint("LEFT", 365,0)
    btn.mod:SetSize(85, height)
    btn.mod:SetTextColor(1,1,1)

    function btn:SetData(level, week, push, rio, mod)
        btn.level:SetText(level)
        btn.week:SetText(week)
        btn.push:SetText(push)
        btn.rio:SetText(rio)
        btn.mod:SetText(mod)
    end

    return btn
end

--- Create 'LootFinders' row
---@param name string rows name (nilable)
---@param parent Frame parent frame
---@return Button LootFinders_row button with Set### functions
function WeekKeys.UI.LootFinderButton(name,parent)
    local btn = WeekKeys.UI.Button(name, parent)

    -- icon
    btn.icon = btn:CreateTexture('textureName', 'CENTER')
    btn.icon:SetPoint("LEFT",5,0)
    btn.icon:SetSize(18,18)
    ---Set Loot texture
    ---@param self Button
    ---@param iconID integer
    btn.SetIcon = function (self,iconID)
        self.icon:SetTexture(iconID)
    end

    -- dungeon
    btn.instance = btn:CreateFontString(nil , "ARTWORK", "GameFontNormal")
    btn.instance:SetPoint("LEFT",25,0)
    btn.instance:SetSize(200,20)
    btn.instance:SetJustifyH("LEFT")
    ---Set dungeon name
    ---@param self Button
    ---@param dungeon string name of dungeon
    btn.SetDungeon = function (self, dungeon)
        self.instance:SetText(dungeon or "")
    end

    -- main atr
    btn.mainatr = btn:CreateFontString(nil , "ARTWORK", "GameFontNormal")
    btn.mainatr:SetPoint("LEFT",230,0)
    btn.mainatr:SetSize(50,20)
    ---Set Main atr value
    ---@param self Button
    ---@param mainatr integer str/agi/int value
    btn.SetMainAtr = function (self, mainatr)
        self.mainatr:SetText(mainatr or 0)
    end

    -- crit
    btn.crit = btn:CreateFontString(nil , "ARTWORK", "GameFontNormal")
    btn.crit:SetPoint("LEFT",280,0)
    btn.crit:SetSize(50,20)
    ---Set Crit value
    ---@param self Button
    ---@param crit integer crit value
    btn.SetCrit = function (self, crit)
        self.crit:SetText(crit or 0)
    end

    -- haste
    btn.haste = btn:CreateFontString(nil , "ARTWORK", "GameFontNormal")
    btn.haste:SetPoint("LEFT",330,0)
    btn.haste:SetSize(50,20)
    ---Set haste value
    ---@param self Button
    ---@param haste integer haste value
    btn.SetHaste = function (self, haste)
        self.haste:SetText(haste or 0)
    end

    -- mastery
    btn.mastery = btn:CreateFontString(nil , "ARTWORK", "GameFontNormal")
    btn.mastery:SetPoint("LEFT",380,0)
    btn.mastery:SetSize(50,20)
    ---Set mastery value
    ---@param self Button
    ---@param mastery integer mastery value
    btn.SetMastery = function (self, mastery)
        self.mastery:SetText(mastery or 0)
    end

    -- vers
    btn.versality = btn:CreateFontString(nil , "ARTWORK", "GameFontNormal")
    btn.versality:SetPoint("LEFT",430,0)
    btn.versality:SetSize(50,20)
    ---Set versality value
    ---@param self Button
    ---@param versality integer versality value
    btn.SetVersality = function (self, versality)
        self.versality:SetText(versality or 0)
    end

    btn:SetScript("OnEnter",function(self)
        if not self.link then return end
        GameTooltip:Hide()
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetHyperlink(self.link)
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave",function()
        GameTooltip:Hide()
    end)

    return btn
end
