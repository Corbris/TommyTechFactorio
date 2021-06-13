Add more realistic nuclear reactors with a breeder reactor and a cooling tower. The reactors have to be controlled via integrated circuit interface signals. The reactors have a dynamic heat output depending on their temperature. They need proper cooling, otherwise a nuclear meltdown will occur.

#Overview
---------------------------------------------------------------------------------------------------------------------------------------------
We introduce a nuclear reactor, a breeder reactor and a cooling tower. The nuclear reactor has a high power output. The breeder reactor has a medium power output and produces bonus materials (or extra empty fuel cells). Both reactors power output and fuel efficiency is dynamic, depending on the temperature they are operating on and also depending on your setup of the plant. The reactors need to be controlled with signals through the integrated circuit interface and they need to be cooled over their Emergency Core Cooling System (ECCS). Otherwise they might get too hot causing a reactor core meltdown. The cooling tower is used to cool down hot water or steam coming from the ECCS or other parts of the plant.

#How to operate a reactor
---------------------------------------------------------------------------------------------------------------------------------------------
## Starting and stopping
To start a nuclear reactor, you need to insert fuel cells and send the ``Start Control Signal`` to the circuit interface of the reactor. The reactor will start up and produce heat at a certain efficiency (see the two corresponding signals on the circuit interface).
To shut down the reactor either let it run out of fuel cells or send the ``SCRAM Control Signal`` to the reactor circuit interface.
Be aware that the SCRAM process takes some time and the reactor will still produce heat until it is fully stopped.

##The point of maximum output and efficiency
Power output and fuel efficiency change dynamically depending on the reactor core temperature, and the number of connected neighbour reactors. Also, the output of extra empty fuel cells by the breeder changes with the temperature accordingly. To connect a reactor neighbour simply connect them with heat-pipes into one heat network. The reactors don't need to touch each other.

There are two possible options how output and efficiency are calculated, which can be changed in the settings.
By default **Ownly's formulas** will be used. In short this means: "the hotter, the better". The higher the reactor core temperature is, the higher power output and fuel efficiency will be. 
The alternative **Ingo's formulas** work a little different. Power output will also increase with higher core temperature, but efficiency will have a certain maximum, after which it will start to drop quickly again.

You can find [more details on this in the forum post](https://forums.factorio.com/viewtopic.php?f=93&t=56621) or in the included ODT chart, which comes with the mod download archive.

##Meltdown
When the reactor core reaches 1000°C a nuclear core meltdown will be caused. The reactor will explode and leave a ruin behind. That ruin will produce radiation and radioactive clouds. Large area around the reactor ruin will be polluted and damage the player-in proximity. To stop the radiation spreading, a concrete sarcophagus must be built over the reactor ruin. Then the radiation will slowly decay.


# Compatibility
---------------------------------------------------------------------------------------------------------------------------------------------
We haven't discovered any incompatibilities with other mods to date. Please report on the mod page discussion if any incompatibilities are discovered.

# Supported mods
---------------------------------------------------------------------------------------------------------------------------------------------
* [GotLag's Nuclear Fuel](https://mods.factorio.com/mod/Nuclear%20Fuel)
* [JohnTheCoolingFan's Plutonium Energy](https://mods.factorio.com/mod/PlutoniumEnergy)
* [MadClown01's Nuclear Extension](https://mods.factorio.com/mod/Clowns-Nuclear)
* [Nuclear Operators Utilities](https://mods.factorio.com/mod/Nuclear_Operators_Utilities)
* [Realistic Heat Glow](https://mods.factorio.com/mod/Realistic_Heat_Glow)

#Credits
---------------------------------------------------------------------------------------------------------------------------------------------
Original idea and implementation [IngoKnieto](https://mods.factorio.com/user/ingo), [OwnlyMe](https://mods.factorio.com/user/OwnlyMe) 
Thanks to GotLag for the [original reactors mod](https://mods.factorio.com/mods/GotLag/Reactors), which this mod is based on
Also thanks to [Sigma1](https://mods.factorio.com/user/Sigma1) for making the awesome cooling tower picture
The refactored version 3 was made by [dodo.the.last](https://mods.factorio.com/user/dodo.the.last) and [max2344](https://mods.factorio.com/user/max2344) who are currently maintaining the mod

#License
---------------------------------------------------------------------------------------------------------------------------------------------
This mod was made by [dodo.the.last](https://mods.factorio.com/user/dodo.the.last), [max2344](https://mods.factorio.com/user/max2344),  [IngoKnieto](https://mods.factorio.com/user/ingo), [OwnlyMe](https://mods.factorio.com/user/OwnlyMe) and published under the MIT license

#Includes following materials
---------------------------------------------------------------------------------------------------------------------------------------------
* Geiger counter sounds based on http://soundbible.com/1113-Radio-Active.html by Mike Koenig under [CC BY 3.0](https://creativecommons.org/licenses/by/3.0/)
* Explosions sounds based on https://freesound.org/people/Robinhood76/sounds/270882/ by Robinhood76 under [CC BY-NC 3.0](https://creativecommons.org/licenses/by-nc/3.0/)
* An atomic explosion based on https://mods.factorio.com/mods/Fatmice/UraniumPower by Fatmice under [MIT](https://opensource.org/licenses/MIT)
* Reactor sarcophagus graphic based on https://www.artstation.com/artwork/nbPvO by Anthony Garcellano
Also see the included license.txt file
