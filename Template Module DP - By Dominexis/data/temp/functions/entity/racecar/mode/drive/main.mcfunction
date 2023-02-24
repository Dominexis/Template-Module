# Manage seat

execute if entity @a[distance=..16] run function temp:entity/racecar/mode/generic/seat/main







# Move entity along current trajectory

scoreboard players set #hitbox_offset nexus.value 600
scoreboard players set #hitbox_width nexus.value 600
scoreboard players set #hitbox_height nexus.value 600

scoreboard players set #collision_friction_numerator nexus.value 96
scoreboard players set #fluid_friction_numerator nexus.value 90
scoreboard players set #climb_friction_numerator nexus.value 99
scoreboard players set #friction_numerator nexus.value 98
scoreboard players set #friction_denominator nexus.value 100

scoreboard players set #motion_climb_boolean nexus.value 2
scoreboard players set #motion_destroy_boolean nexus.value 0
scoreboard players set #motion_halt_boolean nexus.value 0
scoreboard players set #motion_missed_ticks_boolean nexus.value 1
scoreboard players set #motion_limit nexus.value 4000

execute positioned ~ ~0.475 ~ run function nexus:entity/generic/motion/hv/main







# Get inputs from player

scoreboard players set #wasd_control_w nexus.value 0
scoreboard players set #wasd_control_a nexus.value 0
scoreboard players set #wasd_control_s nexus.value 0
scoreboard players set #wasd_control_d nexus.value 0

execute as @a[tag=nexus.player.target] run function nexus:player/generic/wasd

execute store result score #player_state temp.value if entity @a[tag=nexus.player.target,limit=1]







# Modify steer value

scoreboard players operation #entity_yaw nexus.value = @s nexus.yaw

execute as @a[tag=nexus.player.target] run function nexus:entity/generic/data/extract/fakeplayer/rot

scoreboard players operation #interpolation_destination nexus.value = #entity_yaw nexus.value
scoreboard players operation #interpolation_destination nexus.value -= @s nexus.yaw
scoreboard players add #interpolation_destination nexus.value 1800
scoreboard players operation #interpolation_destination nexus.value %= #3600 nexus.value
scoreboard players remove #interpolation_destination nexus.value 1800
scoreboard players operation #interpolation_destination nexus.value /= #2 nexus.value
execute if score #interpolation_destination nexus.value matches ..-600 run scoreboard players set #interpolation_destination nexus.value -600
execute if score #interpolation_destination nexus.value matches 600.. run scoreboard players set #interpolation_destination nexus.value 600

execute if score #wasd_control_s nexus.value matches 1 if score #wasd_control_w nexus.value matches 0 run scoreboard players operation #interpolation_destination nexus.value *= #-1 nexus.value

scoreboard players operation #interpolation_location nexus.value = @s temp.steer
scoreboard players operation #interpolation_velocity nexus.value = @s temp.mot_steer
scoreboard players set #interpolation_acceleration nexus.value 200
execute unless score #wasd_control_w nexus.value matches 1 unless score #wasd_control_s nexus.value matches 1 run scoreboard players set #interpolation_acceleration nexus.value 5
scoreboard players operation #interpolation_acceleration nexus.value *= #missed_ticks nexus.value

function nexus:generic/interpolation/floating_point/1d

scoreboard players operation @s temp.steer = #interpolation_location nexus.value
scoreboard players operation @s temp.mot_steer = #interpolation_velocity nexus.value







# Modify wheel velocities

scoreboard players set #top_speed temp.value 500
scoreboard players set #sensitivity temp.value 5
scoreboard players operation #speed temp.value = @s temp.mot_fl_wheel
scoreboard players operation #speed temp.value += @s temp.mot_fr_wheel
scoreboard players operation #speed temp.value += @s temp.mot_bl_wheel
scoreboard players operation #speed temp.value += @s temp.mot_br_wheel
scoreboard players operation #speed temp.value *= #sensitivity temp.value
scoreboard players operation #speed temp.value /= #100 nexus.value
scoreboard players operation #speed temp.value /= #4 nexus.value
scoreboard players operation #acceleration temp.value = #speed temp.value
scoreboard players operation #acceleration temp.value *= #top_speed temp.value
scoreboard players operation #sensitivity temp.value += #top_speed temp.value
scoreboard players operation #acceleration temp.value /= #speed temp.value
scoreboard players add #acceleration temp.value 50
scoreboard players operation #gear temp.value = #acceleration temp.value

#scoreboard players set #acceleration temp.value 600
#scoreboard players set #acceleration temp.value 1000
execute if score #wasd_control_w nexus.value matches 1 run scoreboard players operation @s temp.mot_bl_wheel += #acceleration temp.value
execute if score #wasd_control_w nexus.value matches 1 run scoreboard players operation @s temp.mot_br_wheel += #acceleration temp.value
execute if score #wasd_control_s nexus.value matches 1 run scoreboard players operation @s temp.mot_bl_wheel -= #acceleration temp.value
execute if score #wasd_control_s nexus.value matches 1 run scoreboard players operation @s temp.mot_br_wheel -= #acceleration temp.value

