print("=======================================================================")
print("Practice loops")

local n = 20
print("N = " .. n .. '\n')

print("Given number N, print all numbers up to N:")
for i = 1, n do
    io.write(i .. ' ')
end
print('\n')

print("Given number N, print every odd number up to N without using an if:")
for i = 1, n, 2 do
    io.write(i .. ' ')
end
print('\n')

print("Given number N, print all numbers up to N in reverse order:")
for i = n, 1, -1 do
    io.write(i .. ' ')
end
print('\n')

print("=======================================================================")
print("Practice arrays")

local function print_arr(arr)
    io.write('[')
    for i, value in ipairs(arr) do
        io.write(value)
        if i ~= #arr then
            io.write(", ")
        end
    end
    print(']')
end

local arr = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
io.write("array = ")
print_arr(arr)
print()

print("Given an array of numbers, print the sum of all of them:")
local sum = 0
for _, value in ipairs(arr) do
    sum = sum + value
end
print(sum .. '\n')

print("Given an array of numbers, print the index of the largest number:")
local max_index = 1
for i, value in ipairs(arr) do
    if value > arr[max_index] then
        max_index = i
    end
end
print(max_index .. '\n')

print("Given number N, make an array containing the squares of every number up to N:")
created_arr = {}
for i = 1, n do
    created_arr[i] = i * i
end
io.write("created_arr = ")
print_arr(created_arr)
print()

print("Given an array of numbers and a number N, print the N-th odd number in the array:")
local n = 3
print("N = " .. n)
local odd_counter = 0
for _, value in ipairs(arr) do
    if value % 2 == 1 then
        odd_counter = odd_counter + 1

        if odd_counter == n then
            print(value)
            break
        end
    end
end

print("=======================================================================")
print("Practice arrays vs. tables\n")

print("Given an array, print every element and its index:")
for i, v in ipairs(arr) do
    io.write(i .. ": " .. v)
    if #arr ~= i then
        io.write(", ")
    end
end
print('\n')

print("Given a table, print every element and its key:")
local function calc_table_size(table)
    local size = 0
    for _ in pairs(table) do
        size = size + 1
    end

    return size
end

table = { cat = "meow", lucky_number = 7, [0] = 8, 37, cow = "moo" }
table_size = calc_table_size(table)
io.write("table = { ")
local counter = 0
for key, value in pairs(table) do
    io.write(key .. " = " .. value)
    counter = counter + 1

    if counter ~= table_size then
        io.write(", ")
    end
end
print(" }\n")

