--Change Reprocessing recipe to also output Plutonium
table.insert(
    data.raw["recipe"]["nuclear-fuel-reprocessing"].results,
    {name = "plutonium-239", amount = 1, probability = 0.7}
)

--Change Enrichment recipe to use Uranium Hexafluoride instead of ore
table.insert(
    data.raw["recipe"]["uranium-processing"].ingredients,
    {name = "uranium-hexafluoride-barrel", amount = 4}
)
table.insert(
    data.raw["recipe"]["uranium-processing"].results,
    {name = "empty-barrel", amount = 4}
)
table.remove(data.raw["recipe"]["uranium-processing"].ingredients, 1)

--Change Nuclear Power research to unlock Hexafluoride production
if data.raw["technology"]["uranium-processing"] then
    -- Anti's Science: unlock via uranium-processing instead of nuclear-power (Thanks to leoch!)
    table.insert(
        data.raw["technology"]["uranium-processing"].effects,
        {type = "unlock-recipe", recipe = "uranium-hexafluoride"}
    );
else
    table.insert(
        data.raw["technology"]["nuclear-power"].effects,
        {type = "unlock-recipe", recipe = "uranium-hexafluoride"}
    );
end

--Change Kovarex research to unlock MOX cell production and change it's name
table.insert(
    data.raw["technology"]["kovarex-enrichment-process"].effects,
    {type = "unlock-recipe", recipe = "mox-fuel-cell"}
)
table.remove(data.raw["technology"]["kovarex-enrichment-process"].effects, 1)
data.raw["technology"]["kovarex-enrichment-process"].localised_name = "Advanced nuclear material processing"
data.raw["technology"]["kovarex-enrichment-process"].localised_description = "Advanced methods of handling, manipulating and exploiting radioactive materials."

--Change Nuke recipe to use Plutonium instead of U-235
table.insert(
    data.raw["recipe"]["atomic-bomb"].ingredients,
    {name = "plutonium-239", amount = 40}
)
table.remove(data.raw["recipe"]["atomic-bomb"].ingredients, 3)

-- Add MOX reprocessing to reprocessing research
table.insert(
    data.raw["technology"]["nuclear-fuel-reprocessing"].effects,
    {type = "unlock-recipe", recipe = "mox-fuel-reprocessing"}
)
