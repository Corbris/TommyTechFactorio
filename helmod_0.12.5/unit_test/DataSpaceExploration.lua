local data = {mod="Space Exploration"}
data.energy = {}
data.energy["offshore-pump"] = {
    energy_type_input="none",
    energy_usage_min=0,
    energy_usage_max=0,
    energy_usage_priority="none",
    energy_consumption=0,
    energy_type_output="none",
    energy_production=0,
    effectivity=1,
    target_temperature=0,
    maximum_temperature=0,
    fluid_usage=0,
    fluid_burns="none",
    fluid_fuel = {name="none", capacity=0},
    fluid_consumption=0,
    fluid_production={name="water", amount=1200},
    pollution=0,
    speed=1200,
    recipe={type="fluid"}
}
data.energy["assembling-machine-1"] = {
    energy_type_input="electric",
    energy_usage_min=2500,
    energy_usage_max=75000,
    energy_usage_priority="secondary-input",
    energy_consumption=77500,
    energy_type_output="none",
    energy_production=0,
    effectivity=1,
    target_temperature=0,
    maximum_temperature=0,
    fluid_usage=0,
    fluid_burns="none",
    fluid_fuel = {name="none", capacity=0},
    fluid_consumption=0,
    fluid_production={name="none", amount=0},
    pollution=4,
    speed=0.5,
    recipe={type="recipe"}
}
data.energy["assembling-machine-2"] = {
    energy_type_input="electric",
    energy_usage_min=5000,
    energy_usage_max=150000,
    energy_usage_priority="secondary-input",
    energy_consumption=155000,
    energy_type_output="none",
    energy_production=0,
    effectivity=1,
    target_temperature=0,
    maximum_temperature=0,
    fluid_usage=0,
    fluid_burns="none",
    fluid_fuel = {name="none", capacity=0},
    fluid_consumption=0,
    fluid_production={name="none", amount=0},
    pollution=3,
    speed=0.75,
    recipe={type="recipe"}
}
data.energy["assembling-machine-3"] = {
    energy_type_input="electric",
    energy_usage_min=12500,
    energy_usage_max=375000,
    energy_usage_priority="secondary-input",
    energy_consumption=387500,
    energy_type_output="none",
    energy_production=0,
    effectivity=1,
    target_temperature=0,
    maximum_temperature=0,
    fluid_usage=0,
    fluid_burns="none",
    fluid_fuel = {name="none", capacity=0},
    fluid_consumption=0,
    fluid_production={name="none", amount=0},
    pollution=2,
    speed=1.25,
    recipe={type="recipe"}
}
data.energy["boiler"] = {
    energy_type_input="burner",
    energy_usage_min=0,
    energy_usage_max=1800000,
    energy_usage_priority="none",
    energy_type_output="none",
    energy_consumption=1800000,
    energy_production=0,
    effectivity=1,
    target_temperature=165,
    maximum_temperature=0,
    fluid_usage=0,
    fluid_burns="none",
    fluid_fuel = {name="none", capacity=0},
    fluid_consumption=0,
    fluid_production={name="steam", amount=60},
    pollution=30,
    speed=60,
    recipe={name="steam"}
}
data.energy["steam-engine"] = {
    energy_type_input="fluid",
    energy_usage_min=0,
    energy_usage_max=0,
    energy_usage_priority="secondary-output",
    energy_consumption=900000,
    energy_type_output="electric",
    energy_production=900000,
    effectivity=1,
    target_temperature=0,
    maximum_temperature=165,
    fluid_usage=30,
    fluid_burns="none",
    fluid_fuel = {name="steam", capacity=200},
    fluid_consumption=30,
    fluid_production={name="none", amount=0},
    pollution=0,
    speed=0,
    recipe={type="recipe"}
}
data.energy["heat-exchanger"] = {
    energy_type_input="heat",
    energy_usage_min=0,
    energy_usage_max=10000000,
    energy_usage_priority="none",
    energy_consumption=10000000,
    energy_type_output="none",
    energy_production=0,
    effectivity=1,
    target_temperature=500,
    maximum_temperature=0,
    fluid_usage=0,
    fluid_burns="none",
    fluid_fuel = {name="none", capacity=0},
    fluid_consumption=0,
    fluid_production={name="steam", amount=103},
    pollution=0,
    speed=0,
    recipe={type="resource"}
}
data.energy["steam-turbine"] = {
    energy_type_input="fluid",
    energy_usage_min=0,
    energy_usage_max=0,
    energy_usage_priority="secondary-output",
    energy_consumption=5820000,
    energy_type_output="electric",
    energy_production=5820000,
    effectivity=1,
    target_temperature=0,
    maximum_temperature=500,
    fluid_usage=60,
    fluid_burns="none",
    fluid_fuel = {name="steam", capacity=200},
    fluid_consumption=60,
    fluid_production={name="none", amount=0},
    pollution=0,
    speed=0,
    recipe={type="recipe"}
}
data.energy["se-fluid-burner-generator"] = {
    energy_type_input="fluid",
    energy_usage_min=0,
    energy_usage_max=0,
    energy_usage_priority="secondary-output",
    energy_consumption=200000,
    energy_type_output="electric",
    energy_production=200000,
    effectivity=0.75,
    target_temperature=0,
    maximum_temperature=1000,
    fluid_usage=60,
    fluid_burns="none",
    fluid_fuel = {name="se-liquid-rocket-fuel", capacity=100},
    fluid_consumption=60,
    fluid_production={name="none", amount=0},
    pollution=0,
    speed=0,
    recipe={type="recipe"}
}
data.energy["nuclear-reactor"] = {
    energy_type_input="burner",
    energy_usage_min=0,
    energy_usage_max=40000000,
    energy_usage_priority="none",
    energy_consumption=40000000,
    energy_type_output="heat",
    energy_production=0,
    effectivity=1,
    target_temperature=0,
    maximum_temperature=0,
    fluid_usage=0,
    fluid_burns="none",
    fluid_fuel = {name="none", capacity=0},
    fluid_consumption=0,
    fluid_production={name="none", amount=0},
    pollution=0,
    speed=0,
    recipe={type="recipe"}
}

data.energy["solar-panel"] = {
    energy_type_input="none",
    energy_usage_min=0,
    energy_usage_max=0,
    energy_usage_priority="solar",
    energy_consumption=0,
    energy_type_output="electric",
    energy_production=60000,
    effectivity=1,
    target_temperature=0,
    maximum_temperature=0,
    fluid_usage=0,
    fluid_burns="none",
    fluid_fuel = {name="none", capacity=0},
    fluid_consumption=0,
    fluid_production={name="none", amount=0},
    pollution=0,
    speed=0,
    recipe={type="recipe"}
}

data.energy["accumulator"] = {
    energy_type_input="electric",
    energy_usage_min=0,
    energy_usage_max=300000,
    energy_usage_priority="managed-accumulator",
    energy_consumption=300000,
    energy_type_output="electric",
    energy_production=300000,
    effectivity=1,
    target_temperature=0,
    maximum_temperature=0,
    fluid_usage=0,
    fluid_burns="none",
    fluid_fuel = {name="none", capacity=0},
    fluid_consumption=0,
    fluid_production={name="none", amount=0},
    pollution=0,
    speed=0,
    recipe={type="recipe"}
}
return data