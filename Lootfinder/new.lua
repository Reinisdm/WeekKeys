LF = {}
LF.__index = LF
LF.tables = {}

function LF:New(tbl,db)
    tbl = tbl or {}
    tbl.db = db
    tbl.results = {}
    tbl.selectedstats = {}

    return setmetatable(tbl, self)
end