scoreboard players operation #acceleration temp.value /= #3 nexus.value
execute if score #wasd_control_w nexus.value matches 1 if score #wasd_control_d nexus.value matches 1 run scoreboard players operation @s temp.mot_fl_wheel += #acceleration temp.value
execute if score #wasd_control_w nexus.value matches 1 if score #wasd_control_a nexus.value matches 1 run scoreboard players operation @s temp.mot_fr_wheel += #acceleration temp.value
execute if score #wasd_control_s nexus.value matches 1 if score #wasd_control_d nexus.value matches 1 run scoreboard players operation @s temp.mot_fl_wheel -= #acceleration temp.value
execute if score #wasd_control_s nexus.value matches 1 if score #wasd_control_a nexus.value matches 1 run scoreboard players operation @s temp.mot_fr_wheel -= #acceleration temp.value

scoreboard players set #friction_numerator nexus.value 98
execute unless score #wasd_control_w nexus.value matches 1 unless score #wasd_control_s nexus.value matches 1 run scoreboard players set #friction_numerator nexus.value 90
scoreboard players set #friction_denominator nexus.value 100

scoreboard players set #powerslide_left nexus.value 100
scoreboard players set #powerslide_right nexus.value 100
execute if score #wasd_control_a nexus.value matches 1 run scoreboard players set #powerslide_left nexus.value 97
execute if score #wasd_control_d nexus.value matches 1 run scoreboard players set #powerslide_right nexus.value 97

execute store result score #boolean temp.value if score @s temp.mot_fl_wheel matches ..-1
execute if score #boolean temp.value matches 1 run scoreboard players operation @s temp.mot_fl_wheel *= #-1 nexus.value
scoreboard players operation @s temp.mot_fl_wheel *= #friction_numerator nexus.value
scoreboard players operation @s temp.mot_fl_wheel /= #friction_denominator nexus.value
scoreboard players operation @s temp.mot_fl_wheel *= #powerslide_left nexus.value
scoreboard players operation @s temp.mot_fl_wheel /= #friction_denominator nexus.value
execute if score #boolean temp.value matches 1 run scoreboard players operation @s temp.mot_fl_wheel *= #-1 nexus.value

execute store result score #boolean temp.value if score @s temp.mot_fr_wheel matches ..-1
execute if score #boolean temp.value matches 1 run scoreboard players operation @s temp.mot_fr_wheel *= #-1 nexus.value
scoreboard players operation @s temp.mot_fr_wheel *= #friction_numerator nexus.value
scoreboard players operation @s temp.mot_fr_wheel /= #friction_denominator nexus.value
scoreboard players operation @s temp.mot_fr_wheel *= #powerslide_right nexus.value
scoreboard players operation @s temp.mot_fr_wheel /= #friction_denominator nexus.value
execute if score #boolean temp.value matches 1 run scoreboard players operation @s temp.mot_fr_wheel *= #-1 nexus.value

execute store result score #boolean temp.value if score @s temp.mot_bl_wheel matches ..-1
execute if score #boolean temp.value matches 1 run scoreboard players operation @s temp.mot_bl_wheel *= #-1 nexus.value
scoreboard players operation @s temp.mot_bl_wheel *= #friction_numerator nexus.value
scoreboard players operation @s temp.mot_bl_wheel /= #friction_denominator nexus.value
execute if score #boolean temp.value matches 1 run scoreboard players operation @s temp.mot_bl_wheel *= #-1 nexus.value

execute store result score #boolean temp.value if score @s temp.mot_br_wheel matches ..-1
execute if score #boolean temp.value matches 1 run scoreboard players operation @s temp.mot_br_wheel *= #-1 nexus.value
scoreboard players operation @s temp.mot_br_wheel *= #friction_numerator nexus.value
scoreboard players operation @s temp.mot_br_wheel /= #friction_denominator nexus.value
execute if score #boolean temp.value matches 1 run scoreboard players operation @s temp.mot_br_wheel *= #-1 nexus.value







# Modify wheel rotation

scoreboard players operation #math_00 temp.value = @s temp.mot_fl_wheel
scoreboard players operation #math_01 temp.value = @s temp.mot_fr_wheel
scoreboard players operation #math_02 temp.value = @s temp.mot_bl_wheel
scoreboard players operation #math_03 temp.value = @s temp.mot_br_wheel
scoreboard players operation #math_00 temp.value *= #missed_ticks nexus.value
scoreboard players operation #math_01 temp.value *= #missed_ticks nexus.value
scoreboard players operation #math_02 temp.value *= #missed_ticks nexus.value
scoreboard players operation #math_03 temp.value *= #missed_ticks nexus.value
scoreboard players operation @s temp.fl_wheel += #math_00 temp.value
scoreboard players operation @s temp.fr_wheel += #math_01 temp.value
scoreboard players operation @s temp.bl_wheel += #math_02 temp.value
scoreboard players operation @s temp.br_wheel += #math_03 temp.value







# Modify rotation

