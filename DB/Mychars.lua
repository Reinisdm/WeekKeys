WeekKeys.MyChars = WeekKeys.DB:New()

local MycharDB = WeekKeys.MyChars
local Convert = WeekKeys.Convert
local update_version = WeekKeys.Patterns.CurrentVersion

function MycharDB:tostring()
    if not self.db then return end
    local str = update_version .. " "
    for _, player in ipairs(self.db) do
        str = str .. "_" .. Convert.TblToStr(update_version, player)
    end
    return str
end

function MycharDB:toFactionString()
    if not self.db then return end
    local faction = UnitFactionGroup("player"):sub(1,1) -- 'A' or 'H'
    local str = update_version .. " "
    for _, player in ipairs(self.db) do
        if player.faction == faction then
            str = str .. "_" .. Convert.TblToStr(update_version, player)
        end
    end
    return str
end

function MycharDB:CurrentChar()
    if not self.db then return end

    local name = UnitName("Player")
    local realm = GetRealmName():gsub(' ','')

    -- if char exist
    for _, player in ipairs(self.db) do
        if player.name == name and player.realm == realm then
            return player
        end
    end

    -- if char not exist in db
    if UnitLevel("player") == 60 then
        self.db[#self.db + 1] = {} -- create new char
        player = self.db[#self.db] -- get current char
        player.name = name
        player.realm = realm
        return player
    end

    return {} -- return table to prevent errors
end

function MycharDB:pairs()
    if not self.db then return end
    local i = 0
    return function()
        i = i + 1

        if not self.db[i] then return end

        local char = self.db[i]
        local formatted = WeekKeys.Convert.Player(char)

        return i, formatted
    end
end
