
-- class to gear type
-- warrior -> plate
-- priest -> cloth
local gear_type = {
    [1] = 4,
    [2] = 4,
    [3] = 3,
    [4] = 2,
    [5] = 1,
    [6] = 4,
    [7] = 3,
    [8] = 1,
    [9] = 1,
    [10] = 2,
    [11] = 2,
    [12] = 2
}

local shields = {
    [1] = true,   -- [class] warrior
    [73] = true,  -- [spec]  protection

    [2] = true,   -- [class] paladin
    [65] = true,  -- [spec]  holy
    [66] = true,  -- [spec]  protection

    [7] = true,   -- [class] shaman
    [262] = true, -- [spec]  elemental
    [264] = true, -- [spec]  restoration
}

local offhand = {
    [5] = true, -- priest
    [256] = true, -- discipline
    [257] = true, -- holy
    [258] = true, -- shadow

    [8] =  true, -- mage
    [62] = true, -- arcane
    [63] = true, -- fire
    [64] = true,  -- frost

    [9] = true, -- warlock
    [265] = true, -- affliction
    [266] = true, -- demonology
    [267] = true,  -- destruction

    [10] = true, -- monk
    [270] = true, -- mistweaver

    [11] = true, -- druid
    [102] = true, -- balance
    [105] = true, -- restoration
}

local weapons = {
    [0] = { -- 1H axes

        [1] = true, -- warrior
        [72] = true, -- fury
        [73] = true, -- protection

        [2] = true, -- paladin
        [65] = true, -- holy
        [66] = true, -- protection

        [4] = true, -- rogue
        [260] = true, -- outlaw

        [6] = true, -- death knight
        [251] = true, -- frost

        [7] = true, -- shaman
        [263] = true, -- enchancement

        [10] = true, -- monk
        [269] = true, -- windwalker

        [12] = true, -- demon hunter
        [577] = true, -- havoc
        [581] = true  -- vengeance
    },
    [1] = { -- 2H axes
        [1] = true, -- warrior
        [71] = true, -- arms
        [72] = true, -- fury

        [2] = true, -- paladin
        [70] = true, -- retribution

        [6] = true, -- death knight
        [250] = true, -- blood
        [251] = true, -- frost
        [252] = true, -- unholy
    },
    [2] = { -- bows
        [3] = true, -- hunter
        [253] = true,-- beast mastery
        [254] = true -- marksmanship
    },
    [3] = { -- guns
        [3] = true, -- hunter
        [253] = true,-- beast mastery
        [254] = true -- marksmanship
    },
    [4] = {  -- 1H maces
        [1] = true, -- warrior
        [72] = true, -- fury
        [73] = true, -- protection

        [2] = true, -- paladin
        [65] = true, -- holy
        [66] = true, -- protection

        [4] = true, -- rogue
        [260] = true, -- outlaw

        [5] = true, -- priest
        [256] = true, -- discipline
        [257] = true, -- holy
        [258] = true, -- shadow

        [6] = true, -- death knight
        [251] = true, -- frost

        [7] = true, -- shaman
        [263] = true, -- enchancement

        [10] = true, -- monk
        [269] = true, -- windwalker
        [270] = true, -- mistweaver

        [12] = true, -- demon hunter
        [577] = true, -- havoc
        [581] = true  -- vengeance
    },
    [5] = { -- 2H maces
        [1] = true, -- warrior
        [71] = true, -- arms
        [72] = true, -- fury

        [2] = true, -- paladin
        [70] = true, -- retribution

        [6] = true, -- death knight
        [250] = true, -- blood
        [251] = true, -- frost
        [252] = true, -- unholy
    },
    [6] = {-- polearms
        [3] = true, -- hunter
        [255] = true, -- survival

        [11] = true, -- druid
        [103] = true, -- feral
        [104] = true, -- balance
    },
    [7] = { -- 1H swords
        [1] = true, -- warrior
        [72] = true, -- fury
        [73] = true, -- protection

        [2] = true, -- paladin
        [65] = true, -- holy
        [66] = true, -- protection

        [4] = true, -- rogue
        [260] = true, -- outlaw

        [6] = true, -- death knight
        [251] = true, -- frost

        [7] = true, -- shaman
        [263] = true, -- enchancement

        [8] =  true, -- mage
        [62] = true, -- arcane
        [63] = true, -- fire
        [64] = true,  -- frost

        [9] = true, -- warlock
        [265] = true, -- affliction
        [266] = true, -- demonology
        [267] = true,  -- destruction

        [10] = true, -- monk
        [269] = true, -- windwalker

        [12] = true, -- demon hunter
        [577] = true, -- havoc
        [581] = true  -- vengeance
    },
    [8] = { -- 2H swords
        [1] = true, -- warrior
        [71] = true, -- arms
        [72] = true, -- fury

        [2] = true, -- paladin
        [70] = true, -- retribution

        [6] = true, -- death knight
        [250] = true, -- blood
        [251] = true, -- frost
        [252] = true, -- unholy
    },
    [9] = { -- warglaives
        [12] = true, -- demon hunter
        [577] = true, -- havoc
        [581] = true  -- vengeance
    },
    [10] = { -- staves
        [3] = true, -- hunter
        [255] = true, -- survival

        [5] = true, -- priest
        [256] = true, -- discipline
        [257] = true, -- holy
        [258] = true, -- shadow

        [8] =  true, -- mage
        [62] = true, -- arcane
        [63] = true, -- fire
        [64] = true,  -- frost

        [9] = true, -- warlock
        [265] = true, -- affliction
        [266] = true, -- demonology
        [267] = true,  -- destruction

        [10] = true, -- monk
        [268] = true, -- brewmaster
        [269] = true, -- mistweaver
        [270] = true, -- windwalker

        [11] = true, -- druid
        [102] = true, -- balance
        [103] = true, -- feral
        [104] = true, -- guardian
        [105] = true, -- restoration

    },
    --[11] = {}, -- bear claw?
    --[12] = {}, -- catclaw?
    [13] = { -- fist
        [4] = true, -- rogue
        [260] = true, -- outlaw

        [7] = true, -- shaman
        [263] = true, -- enchancement

        [10] = true, -- monk
        [269] = true, -- windwalker

        [12] = true, -- demon hunter
        [577] = true, -- havoc
        [581] = true, -- vengance

    },
    --[14] = {}, -- Miscellaneous
    [15] = { -- dagger
        [4] = true, -- rogue
        [259] = true, -- assassination
        [261] = true, -- subtlety

        [5] = true, -- priest
        [256] = true, -- discipline
        [257] = true, -- holy
        [258] = true, -- shadow

        [8] =  true, -- mage
        [62] = true, -- arcane
        [63] = true, -- fire
        [64] = true,  -- frost

        [9] = true, -- warlock
        [265] = true, -- affliction
        [266] = true, -- demonology
        [267] = true,  -- destruction

    },
    --[16] = {}, -- thrown Classic
    --[17] = {}, -- spears?
    [18] = { -- crossbows

    },
    [19] = { -- wands
        [5] = true, -- priest
        [256] = true, -- discipline
        [257] = true, -- holy
        [258] = true, -- shadow

        [8] =  true, -- mage
        [62] = true, -- arcane
        [63] = true, -- fire
        [64] = true,  -- frost

        [9] = true, -- warlock
        [265] = true, -- affliction
        [266] = true, -- demonology
        [267] = true,  -- destruction
    },
    --[20] = {}, -- fishing poles
}

