local DB = {}
WeekKeys.DB = DB

-- create new db object
function DB:New(tbl)
    return setmetatable(tbl,self)
end

-- add character to db
function DB:Add(char)

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