print("Given an array, count the number of its elements:")
print(#arr .. '\n')

print("Given a table, count the number of its elements:")
print(calc_table_size(table) .. '\n')

print("Given an array, determine if it is empty:")
print(#arr == 0 .. '\n')

print("Given a table, determine if it is empty:")
print(calc_table_size(table) == 0 .. '\n')

print("=======================================================================")
print("Practice tables in basic applications\n")

print("Create a function that can print any boolean, number, string, array or table; arrays and. tables may themselves contain arrays and tables:")

local complex_table = { cat = "dog", 22, [7] = 9, horse = "running", arr = {1, 2, 3, 4, 5}, complex = { another_complex = {9, 8, 7, 6, 5}, 5, chicken = "eat" }}

local function get_str(obj)
    if type(obj) == "table" then
        local size = calc_table_size(obj)
        local str = "{ "
        local counter = 0
        for k, v in pairs(obj) do
            str = str .. k .. ": " .. get_str(v)
            counter = counter + 1

            if counter ~= size then
                str = str .. ", "
            end
        end
        str = str .. " }"

        return str
    elseif type(obj) == "string" then
        return '\"' .. obj .. '\"'
    else
        return tostring(obj)
    end
end

local function print_obj(obj)
    print(get_str(obj))
end

io.write("complex_table = ")
print_obj(complex_table)
print()

print("a function that takes an array and a predicate, and returns an array of all elements that pass the predicate:")
print("predicate: function (_, v) return v % 2 == 0 end")

local function filter(table, predicate)
    local result = {}
    for k, v in pairs(table) do
        if predicate(k, v) then
            result[#result + 1] = v
        end
    end

    return result
end

print_arr(filter(arr, function (_, v) return v % 2 == 0 end))

print("=======================================================================")
print("=======================================================================")
print("Advanced tasks\n")

print("Use Inputs to Initalize table")
print("- by reading elements")
dofile("inputs.lua")

print("- Insert all new elements contained in inserts")
for k, v in pairs(inserts) do
    elements[k] = v
end
io.write("elements = ")
print_obj(elements)
print()

print("- Delete all elements by ID contained in deletionsByID")
for _, v in pairs(deletionsByID) do
    elements[v] = nil
end
io.write("elements = ")
print_obj(elements)
print()

print("Query all \"air\" units")
local air_units = filter(elements, function (_, unit) return unit.air end)
print_obj(air_units)
print()

print("Query all \"tank\" units")
local tank_units = filter(elements, function (_, unit) return unit.defName == "tank" end)
print_obj(tank_units)
print()

print("Query ammunition of \"tank\" units of team 1")
local team1_tank_units = filter(tank_units, function (_, unit) return unit.teamID == 1 end)
local total_ammo = {}
for _, unit in pairs(team1_tank_units) do
    print_obj(unit.ammo)
    for _, ammo in pairs(unit.ammo) do
        total_ammo[ammo.defName] = (total_ammo[ammo.defName] or 0) + ammo.count
    end
end
io.write("total_ammo = ")
print_obj(total_ammo)
print()

print("Query all units in team 4 which has some weapon (no ammo means unit has not weapon)")
local units_team4_with_weapon = filter(elements, function (_, unit) return calc_table_size(unit.ammo) > 0 and unit.teamID == 4 end)
print_obj(units_team4_with_weapon)
print()

print("Query all enemy units in 1500 radius considering")
print("- You are team 1")
print("- All other teams are enemies")
local enemy_query = filter(elements, function (_, unit) return unit.teamID ~= 1 and unit.distance <= 1500 end)
print_obj(enemy_query)
print()

print("Measure for each one of 4 teams:")
print("- How many grenades they have available per unit")
local function get_first(table)
    for _, v in pairs(table) do
        return v
    end
end

for team = 1, 4 do
    print("team " .. team .. ':')
    local team_units = filter(elements, function (_, unit) return unit.teamID == team end)
    local grenade_mapping = {}

    for _, unit in pairs(team_units) do
        local grenade = get_first(filter(unit.ammo, function(_, ammo) return ammo.defName == "grenade" end))

        grenade_mapping[unit.defName] = (grenade_mapping[unit.defName] or 0) + ((grenade and grenade.count) or 0)
    end

    for unit_name, count in pairs(grenade_mapping) do
        print("- \"" .. unit_name .. "\": " .. count)
    end
end
print()

print("- How many grenades they have available per \"soldier\" unit")
local function filter_table(table, predicate)
    local result = {}
    for k, v in pairs(table) do
        if predicate(k, v) then
            result[k] = v
        end
    end

    return result
end

for team = 1, 4 do
    print("team " .. team .. ':')
    local team_units = filter_table(elements, function (_, unit) return unit.teamID == team and unit.defName == "soldier" end)

    if calc_table_size(team_units) ~= 0 then
        for id, unit in pairs(team_units) do
            local grenade = get_first(filter(unit.ammo, function(_, ammo) return ammo.defName == "grenade" end))
    
            print("soldier_id: " .. id .. ", grenades: " .. ((grenade and grenade.count) or 0))
        end
    end
end
print()

print("Considering \"rifle\", \"machinegun\", \"acid\" is ammunition which can kill 1 \"soldier\" and \"HE\" is ammunition which can kill 10 \"soldiers\", for each one of 4 teams make decision: With all units our team have available can we kill 100 soldiers? YES/NO")
local gun_kill_map = { rifle = 1, machinegun = 1, acid = 1, HE = 10}
for team = 1, 4 do
    local kill_potencial = 0
    local team_units = filter(elements, function (_, unit) return unit.teamID == team end)

    for _, unit in pairs(team_units) do
        for _, ammo in pairs(unit.ammo) do
            kill_potencial = kill_potencial + (gun_kill_map[ammo.defName] or 0) * ammo.count
        end
    end

    print("team " .. team .. ": " .. (kill_potencial > 100 and "YES" or "NO"))
end