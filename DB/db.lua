local DB = {}
local Convert = WeekKeys.Convert
local update_version = WeekKeys.Patterns.CurrentVersion
WeekKeys.DB = DB


function DB:New(tbl)
    return setmetatable(tbl,self)
end

function DB:tostring()
    local str = update_version .. " "
    for _, player in ipairs(self.db) do
        str = str .. "_" .. Convert.TblToStr(update_version, player)
    end
    return str
end

function DB:toFactionString()

end

function DB:Add()

end

function DB:Delete()

end

function DB:GetRef()

end