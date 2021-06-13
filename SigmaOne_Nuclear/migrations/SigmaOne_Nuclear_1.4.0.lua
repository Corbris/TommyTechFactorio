-- Migrations and stuff

for _, f in pairs(game.forces) do
  if f.technologies["uranium-processing"] then
    if f.technologies["uranium-processing"].researched then
      f.recipes["fill-uranium-hexafluoride-barrel"].enabled=true
      f.recipes["empty-uranium-hexafluoride-barrel"].enabled=true
      f.recipes["uranium-hexafluoride"].enabled=true
    end
  end
  if f.technologies["kovarex-enrichment-process"] then
    if f.technologies["kovarex-enrichment-process"].researched then
      f.recipes["mox-fuel-cell"].enabled=true
    end
  end
  if f.technologies["nuclear-fuel-reprocessing"] then
    if f.technologies["nuclear-fuel-reprocessing"].researched then
      f.recipes["mox-fuel-reprocessing"].enabled = true
    end
  end
end
