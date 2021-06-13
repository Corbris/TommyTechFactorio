for i, force in pairs(game.forces) do 
	force.reset_recipes()
	force.reset_technologies()
	for _,technology in pairs({"electric-energy-accumulators"}) do
		if force.technologies[technology] and force.technologies[technology].researched then
			for _,effect in pairs(force.technologies[technology].effects) do
				if effect.type == "unlock-recipe" then
					force.recipes[effect.recipe].enabled = true
				end
			end
		end
	end
end