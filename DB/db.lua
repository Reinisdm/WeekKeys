local DB = {}
WeekKeys.DB = DB

-- create new db object
function DB:New(tbl)
    return setmetatable(tbl,self)
end

-- add character to db
function DB:Add(newchar)
    for _, char in pairs(self.DB) do
        if char.name == newchar.name then
            
        end
    end

end

-- delete character from db
function DB:Delete(char)

end

-- expand player
function DB:Expand(sender)

end

-- 
function DB:toCharacters(str)

end
