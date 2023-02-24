# Initialize data

execute unless score #delay temp.value matches 0..5 run function temp:entity/ball/mode/roll/kick/player/initialize







# Manage Y motion

execute unless score @s temp.kick_ticks = #global nexus.ticks run scoreboard players operation @s temp.mot_y_5 = @s temp.mot_y_4
execute unless score @s temp.kick_ticks = #global nexus.ticks run scoreboard players operation @s temp.mot_y_4 = @s temp.mot_y_3
execute unless score @s temp.kick_ticks = #global nexus.ticks run scoreboard players operation @s temp.mot_y_3 = @s temp.mot_y_2
execute unless score @s temp.kick_ticks = #global nexus.ticks run scoreboard players operation @s temp.mot_y_2 = @s temp.mot_y_1
scoreboard players operation @s temp.mot_y_1 = #kicker_y temp.value
scoreboard players operation @s temp.mot_y_1 -= #kicker_prev_y temp.value







# Manage Y value

execute unless score @s temp.kick_ticks = #global nexus.ticks run scoreboard players operation @s temp.y_5 = @s temp.y_4
execute unless score @s temp.kick_ticks = #global nexus.ticks run scoreboard players operation @s temp.y_4 = @s temp.y_3
execute unless score @s temp.kick_ticks = #global nexus.ticks run scoreboard players operation @s temp.y_3 = @s temp.y_2
execute unless score @s temp.kick_ticks = #global nexus.ticks run scoreboard players operation @s temp.y_2 = @s temp.y_1
scoreboard players operation @s temp.y_1 = #kicker_y temp.value







# Determine sign of Y motion value

scoreboard players operation #sign temp.value = @s temp.mot_y_1
scoreboard players operation #sign temp.value += @s temp.mot_y_2
scoreboard players operation #sign temp.value += @s temp.mot_y_3
scoreboard players operation #sign temp.value += @s temp.mot_y_4
scoreboard players operation #sign temp.value += @s temp.mot_y_5







# Compute proper extreme of the Y and Y motion values

scoreboard players operation #mot_y temp.value = @s temp.mot_y_1
execute if score #sign temp.value matches ..-1 run scoreboard players operation #mot_y temp.value < @s temp.mot_y_2
execute if score #sign temp.value matches ..-1 run scoreboard players operation #mot_y temp.value < @s temp.mot_y_3
execute if score #sign temp.value matches ..-1 run scoreboard players operation #mot_y temp.value < @s temp.mot_y_4
execute if score #sign temp.value matches ..-1 run scoreboard players operation #mot_y temp.value < @s temp.mot_y_5
execute if score #sign temp.value matches 00.. run scoreboard players operation #mot_y temp.value > @s temp.mot_y_2
execute if score #sign temp.value matches 00.. run scoreboard players operation #mot_y temp.value > @s temp.mot_y_3
execute if score #sign temp.value matches 00.. run scoreboard players operation #mot_y temp.value > @s temp.mot_y_4
execute if score #sign temp.value matches 00.. run scoreboard players operation #mot_y temp.value > @s temp.mot_y_5

scoreboard players operation #y temp.value = @s temp.y_1
execute if score #sign temp.value matches ..-1 run scoreboard players operation #y temp.value > @s temp.y_2
execute if score #sign temp.value matches ..-1 run scoreboard players operation #y temp.value > @s temp.y_3
execute if score #sign temp.value matches ..-1 run scoreboard players operation #y temp.value > @s temp.y_4
execute if score #sign temp.value matches ..-1 run scoreboard players operation #y temp.value > @s temp.y_5
execute if score #sign temp.value matches 00.. run scoreboard players operation #y temp.value < @s temp.y_2
execute if score #sign temp.value matches 00.. run scoreboard players operation #y temp.value < @s temp.y_3
execute if score #sign temp.value matches 00.. run scoreboard players operation #y temp.value < @s temp.y_4
execute if score #sign temp.value matches 00.. run scoreboard players operation #y temp.value < @s temp.y_5







