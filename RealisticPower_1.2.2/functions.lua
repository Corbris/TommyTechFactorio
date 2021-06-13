function round_ingredient(num)
   if num < 1 then
      return 1;
   else
      return math.floor(num+0.49);
   end
end

function round_digits(num, digits)
	return (math.floor(num * 10 * digits + 0.5) / (10 * digits))
end

function round_digits_greater_one(num, digits)
	return math.max((math.floor(num * 10 * digits + 0.5) / (10 * digits)),1)
end

function multiply_number(num, mult)
	return num*mult
end

-- multiply a number with a unit (kJ, kW etc) at the end
function multiply_number_unit(property, mult)
	value = {}
	value[1] = string.match(property, "%d+")
	if string.match(property, "%d+%.%d+") then		-- catch floats
		value[1] = string.match(property, "%d+%.%d+")
	end	
	value[2] = string.match(property, "%a+")
	if value[2] == nil then
		return value[1] * mult
	else
		return ((value[1] * mult) .. value[2])
	end
end

-- returns value of a number with a unit, without considering the unit
function value_of_number_unit(property)
	value = string.match(property, "%d+")
	if string.match(property, "%d+%.%d+") then
		value = string.match(property, "%d+%.%d+")
	end
	return value
end

-- returns the unit of a number
function unit_of_number(property)
	return string.match(property, "%a+")
end

-- returns value of the number with a unit in the corresponding SI units (W or J)
function value_number_si(property)
	value = {}
	value[1] = string.match(property, "%d+")
	if string.match(property, "%d+%.%d+") then
		value[1] = string.match(property, "%d+%.%d+")
	end	
	value[2] = string.match(property, "%a+")
	
	if string.match(property, "k%a") or string.match(property, "K%a") then
		value[1] = value[1] * 1000
	elseif string.match(property, "m%a") or string.match(property, "M%a") then
		value[1] = value[1] * 1000000
	elseif string.match(property, "g%a") or string.match(property, "G%a") then
		value[1] = value[1] * 1000000000
	elseif string.match(property, "t%a") or string.match(property, "T%a") then
		value[1] = value[1] * 1000000000000
	elseif string.match(property, "p%a") or string.match(property, "P%a") then
		value[1] = value[1] * 1000000000000000
	end
	return value[1]
end

	
function multiply_ingredient (ingredient, mult)
	if ingredient[2] ~= nil then
		ingredient[2] = round_ingredient(ingredient[2] * mult)
	elseif ingredient.amount ~= nil then
		ingredient.amount = round_ingredient(ingredient.amount * mult)
	end
end

function tech_multiply_cost(tech, factor)
	if data.raw.technology[tech] and factor > 0 then
		data.raw.technology[tech].unit.count = multiply_number(data.raw.technology[tech].unit.count, factor)
	end
end

function tech_add_science_pack(tech, pack, amount)
	if data.raw.technology[tech] and data.raw.tool[pack] and amount > 0 then
		table.insert(data.raw.technology[tech].unit.ingredients, {pack, amount})
	end
end

function tech_add_prerequisite(tech, req)
	if data.raw.technology[tech] and data.raw.technology[req] then
		table.insert(data.raw.technology[tech].prerequisites, req)
	end
end

function blacklisted(name)
	blisted = false
	for _, item in pairs(blacklist) do
		if name == item then
			blisted = true
		end
	end
	for _, item_from_blacklist in pairs(blacklist_extra) do
		if blisted == false and string.match(name, item_from_blacklist) then
			blisted = true
		end
	end
	return blisted
end