LF = {}

function LF:New(tbl)
    tbl = tbl or {}
    tbl.results = {}
    setmetatable(tbl, self)
end