scoreboard players set #friction_numerator nexus.value 95
execute unless score #wasd_control_w nexus.value matches 1 unless score #wasd_control_s nexus.value matches 1 run scoreboard players set #friction_numerator nexus.value 95
scoreboard players set #friction_denominator nexus.value 100

execute store result score #boolean temp.value if score @s nexus.mot_yaw matches ..-1
execute if score #boolean temp.value matches 1 run scoreboard players operation @s nexus.mot_yaw *= #-1 nexus.value
scoreboard players operation @s nexus.mot_yaw *= #friction_numerator nexus.value
scoreboard players operation @s nexus.mot_yaw /= #friction_denominator nexus.value
execute if score #boolean temp.value matches 1 run scoreboard players operation @s nexus.mot_yaw *= #-1 nexus.value
scoreboard players operation @s nexus.yaw += @s nexus.mot_yaw







# Collisions

execute if score #collision_x nexus.value matches 1 run scoreboard players operation @s nexus.mot_x *= #-1 nexus.value
execute if score #collision_y nexus.value matches 1 run scoreboard players operation @s nexus.mot_y *= #-1 nexus.value
execute if score #collision_z nexus.value matches 1 run scoreboard players operation @s nexus.mot_z *= #-1 nexus.value
execute if score #collision_y nexus.value matches 1 run scoreboard players operation @s nexus.mot_y /= #2 nexus.value

execute if score #collision_x nexus.value matches 1 run scoreboard players operation @s temp.traction /= #4 nexus.value
execute if score #collision_z nexus.value matches 1 run scoreboard players operation @s temp.traction /= #4 nexus.value

execute if score @s nexus.collide_y matches -1 run scoreboard players set @s nexus.animation 4
execute if score @s nexus.animation matches 1.. run scoreboard players remove @s nexus.animation 1

execute if score #motion_climbed_boolean nexus.value matches 1 run scoreboard players add @s nexus.mot_y 100







# Manage traction

scoreboard players set #interpolation_destination nexus.value 0
execute if score @s nexus.collide_y matches -1 run scoreboard players set #interpolation_destination nexus.value 1000
scoreboard players operation #interpolation_location nexus.value = @s temp.traction
scoreboard players operation #interpolation_velocity nexus.value = @s temp.traction_delta
execute if score @s nexus.collide_y matches -1 run scoreboard players set #interpolation_acceleration nexus.value 10
execute if score @s nexus.collide_y matches 0.. run scoreboard players set #interpolation_acceleration nexus.value 2

function nexus:generic/interpolation/floating_point/1d

scoreboard players operation @s temp.traction = #interpolation_location nexus.value
scoreboard players operation @s temp.traction_delta = #interpolation_velocity nexus.value







# Apply gravity

scoreboard players operation #math_00 temp.value = #gravity nexus.value
scoreboard players operation #math_00 temp.value *= #missed_ticks nexus.value
scoreboard players operation @s nexus.mot_y += #math_00 temp.value







# Compute vectors

scoreboard players operation #input_yaw nexus.value = @s nexus.yaw
function nexus:generic/vector/from_gimbal/2d/yaw
scoreboard players operation #vector_x temp.value = #output_vector_x nexus.value
scoreboard players operation #vector_z temp.value = #output_vector_z nexus.value

scoreboard players operation #input_yaw nexus.value += @s temp.steer
function nexus:generic/vector/from_gimbal/2d/yaw
scoreboard players operation #front_vector_x temp.value = #output_vector_x nexus.value
scoreboard players operation #front_vector_z temp.value = #output_vector_z nexus.value







# Compute wheel positions and vectors

scoreboard players set #input_yaw nexus.value -450
scoreboard players operation #input_yaw nexus.value += @s nexus.yaw
function nexus:generic/vector/from_gimbal/2d/yaw
scoreboard players operation #fl_pos_x temp.value = #output_vector_x nexus.value
scoreboard players operation #fl_pos_z temp.value = #output_vector_z nexus.value

scoreboard players set #input_yaw nexus.value 450
scoreboard players operation #input_yaw nexus.value += @s nexus.yaw
function nexus:generic/vector/from_gimbal/2d/yaw
scoreboard players operation #fr_pos_x temp.value = #output_vector_x nexus.value
scoreboard players operation #fr_pos_z temp.value = #output_vector_z nexus.value

scoreboard players set #input_yaw nexus.value -1350
scoreboard players operation #input_yaw nexus.value += @s nexus.yaw
function nexus:generic/vector/from_gimbal/2d/yaw
scoreboard players operation #bl_pos_x temp.value = #output_vector_x nexus.value
scoreboard players operation #bl_pos_z temp.value = #output_vector_z nexus.value

scoreboard players set #input_yaw nexus.value 1350
scoreboard players operation #input_yaw nexus.value += @s nexus.yaw
function nexus:generic/vector/from_gimbal/2d/yaw
scoreboard players operation #br_pos_x temp.value = #output_vector_x nexus.value
scoreboard players operation #br_pos_z temp.value = #output_vector_z nexus.value

