# Get vector between mob and player

scoreboard players operation #input_vector_x nexus.value = @s nexus.x
scoreboard players operation #input_vector_y nexus.value = @s nexus.z
scoreboard players operation #input_vector_x nexus.value -= @p[gamemode=!spectator] nexus.x
scoreboard players operation #input_vector_y nexus.value -= @p[gamemode=!spectator] nexus.z

scoreboard players set #scale_factor nexus.value 1
function nexus:generic/vector/normalize/2d

scoreboard players operation #output_vector_x nexus.value /= #2 nexus.value
scoreboard players operation #output_vector_y nexus.value /= #2 nexus.value

scoreboard players operation @s nexus.mot_x += #output_vector_x nexus.value
scoreboard players operation @s nexus.mot_z += #output_vector_y nexus.value
scoreboard players add @s nexus.mot_y 300