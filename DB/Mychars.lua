local MycharDB = WeekKeys.DB:New({})
local Convert = WeekKeys.Convert
local update_version = WeekKeys.Patterns.CurrentVersion

MycharDB.db = WeekKeysDB.Characters

function MycharDB:tostring()
    local str = update_version .. " "
    for _, player in ipairs(self.db) do
        str = str .. "_" .. Convert.TblToStr(update_version, player)
    end
    return str
end

function MycharDB:toFactionString()

end

function MycharDB:CurrentChar()

end

function MycharDB:pairs()

end