scoreboard players operation #fl_pos_x temp.value *= #7 nexus.value
scoreboard players operation #fl_pos_z temp.value *= #7 nexus.value
scoreboard players operation #fr_pos_x temp.value *= #7 nexus.value
scoreboard players operation #fr_pos_z temp.value *= #7 nexus.value
scoreboard players operation #bl_pos_x temp.value *= #7 nexus.value
scoreboard players operation #bl_pos_z temp.value *= #7 nexus.value
scoreboard players operation #br_pos_x temp.value *= #7 nexus.value
scoreboard players operation #br_pos_z temp.value *= #7 nexus.value
scoreboard players operation #fl_pos_x temp.value /= #10 nexus.value
scoreboard players operation #fl_pos_z temp.value /= #10 nexus.value
scoreboard players operation #fr_pos_x temp.value /= #10 nexus.value
scoreboard players operation #fr_pos_z temp.value /= #10 nexus.value
scoreboard players operation #bl_pos_x temp.value /= #10 nexus.value
scoreboard players operation #bl_pos_z temp.value /= #10 nexus.value
scoreboard players operation #br_pos_x temp.value /= #10 nexus.value
scoreboard players operation #br_pos_z temp.value /= #10 nexus.value

scoreboard players operation #fl_vector_x temp.value = #fr_pos_x temp.value
scoreboard players operation #fl_vector_z temp.value = #fr_pos_z temp.value
scoreboard players operation #fr_vector_x temp.value = #br_pos_x temp.value
scoreboard players operation #fr_vector_z temp.value = #br_pos_z temp.value
scoreboard players operation #bl_vector_x temp.value = #fl_pos_x temp.value
scoreboard players operation #bl_vector_z temp.value = #fl_pos_z temp.value
scoreboard players operation #br_vector_x temp.value = #bl_pos_x temp.value
scoreboard players operation #br_vector_z temp.value = #bl_pos_z temp.value







# Compute velocity of the wheels relative to the ground

scoreboard players set #mot_yaw_scalar temp.value 990
scoreboard players operation #mot_yaw_scalar temp.value *= @s nexus.mot_yaw
scoreboard players operation #mot_yaw_scalar temp.value /= #1000 nexus.value
scoreboard players operation #mot_yaw_scalar temp.value *= #3141 nexus.value
scoreboard players operation #mot_yaw_scalar temp.value /= #1800 nexus.value



scoreboard players set #wheel_size_numerator temp.value 5
scoreboard players set #wheel_size_denominator temp.value 32



scoreboard players operation #velocity temp.value = @s temp.mot_fl_wheel
scoreboard players operation #velocity temp.value *= #3141 nexus.value
scoreboard players operation #velocity temp.value *= #wheel_size_numerator temp.value
scoreboard players operation #velocity temp.value /= #1800 nexus.value
scoreboard players operation #velocity temp.value /= #wheel_size_denominator temp.value

scoreboard players operation #fl_velocity_x temp.value = #front_vector_x temp.value
scoreboard players operation #fl_velocity_z temp.value = #front_vector_z temp.value
scoreboard players operation #fl_velocity_x temp.value *= #velocity temp.value
scoreboard players operation #fl_velocity_z temp.value *= #velocity temp.value
scoreboard players operation #fl_velocity_x temp.value /= #1000 nexus.value
scoreboard players operation #fl_velocity_z temp.value /= #1000 nexus.value
scoreboard players operation #fl_velocity_x temp.value *= #-1 nexus.value
scoreboard players operation #fl_velocity_z temp.value *= #-1 nexus.value
scoreboard players operation #fl_velocity_x temp.value += @s nexus.mot_x
scoreboard players operation #fl_velocity_z temp.value += @s nexus.mot_z

scoreboard players operation #fl_vector_x temp.value *= #mot_yaw_scalar temp.value
scoreboard players operation #fl_vector_z temp.value *= #mot_yaw_scalar temp.value
scoreboard players operation #fl_vector_x temp.value /= #1000 nexus.value
scoreboard players operation #fl_vector_z temp.value /= #1000 nexus.value
scoreboard players operation #fl_velocity_x temp.value += #fl_vector_x temp.value
scoreboard players operation #fl_velocity_z temp.value += #fl_vector_z temp.value
scoreboard players operation #fl_velocity_x temp.value *= @s temp.traction
scoreboard players operation #fl_velocity_z temp.value *= @s temp.traction
scoreboard players operation #fl_velocity_x temp.value /= #1000 nexus.value
scoreboard players operation #fl_velocity_z temp.value /= #1000 nexus.value



scoreboard players operation #velocity temp.value = @s temp.mot_fr_wheel
scoreboard players operation #velocity temp.value *= #3141 nexus.value
scoreboard players operation #velocity temp.value *= #wheel_size_numerator temp.value
scoreboard players operation #velocity temp.value /= #1800 nexus.value
scoreboard players operation #velocity temp.value /= #wheel_size_denominator temp.value

