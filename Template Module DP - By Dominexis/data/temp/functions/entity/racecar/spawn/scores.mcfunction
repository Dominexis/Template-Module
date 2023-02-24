# Assign position

function nexus:entity/generic/data/get/objective/pos

execute at @s run teleport @s ~ ~-0.475 ~







# Assign rotation

scoreboard players set @s nexus.yaw 0
scoreboard players set @s nexus.mot_yaw 0







# Assign motion

scoreboard players set @s nexus.mot_x 0
scoreboard players set @s nexus.mot_y 0
scoreboard players set @s nexus.mot_z 0






# Assign miscellaneous values

scoreboard players set @s nexus.id_bool 1
scoreboard players set @s nexus.id_range 8
scoreboard players set @s nexus.tick_dist 32
scoreboard players set @s nexus.vehicle_id_bool 1
scoreboard players set @s nexus.air_toggle_bool 1
scoreboard players set @s nexus.damage_sensor_bool 0

scoreboard players set @s nexus.size 800
scoreboard players set @s nexus.mass 1500

scoreboard players set @s temp.sound 0
scoreboard players set @s temp.steer 0
scoreboard players set @s temp.mot_steer 0
scoreboard players set @s temp.traction 0
scoreboard players set @s temp.traction_delta 0

scoreboard players set @s temp.fl_wheel 0
scoreboard players set @s temp.fr_wheel 0
scoreboard players set @s temp.bl_wheel 0
scoreboard players set @s temp.br_wheel 0
scoreboard players set @s temp.mot_fl_wheel 0
scoreboard players set @s temp.mot_fr_wheel 0
scoreboard players set @s temp.mot_bl_wheel 0
scoreboard players set @s temp.mot_br_wheel 0