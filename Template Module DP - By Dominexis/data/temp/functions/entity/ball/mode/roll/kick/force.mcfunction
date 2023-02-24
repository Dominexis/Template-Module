# Compute force multiplier with masses

scoreboard players operation #force_cap temp.value = #ball_mass temp.value
execute unless entity @s[tag=temp.entity.type.ball] run scoreboard players operation #force_cap temp.value *= #4 nexus.value
scoreboard players operation #force_multiplier temp.value = @s nexus.mass
scoreboard players operation #force_multiplier temp.value < #force_cap temp.value







# Compute location of points

scoreboard players operation #kicker_point_x temp.value = #kicker_x temp.value
scoreboard players operation #kicker_point_y temp.value = #kicker_y temp.value
scoreboard players operation #kicker_point_z temp.value = #kicker_z temp.value
scoreboard players operation #kicker_point_x temp.value -= #kicker_prev_x temp.value
scoreboard players operation #kicker_point_y temp.value -= #kicker_prev_y temp.value
scoreboard players operation #kicker_point_z temp.value -= #kicker_prev_z temp.value

scoreboard players operation #relative_mot_x temp.value = #kicker_point_x temp.value
scoreboard players operation #relative_mot_y temp.value = #kicker_point_y temp.value
scoreboard players operation #relative_mot_z temp.value = #kicker_point_z temp.value

scoreboard players operation #kicker_point_x temp.value *= #time temp.value
scoreboard players operation #kicker_point_y temp.value *= #time temp.value
scoreboard players operation #kicker_point_z temp.value *= #time temp.value
scoreboard players operation #kicker_point_x temp.value /= #1000 nexus.value
scoreboard players operation #kicker_point_y temp.value /= #1000 nexus.value
scoreboard players operation #kicker_point_z temp.value /= #1000 nexus.value
scoreboard players operation #kicker_point_x temp.value += #kicker_prev_x temp.value
scoreboard players operation #kicker_point_y temp.value += #kicker_prev_y temp.value
scoreboard players operation #kicker_point_z temp.value += #kicker_prev_z temp.value



scoreboard players operation #relative_mot_x temp.value *= #force_multiplier temp.value
scoreboard players operation #relative_mot_y temp.value *= #force_multiplier temp.value
scoreboard players operation #relative_mot_z temp.value *= #force_multiplier temp.value
execute unless entity @s[tag=temp.entity.type.ball] run scoreboard players operation #relative_mot_x temp.value *= #7 nexus.value
execute unless entity @s[tag=temp.entity.type.ball] run scoreboard players operation #relative_mot_y temp.value *= #7 nexus.value
execute unless entity @s[tag=temp.entity.type.ball] run scoreboard players operation #relative_mot_z temp.value *= #7 nexus.value
execute unless entity @s[tag=temp.entity.type.ball] run scoreboard players operation #relative_mot_x temp.value /= #3 nexus.value
execute unless entity @s[tag=temp.entity.type.ball] run scoreboard players operation #relative_mot_y temp.value /= #3 nexus.value
execute unless entity @s[tag=temp.entity.type.ball] run scoreboard players operation #relative_mot_z temp.value /= #3 nexus.value
scoreboard players operation #relative_mot_x temp.value /= #ball_mass temp.value
scoreboard players operation #relative_mot_y temp.value /= #ball_mass temp.value
scoreboard players operation #relative_mot_z temp.value /= #ball_mass temp.value
scoreboard players operation #relative_mot_x temp.value -= #ball_mot_x temp.value
scoreboard players operation #relative_mot_y temp.value -= #ball_mot_y temp.value
scoreboard players operation #relative_mot_z temp.value -= #ball_mot_z temp.value



scoreboard players operation #ball_point_x temp.value = #ball_x temp.value
scoreboard players operation #ball_point_y temp.value = #ball_y temp.value
scoreboard players operation #ball_point_z temp.value = #ball_z temp.value
scoreboard players operation #ball_point_x temp.value -= #ball_prev_x temp.value
scoreboard players operation #ball_point_y temp.value -= #ball_prev_y temp.value
scoreboard players operation #ball_point_z temp.value -= #ball_prev_z temp.value
scoreboard players operation #ball_point_x temp.value *= #time temp.value
scoreboard players operation #ball_point_y temp.value *= #time temp.value
scoreboard players operation #ball_point_z temp.value *= #time temp.value
scoreboard players operation #ball_point_x temp.value /= #1000 nexus.value
scoreboard players operation #ball_point_y temp.value /= #1000 nexus.value
scoreboard players operation #ball_point_z temp.value /= #1000 nexus.value
scoreboard players operation #ball_point_x temp.value += #ball_prev_x temp.value
scoreboard players operation #ball_point_y temp.value += #ball_prev_y temp.value
scoreboard players operation #ball_point_z temp.value += #ball_prev_z temp.value







# Reflect motion around interaction axis, then apply relative motion

scoreboard players operation #input_vector_x nexus.value = #ball_point_x temp.value
scoreboard players operation #input_vector_y nexus.value = #ball_point_y temp.value
scoreboard players operation #input_vector_z nexus.value = #ball_point_z temp.value
scoreboard players operation #input_vector_x nexus.value -= #kicker_point_x temp.value
scoreboard players operation #input_vector_y nexus.value -= #kicker_point_y temp.value
scoreboard players operation #input_vector_z nexus.value -= #kicker_point_z temp.value