scoreboard players operation #fr_velocity_x temp.value = #front_vector_x temp.value
scoreboard players operation #fr_velocity_z temp.value = #front_vector_z temp.value
scoreboard players operation #fr_velocity_x temp.value *= #velocity temp.value
scoreboard players operation #fr_velocity_z temp.value *= #velocity temp.value
scoreboard players operation #fr_velocity_x temp.value /= #1000 nexus.value
scoreboard players operation #fr_velocity_z temp.value /= #1000 nexus.value
scoreboard players operation #fr_velocity_x temp.value *= #-1 nexus.value
scoreboard players operation #fr_velocity_z temp.value *= #-1 nexus.value
scoreboard players operation #fr_velocity_x temp.value += @s nexus.mot_x
scoreboard players operation #fr_velocity_z temp.value += @s nexus.mot_z

scoreboard players operation #fr_vector_x temp.value *= #mot_yaw_scalar temp.value
scoreboard players operation #fr_vector_z temp.value *= #mot_yaw_scalar temp.value
scoreboard players operation #fr_vector_x temp.value /= #1000 nexus.value
scoreboard players operation #fr_vector_z temp.value /= #1000 nexus.value
scoreboard players operation #fr_velocity_x temp.value += #fr_vector_x temp.value
scoreboard players operation #fr_velocity_z temp.value += #fr_vector_z temp.value
scoreboard players operation #fr_velocity_x temp.value *= @s temp.traction
scoreboard players operation #fr_velocity_z temp.value *= @s temp.traction
scoreboard players operation #fr_velocity_x temp.value /= #1000 nexus.value
scoreboard players operation #fr_velocity_z temp.value /= #1000 nexus.value



scoreboard players operation #velocity temp.value = @s temp.mot_bl_wheel
scoreboard players operation #velocity temp.value *= #3141 nexus.value
scoreboard players operation #velocity temp.value *= #wheel_size_numerator temp.value
scoreboard players operation #velocity temp.value /= #1800 nexus.value
scoreboard players operation #velocity temp.value /= #wheel_size_denominator temp.value

scoreboard players operation #bl_velocity_x temp.value = #vector_x temp.value
scoreboard players operation #bl_velocity_z temp.value = #vector_z temp.value
scoreboard players operation #bl_velocity_x temp.value *= #velocity temp.value
scoreboard players operation #bl_velocity_z temp.value *= #velocity temp.value
scoreboard players operation #bl_velocity_x temp.value /= #1000 nexus.value
scoreboard players operation #bl_velocity_z temp.value /= #1000 nexus.value
scoreboard players operation #bl_velocity_x temp.value *= #-1 nexus.value
scoreboard players operation #bl_velocity_z temp.value *= #-1 nexus.value
scoreboard players operation #bl_velocity_x temp.value += @s nexus.mot_x
scoreboard players operation #bl_velocity_z temp.value += @s nexus.mot_z

scoreboard players operation #bl_vector_x temp.value *= #mot_yaw_scalar temp.value
scoreboard players operation #bl_vector_z temp.value *= #mot_yaw_scalar temp.value
scoreboard players operation #bl_vector_x temp.value /= #1000 nexus.value
scoreboard players operation #bl_vector_z temp.value /= #1000 nexus.value
scoreboard players operation #bl_velocity_x temp.value += #bl_vector_x temp.value
scoreboard players operation #bl_velocity_z temp.value += #bl_vector_z temp.value
scoreboard players operation #bl_velocity_x temp.value *= @s temp.traction
scoreboard players operation #bl_velocity_z temp.value *= @s temp.traction
scoreboard players operation #bl_velocity_x temp.value /= #1000 nexus.value
scoreboard players operation #bl_velocity_z temp.value /= #1000 nexus.value



scoreboard players operation #velocity temp.value = @s temp.mot_br_wheel
scoreboard players operation #velocity temp.value *= #3141 nexus.value
scoreboard players operation #velocity temp.value *= #wheel_size_numerator temp.value
scoreboard players operation #velocity temp.value /= #1800 nexus.value
scoreboard players operation #velocity temp.value /= #wheel_size_denominator temp.value

scoreboard players operation #br_velocity_x temp.value = #vector_x temp.value
scoreboard players operation #br_velocity_z temp.value = #vector_z temp.value
scoreboard players operation #br_velocity_x temp.value *= #velocity temp.value
scoreboard players operation #br_velocity_z temp.value *= #velocity temp.value
scoreboard players operation #br_velocity_x temp.value /= #1000 nexus.value
scoreboard players operation #br_velocity_z temp.value /= #1000 nexus.value
scoreboard players operation #br_velocity_x temp.value *= #-1 nexus.value
scoreboard players operation #br_velocity_z temp.value *= #-1 nexus.value
scoreboard players operation #br_velocity_x temp.value += @s nexus.mot_x
scoreboard players operation #br_velocity_z temp.value += @s nexus.mot_z

scoreboard players operation #br_vector_x temp.value *= #mot_yaw_scalar temp.value
scoreboard players operation #br_vector_z temp.value *= #mot_yaw_scalar temp.value
scoreboard players operation #br_vector_x temp.value /= #1000 nexus.value
scoreboard players operation #br_vector_z temp.value /= #1000 nexus.value
scoreboard players operation #br_velocity_x temp.value += #br_vector_x temp.value
scoreboard players operation #br_velocity_z temp.value += #br_vector_z temp.value
scoreboard players operation #br_velocity_x temp.value *= @s temp.traction
scoreboard players operation #br_velocity_z temp.value *= @s temp.traction
scoreboard players operation #br_velocity_x temp.value /= #1000 nexus.value
scoreboard players operation #br_velocity_z temp.value /= #1000 nexus.value



