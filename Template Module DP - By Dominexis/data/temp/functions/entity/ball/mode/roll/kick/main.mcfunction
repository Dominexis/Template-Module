# Extract data

execute if entity @s[tag=!nexus.entity] run function nexus:entity/generic/data/extract/fakeplayer/pos







# Manage delay since last kick

scoreboard players operation #delay temp.value = #global nexus.ticks
scoreboard players operation #delay temp.value -= @s temp.kick_ticks







# Compute current and previous positions

scoreboard players operation #kicker_x temp.value = @s nexus.x
scoreboard players operation #kicker_y temp.value = @s nexus.y
scoreboard players operation #kicker_z temp.value = @s nexus.z
scoreboard players operation #kicker_prev_x temp.value = @s nexus.prev_x
scoreboard players operation #kicker_prev_y temp.value = @s nexus.prev_y
scoreboard players operation #kicker_prev_z temp.value = @s nexus.prev_z
scoreboard players operation #kicker_prev_x temp.value -= @s nexus.x
scoreboard players operation #kicker_prev_y temp.value -= @s nexus.y
scoreboard players operation #kicker_prev_z temp.value -= @s nexus.z
scoreboard players operation #kicker_prev_x temp.value /= @s nexus.nbt_delay
scoreboard players operation #kicker_prev_y temp.value /= @s nexus.nbt_delay
scoreboard players operation #kicker_prev_z temp.value /= @s nexus.nbt_delay
scoreboard players operation #kicker_prev_x temp.value += @s nexus.x
scoreboard players operation #kicker_prev_y temp.value += @s nexus.y
scoreboard players operation #kicker_prev_z temp.value += @s nexus.z

scoreboard players operation #kicker_size temp.value = @s nexus.size







# Manipulate data if a player

execute if entity @s[type=player] run function temp:entity/ball/mode/roll/kick/player/main







# Push ticks value

scoreboard players operation @s temp.kick_ticks = #global nexus.ticks







# Test forces

scoreboard players set #kick_bool temp.value 0

scoreboard players set #offset temp.value 100
execute if entity @s[tag=temp.entity.type.ball] run scoreboard players set #offset temp.value 0
function temp:entity/ball/mode/roll/kick/test
scoreboard players set #offset temp.value 1600
execute if score #kick_bool temp.value matches 0 if entity @s[type=player] run function temp:entity/ball/mode/roll/kick/test