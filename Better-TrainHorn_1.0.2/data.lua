data:extend{
{
  type = "sound",
  name = "train-horn-sound",
  variations = {
    {filename = "__Better-TrainHorn__/sound/horn.ogg"},
    },
  -- filename=
  volume = 1
  },
  
  {
  type = "sound",
  name = "car-horn",
  variations = {
    {filename = "__Better-TrainHorn__/sound/car-horn.ogg"},
    },
  -- filename=
  volume = 0.5
  },
  
  {
  type = "custom-input",
  name = "honk-horn",
  localised_name = "Honk horn",
  key_sequence = "H",
  consuming = "none"
  }
}