execute unless score @s nexus.collide_y matches -1 run scoreboard players set #fl_velocity_x temp.value 0
execute unless score @s nexus.collide_y matches -1 run scoreboard players set #fl_velocity_z temp.value 0
execute unless score @s nexus.collide_y matches -1 run scoreboard players set #fr_velocity_x temp.value 0
execute unless score @s nexus.collide_y matches -1 run scoreboard players set #fr_velocity_z temp.value 0
execute unless score @s nexus.collide_y matches -1 run scoreboard players set #bl_velocity_x temp.value 0
execute unless score @s nexus.collide_y matches -1 run scoreboard players set #bl_velocity_z temp.value 0
execute unless score @s nexus.collide_y matches -1 run scoreboard players set #br_velocity_x temp.value 0
execute unless score @s nexus.collide_y matches -1 run scoreboard players set #br_velocity_z temp.value 0







# Apply traction to speeds

scoreboard players set #scale_factor nexus.value 1
scoreboard players set #sensitivity temp.value 2000

scoreboard players operation #input_vector_x nexus.value = #fl_velocity_x temp.value
scoreboard players operation #input_vector_y nexus.value = #fl_velocity_z temp.value
function nexus:generic/vector/length/2d
scoreboard players operation #output nexus.value += #sensitivity temp.value
scoreboard players operation #fl_velocity_x temp.value *= #sensitivity temp.value
scoreboard players operation #fl_velocity_z temp.value *= #sensitivity temp.value
scoreboard players operation #fl_velocity_x temp.value /= #output nexus.value
scoreboard players operation #fl_velocity_z temp.value /= #output nexus.value

scoreboard players operation #input_vector_x nexus.value = #fr_velocity_x temp.value
scoreboard players operation #input_vector_y nexus.value = #fr_velocity_z temp.value
function nexus:generic/vector/length/2d
scoreboard players operation #output nexus.value += #sensitivity temp.value
scoreboard players operation #fr_velocity_x temp.value *= #sensitivity temp.value
scoreboard players operation #fr_velocity_z temp.value *= #sensitivity temp.value
scoreboard players operation #fr_velocity_x temp.value /= #output nexus.value
scoreboard players operation #fr_velocity_z temp.value /= #output nexus.value

scoreboard players operation #input_vector_x nexus.value = #bl_velocity_x temp.value
scoreboard players operation #input_vector_y nexus.value = #bl_velocity_z temp.value
function nexus:generic/vector/length/2d
scoreboard players operation #output nexus.value += #sensitivity temp.value
scoreboard players operation #bl_velocity_x temp.value *= #sensitivity temp.value
scoreboard players operation #bl_velocity_z temp.value *= #sensitivity temp.value
scoreboard players operation #bl_velocity_x temp.value /= #output nexus.value
scoreboard players operation #bl_velocity_z temp.value /= #output nexus.value

scoreboard players operation #input_vector_x nexus.value = #br_velocity_x temp.value
scoreboard players operation #input_vector_y nexus.value = #br_velocity_z temp.value
function nexus:generic/vector/length/2d
scoreboard players operation #output nexus.value += #sensitivity temp.value
scoreboard players operation #br_velocity_x temp.value *= #sensitivity temp.value
scoreboard players operation #br_velocity_z temp.value *= #sensitivity temp.value
scoreboard players operation #br_velocity_x temp.value /= #output nexus.value
scoreboard players operation #br_velocity_z temp.value /= #output nexus.value








# Compute forces and modify motion of body

scoreboard players operation #translational_force_x temp.value = #fl_velocity_x temp.value
scoreboard players operation #translational_force_z temp.value = #fl_velocity_z temp.value
scoreboard players operation #translational_force_x temp.value += #fr_velocity_x temp.value
scoreboard players operation #translational_force_z temp.value += #fr_velocity_z temp.value
scoreboard players operation #translational_force_x temp.value += #bl_velocity_x temp.value
scoreboard players operation #translational_force_z temp.value += #bl_velocity_z temp.value
scoreboard players operation #translational_force_x temp.value += #br_velocity_x temp.value
scoreboard players operation #translational_force_z temp.value += #br_velocity_z temp.value

scoreboard players set #inertia_numerator temp.value 250
scoreboard players set #inertia_denominator temp.value 1000

scoreboard players operation #translational_force_x temp.value *= #inertia_numerator temp.value
scoreboard players operation #translational_force_z temp.value *= #inertia_numerator temp.value
scoreboard players operation #translational_force_x temp.value /= #inertia_denominator temp.value
scoreboard players operation #translational_force_z temp.value /= #inertia_denominator temp.value