# Compute modified start and stop positions

scoreboard players operation #kicker_prev_y temp.value = #y temp.value
scoreboard players operation #kicker_y temp.value = #y temp.value
scoreboard players operation #kicker_y temp.value += #mot_y temp.value







# Normalize horizontal vector

scoreboard players operation #input_vector_x nexus.value = #kicker_x temp.value
scoreboard players operation #input_vector_y nexus.value = #kicker_z temp.value
scoreboard players operation #input_vector_x nexus.value -= #kicker_prev_x temp.value
scoreboard players operation #input_vector_y nexus.value -= #kicker_prev_z temp.value

scoreboard players set #scale_factor nexus.value 1
function nexus:generic/vector/normalize/2d

scoreboard players operation #horizontal_distance temp.value = #output nexus.value







# Get distance to ball along the kicker's plane of motion

scoreboard players operation #input_vector_1_x nexus.value = #output_vector_x nexus.value
scoreboard players operation #input_vector_1_y nexus.value = #output_vector_y nexus.value
scoreboard players operation #input_vector_2_x nexus.value = #ball_avg_x temp.value
scoreboard players operation #input_vector_2_y nexus.value = #ball_avg_z temp.value
scoreboard players operation #input_vector_2_x nexus.value -= #kicker_prev_x temp.value
scoreboard players operation #input_vector_2_y nexus.value -= #kicker_prev_z temp.value

function nexus:generic/vector/dot_product/2d

scoreboard players operation #horizontal_offset temp.value = #ball_avg_y temp.value
scoreboard players operation #horizontal_offset temp.value -= #kicker_prev_y temp.value
scoreboard players operation #horizontal_offset temp.value *= #horizontal_distance temp.value
scoreboard players operation #math_00 temp.value = #kicker_y temp.value
scoreboard players operation #math_00 temp.value -= #kicker_prev_y temp.value
scoreboard players operation #horizontal_offset temp.value /= #math_00 temp.value
scoreboard players operation #horizontal_offset temp.value *= #-1 nexus.value
scoreboard players operation #horizontal_offset temp.value += #output nexus.value







# Cap the horizontal offset

execute if score #horizontal_offset temp.value matches ..-1 run scoreboard players operation #horizontal_distance temp.value *= #-1 nexus.value
execute if score #horizontal_distance temp.value matches ..-1 run scoreboard players operation #horizontal_offset temp.value > #horizontal_distance temp.value
execute if score #horizontal_distance temp.value matches 00.. run scoreboard players operation #horizontal_offset temp.value < #horizontal_distance temp.value







# Apply horizontal offset to position

scoreboard players operation #output_vector_x nexus.value *= #horizontal_offset temp.value
scoreboard players operation #output_vector_y nexus.value *= #horizontal_offset temp.value
scoreboard players operation #output_vector_x nexus.value /= #1000 nexus.value
scoreboard players operation #output_vector_y nexus.value /= #1000 nexus.value

scoreboard players operation #unmodified_kicker_x temp.value = #kicker_x temp.value
scoreboard players operation #unmodified_kicker_y temp.value = #kicker_y temp.value
scoreboard players operation #unmodified_kicker_z temp.value = #kicker_z temp.value
scoreboard players operation #unmodified_kicker_prev_x temp.value = #kicker_prev_x temp.value
scoreboard players operation #unmodified_kicker_prev_y temp.value = #kicker_prev_y temp.value
scoreboard players operation #unmodified_kicker_prev_z temp.value = #kicker_prev_z temp.value

scoreboard players operation #kicker_x temp.value += #output_vector_x nexus.value
scoreboard players operation #kicker_z temp.value += #output_vector_y nexus.value
scoreboard players operation #kicker_prev_x temp.value += #output_vector_x nexus.value
scoreboard players operation #kicker_prev_z temp.value += #output_vector_y nexus.value