function LF:IsNeck(itemType, selectedSlot)
    if itemType == "INVTYPE_NECK" and selectedSlot == 1 then
        return true
    end
    return false
end

function LF:IsRing(itemType, selectedSlot)
    if itemType == "INVTYPE_FINGER" and selectedSlot == 12 then
        return true
    end
    return false
end

function LF:IsTrinket(itemType, selectedSlot)
    if itemType == "INVTYPE_TRINKET" and selectedSlot == 13 then
        return true
    end
    return false
end

function LF:IsShield(itemType, selectedSlot, class, specialization)
    if itemType == "INVTYPE_SHIELD" and selectedSlot == 11 and (shields[specialization] or (specialization == 0 and shields[class])) then
        return true
    end
    return false
end

function LF:IsOffHand(itemType, selectedSlot, class, specialization)
    if itemType == "INVTYPE_HOLDABLE" and selectedSlot == 11 and (offhand[specialization] or (specialization == 0 and offhand[class])) then
        return true
    end
    return false
end

function LF:IsChest(itemType, selectedSlot, class, _, subclass)
    if (itemType == "INVTYPE_CHEST" or itemType == "INVTYPE_ROBE") and selectedSlot == 4 and subclass == gear_type[class] then
        return true
    end
    return false
end

function LF:IsBack(itemType, selectedSlot)
    if itemType == "INVTYPE_CLOAK" and selectedSlot == 3 then
        return true
    end
    return false
end

function LF:IsHead(itemType, selectedSlot, class, _, subclass)
    if (itemType == "INVTYPE_CHEST" or itemType == "INVTYPE_ROBE") and selectedSlot == 4 and subclass == gear_type[class] then
        return true
    end
    return false
end

function LF:IsShoulder(itemType, selectedSlot, class, _, subclass)
    if itemType == "INVTYPE_SHOULDER" and selectedSlot == 2 and subclass == gear_type[class] then
        return true
    end
    return false
end

function LF:IsWrist(itemType, selectedSlot, class, _, subclass)
    if itemType == "INVTYPE_WRIST" and selectedSlot == 4 and subclass == gear_type[class] then
        return true
    end
    return false
end

function LF:IsHands(itemType, selectedSlot, class, _, subclass)
    if itemType == "INVTYPE_HAND" and selectedSlot == 6 and subclass == gear_type[class] then
        return true
    end
    return false
end

function LF:IsWaist(itemType, selectedSlot, class, _, subclass)
    if itemType == "INVTYPE_WAIST" and selectedSlot == 7 and subclass == gear_type[class] then
        return true
    end
    return false
end

function LF:IsLegs(itemType, selectedSlot, class, _, subclass)
    if itemType == "INVTYPE_LEGS" and selectedSlot == 8 and subclass == gear_type[class] then
        return true
    end
    return false
end

function LF:IsBoots(itemType, selectedSlot, class, _, subclass)
    if itemType == "INVTYPE_FEET" and selectedSlot == 9 and subclass == gear_type[class] then
        return true
    end
    return false
end

function LF:IsMainHand(itemType, selectedSlot, class, specialization, subclass)
    if itemType == "INVTYPE_WEAPON" and selectedSlot == 10 and (weapons[subclass][specialization] or (specialization == 0 and weapons[subclass][class]))  then
        return true
    end
    return false
end