scoreboard players operation @s nexus.mot_x -= #translational_force_x temp.value
scoreboard players operation @s nexus.mot_z -= #translational_force_z temp.value



scoreboard players operation #math_00 temp.value = #fl_pos_z temp.value
scoreboard players operation #math_00 temp.value *= #fl_velocity_x temp.value
scoreboard players operation #math_01 temp.value = #fl_pos_x temp.value
scoreboard players operation #math_01 temp.value *= #fl_velocity_z temp.value
scoreboard players operation #fl_torque temp.value = #math_00 temp.value
scoreboard players operation #fl_torque temp.value -= #math_01 temp.value

scoreboard players operation #math_00 temp.value = #fr_pos_z temp.value
scoreboard players operation #math_00 temp.value *= #fr_velocity_x temp.value
scoreboard players operation #math_01 temp.value = #fr_pos_x temp.value
scoreboard players operation #math_01 temp.value *= #fr_velocity_z temp.value
scoreboard players operation #fr_torque temp.value = #math_00 temp.value
scoreboard players operation #fr_torque temp.value -= #math_01 temp.value

scoreboard players operation #math_00 temp.value = #bl_pos_z temp.value
scoreboard players operation #math_00 temp.value *= #bl_velocity_x temp.value
scoreboard players operation #math_01 temp.value = #bl_pos_x temp.value
scoreboard players operation #math_01 temp.value *= #bl_velocity_z temp.value
scoreboard players operation #bl_torque temp.value = #math_00 temp.value
scoreboard players operation #bl_torque temp.value -= #math_01 temp.value

scoreboard players operation #math_00 temp.value = #br_pos_z temp.value
scoreboard players operation #math_00 temp.value *= #br_velocity_x temp.value
scoreboard players operation #math_01 temp.value = #br_pos_x temp.value
scoreboard players operation #math_01 temp.value *= #br_velocity_z temp.value
scoreboard players operation #br_torque temp.value = #math_00 temp.value
scoreboard players operation #br_torque temp.value -= #math_01 temp.value

scoreboard players operation #torque temp.value = #fl_torque temp.value
scoreboard players operation #torque temp.value += #fr_torque temp.value
scoreboard players operation #torque temp.value += #bl_torque temp.value
scoreboard players operation #torque temp.value += #br_torque temp.value
scoreboard players operation #torque temp.value *= #1800 nexus.value
scoreboard players operation #torque temp.value /= #3141 nexus.value
scoreboard players operation #torque temp.value /= #1000 nexus.value

scoreboard players set #inertia_numerator temp.value 250
scoreboard players set #inertia_denominator temp.value 1000

scoreboard players operation #torque temp.value *= #inertia_numerator temp.value
scoreboard players operation #torque temp.value /= #inertia_denominator temp.value

scoreboard players operation @s nexus.mot_yaw += #torque temp.value







# Compute forces and modify motion of wheels

scoreboard players set #inertia_numerator temp.value 500
scoreboard players set #inertia_denominator temp.value 1000

scoreboard players operation #input_vector_1_x nexus.value = #fl_velocity_x temp.value
scoreboard players operation #input_vector_1_y nexus.value = #fl_velocity_z temp.value
scoreboard players operation #input_vector_2_x nexus.value = #front_vector_x temp.value
scoreboard players operation #input_vector_2_y nexus.value = #front_vector_z temp.value
function nexus:generic/vector/dot_product/2d
scoreboard players operation #output nexus.value *= #1800 nexus.value
scoreboard players operation #output nexus.value *= #wheel_size_denominator temp.value
scoreboard players operation #output nexus.value /= #3141 nexus.value
scoreboard players operation #output nexus.value /= #wheel_size_numerator temp.value
scoreboard players operation #output nexus.value *= #inertia_numerator temp.value
scoreboard players operation #output nexus.value /= #inertia_denominator temp.value
scoreboard players operation @s temp.mot_fl_wheel += #output nexus.value

scoreboard players operation #input_vector_1_x nexus.value = #fr_velocity_x temp.value
scoreboard players operation #input_vector_1_y nexus.value = #fr_velocity_z temp.value
scoreboard players operation #input_vector_2_x nexus.value = #front_vector_x temp.value
scoreboard players operation #input_vector_2_y nexus.value = #front_vector_z temp.value
function nexus:generic/vector/dot_product/2d
scoreboard players operation #output nexus.value *= #1800 nexus.value
scoreboard players operation #output nexus.value *= #wheel_size_denominator temp.value
scoreboard players operation #output nexus.value /= #3141 nexus.value
scoreboard players operation #output nexus.value /= #wheel_size_numerator temp.value
scoreboard players operation #output nexus.value *= #inertia_numerator temp.value
scoreboard players operation #output nexus.value /= #inertia_denominator temp.value
scoreboard players operation @s temp.mot_fr_wheel += #output nexus.value

