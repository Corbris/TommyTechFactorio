require("prototypes.base")
require("prototypes.recipe")
require("prototypes.technology")
local const = require("const")

for tech, recipe in pairs(const.balancerTechs)
do
	if data.raw.technology[tech] ~= nil
	then
    	table.insert(data.raw.technology[tech].effects, { type = "unlock-recipe", recipe = recipe })
  	end
end
