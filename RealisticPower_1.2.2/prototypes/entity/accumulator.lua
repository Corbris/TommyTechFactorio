local acc_cap = util.table.deepcopy(data.raw["accumulator"]["accumulator"])
acc_cap.name = "accumulator-capacitor"
acc_cap.minable.result = "accumulator-capacitor"
acc_cap.energy_source.buffer_capacity = "250kJ"
acc_cap.energy_source.input_flow_limit = "1200kW"
acc_cap.energy_source.output_flow_limit = "1200kW"

data:extend({acc_cap})