scoreboard players set #scale_factor nexus.value 1
function nexus:generic/vector/normalize/3d

scoreboard players operation #direction_x temp.value = #output_vector_x nexus.value
scoreboard players operation #direction_y temp.value = #output_vector_y nexus.value
scoreboard players operation #direction_z temp.value = #output_vector_z nexus.value

scoreboard players operation #input_vector_1_x nexus.value = #ball_mot_x temp.value
scoreboard players operation #input_vector_1_y nexus.value = #ball_mot_y temp.value
scoreboard players operation #input_vector_1_z nexus.value = #ball_mot_z temp.value
scoreboard players operation #input_vector_1_x nexus.value *= #-1 nexus.value
scoreboard players operation #input_vector_1_y nexus.value *= #-1 nexus.value
scoreboard players operation #input_vector_1_z nexus.value *= #-1 nexus.value
scoreboard players operation #input_vector_2_x nexus.value = #direction_x temp.value
scoreboard players operation #input_vector_2_y nexus.value = #direction_y temp.value
scoreboard players operation #input_vector_2_z nexus.value = #direction_z temp.value

function nexus:generic/vector/reflect/3d

execute unless entity @s[tag=temp.entity.type.ball] run scoreboard players operation #ball_mot_x temp.value = #output_vector_x nexus.value
execute unless entity @s[tag=temp.entity.type.ball] run scoreboard players operation #ball_mot_y temp.value = #output_vector_y nexus.value
execute unless entity @s[tag=temp.entity.type.ball] run scoreboard players operation #ball_mot_z temp.value = #output_vector_z nexus.value







# Apply translational force

scoreboard players operation #input_vector_1_x nexus.value = #direction_x temp.value
scoreboard players operation #input_vector_1_y nexus.value = #direction_y temp.value
scoreboard players operation #input_vector_1_z nexus.value = #direction_z temp.value
scoreboard players operation #input_vector_2_x nexus.value = #relative_mot_x temp.value
scoreboard players operation #input_vector_2_y nexus.value = #relative_mot_y temp.value
scoreboard players operation #input_vector_2_z nexus.value = #relative_mot_z temp.value

function nexus:generic/vector/dot_product/3d

scoreboard players operation #force_x temp.value = #direction_x temp.value
scoreboard players operation #force_y temp.value = #direction_y temp.value
scoreboard players operation #force_z temp.value = #direction_z temp.value
scoreboard players operation #force_x temp.value *= #output nexus.value
scoreboard players operation #force_y temp.value *= #output nexus.value
scoreboard players operation #force_z temp.value *= #output nexus.value
scoreboard players operation #force_x temp.value /= #1000 nexus.value
scoreboard players operation #force_y temp.value /= #1000 nexus.value
scoreboard players operation #force_z temp.value /= #1000 nexus.value

scoreboard players operation #ball_mot_x temp.value += #force_x temp.value
scoreboard players operation #ball_mot_y temp.value += #force_y temp.value
scoreboard players operation #ball_mot_z temp.value += #force_z temp.value







# Apply angular force

scoreboard players operation #input_vector_1_x nexus.value = #direction_x temp.value
scoreboard players operation #input_vector_1_y nexus.value = #direction_y temp.value
scoreboard players operation #input_vector_1_z nexus.value = #direction_z temp.value
scoreboard players operation #input_vector_1_x nexus.value *= #-1 nexus.value
scoreboard players operation #input_vector_1_y nexus.value *= #-1 nexus.value
scoreboard players operation #input_vector_1_z nexus.value *= #-1 nexus.value
scoreboard players operation #input_vector_1_x nexus.value *= #ball_size temp.value
scoreboard players operation #input_vector_1_y nexus.value *= #ball_size temp.value
scoreboard players operation #input_vector_1_z nexus.value *= #ball_size temp.value
scoreboard players operation #input_vector_1_x nexus.value /= #1000 nexus.value
scoreboard players operation #input_vector_1_y nexus.value /= #1000 nexus.value
scoreboard players operation #input_vector_1_z nexus.value /= #1000 nexus.value
scoreboard players operation #input_vector_2_x nexus.value = #relative_mot_x temp.value
scoreboard players operation #input_vector_2_y nexus.value = #relative_mot_y temp.value
scoreboard players operation #input_vector_2_z nexus.value = #relative_mot_z temp.value

function nexus:generic/vector/cross_product

scoreboard players operation #output_vector_x nexus.value *= #3 nexus.value
scoreboard players operation #output_vector_y nexus.value *= #3 nexus.value
scoreboard players operation #output_vector_z nexus.value *= #3 nexus.value
scoreboard players operation #output_vector_x nexus.value /= #2 nexus.value
scoreboard players operation #output_vector_y nexus.value /= #2 nexus.value
scoreboard players operation #output_vector_z nexus.value /= #2 nexus.value
scoreboard players operation #ball_ang_vel_x temp.value += #output_vector_x nexus.value
scoreboard players operation #ball_ang_vel_y temp.value += #output_vector_y nexus.value
scoreboard players operation #ball_ang_vel_z temp.value += #output_vector_z nexus.value







# Play sound

playsound minecraft:block.note_block.basedrum neutral @a ~ ~ ~







# Set force application boolean

scoreboard players set #apply_force temp.value 1