scoreboard players operation #input_vector_1_x nexus.value = #bl_velocity_x temp.value
scoreboard players operation #input_vector_1_y nexus.value = #bl_velocity_z temp.value
scoreboard players operation #input_vector_2_x nexus.value = #vector_x temp.value
scoreboard players operation #input_vector_2_y nexus.value = #vector_z temp.value
function nexus:generic/vector/dot_product/2d
scoreboard players operation #output nexus.value *= #1800 nexus.value
scoreboard players operation #output nexus.value *= #wheel_size_denominator temp.value
scoreboard players operation #output nexus.value /= #3141 nexus.value
scoreboard players operation #output nexus.value /= #wheel_size_numerator temp.value
scoreboard players operation #output nexus.value *= #inertia_numerator temp.value
scoreboard players operation #output nexus.value /= #inertia_denominator temp.value
scoreboard players operation @s temp.mot_bl_wheel += #output nexus.value

scoreboard players operation #input_vector_1_x nexus.value = #br_velocity_x temp.value
scoreboard players operation #input_vector_1_y nexus.value = #br_velocity_z temp.value
scoreboard players operation #input_vector_2_x nexus.value = #vector_x temp.value
scoreboard players operation #input_vector_2_y nexus.value = #vector_z temp.value
function nexus:generic/vector/dot_product/2d
scoreboard players operation #output nexus.value *= #1800 nexus.value
scoreboard players operation #output nexus.value *= #wheel_size_denominator temp.value
scoreboard players operation #output nexus.value /= #3141 nexus.value
scoreboard players operation #output nexus.value /= #wheel_size_numerator temp.value
scoreboard players operation #output nexus.value *= #inertia_numerator temp.value
scoreboard players operation #output nexus.value /= #inertia_denominator temp.value
scoreboard players operation @s temp.mot_br_wheel += #output nexus.value







# Apply push from entities

scoreboard players set #player_push_boolean nexus.value 1
function nexus:entity/generic/push/main







# Play sounds

scoreboard players operation #drive_boolean temp.value = #wasd_control_w nexus.value
scoreboard players operation #drive_boolean temp.value -= #wasd_control_s nexus.value
execute if score #drive_boolean temp.value matches ..-1 run scoreboard players operation #drive_boolean temp.value *= #-1 nexus.value

execute if score @s temp.sound matches 1.. run scoreboard players remove @s temp.sound 1

execute if score #drive_boolean temp.value matches 1 if score @s temp.sound matches 000 run playsound temp:entity.racecar.internal.in neutral @a[tag= nexus.player.target] ~ ~ ~ 3
execute if score #drive_boolean temp.value matches 1 if score @s temp.sound matches 000 run playsound temp:entity.racecar.external.in neutral @a[tag=!nexus.player.target] ~ ~ ~ 3
execute if score #drive_boolean temp.value matches 1 if score @s temp.sound matches 000 run scoreboard players set @s temp.sound 219
execute if score #drive_boolean temp.value matches 1 if score @s temp.sound matches 200 run playsound temp:entity.racecar.internal.drive neutral @a[tag= nexus.player.target] ~ ~ ~ 3
execute if score #drive_boolean temp.value matches 1 if score @s temp.sound matches 200 run playsound temp:entity.racecar.external.drive neutral @a[tag=!nexus.player.target] ~ ~ ~ 3
execute if score #drive_boolean temp.value matches 1 if score @s temp.sound matches 200 run scoreboard players set @s temp.sound 108
execute if score #drive_boolean temp.value matches 1 if score @s temp.sound matches 100 run playsound temp:entity.racecar.internal.drive neutral @a[tag= nexus.player.target] ~ ~ ~ 3
execute if score #drive_boolean temp.value matches 1 if score @s temp.sound matches 100 run playsound temp:entity.racecar.external.drive neutral @a[tag=!nexus.player.target] ~ ~ ~ 3
execute if score #drive_boolean temp.value matches 1 if score @s temp.sound matches 100 run scoreboard players set @s temp.sound 108
execute if score #drive_boolean temp.value matches 0 if score @s temp.sound matches 200 run playsound temp:entity.racecar.internal.out neutral @a[tag= nexus.player.target] ~ ~ ~ 3
execute if score #drive_boolean temp.value matches 0 if score @s temp.sound matches 200 run playsound temp:entity.racecar.external.out neutral @a[tag=!nexus.player.target] ~ ~ ~ 3
execute if score #drive_boolean temp.value matches 0 if score @s temp.sound matches 200 run scoreboard players set @s temp.sound 15
execute if score #drive_boolean temp.value matches 0 if score @s temp.sound matches 100 run playsound temp:entity.racecar.internal.out neutral @a[tag= nexus.player.target] ~ ~ ~ 3
execute if score #drive_boolean temp.value matches 0 if score @s temp.sound matches 100 run playsound temp:entity.racecar.external.out neutral @a[tag=!nexus.player.target] ~ ~ ~ 3
execute if score #drive_boolean temp.value matches 0 if score @s temp.sound matches 100 run scoreboard players set @s temp.sound 15







# Termination conditions

execute if score #motion_fire_boolean nexus.value matches 1 at @s run function temp:entity/racecar/mode/generic/terminate
function nexus:entity/generic/void_check
execute if score #void_boolean nexus.value matches 1 at @s run function temp:entity/racecar/mode/generic/terminate