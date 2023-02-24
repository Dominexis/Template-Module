# Remove scoreboard objectives

scoreboard objectives remove temp.value
scoreboard objectives remove temp.sound

scoreboard objectives remove temp.traction
scoreboard objectives remove temp.traction_delta

scoreboard objectives remove temp.steer
scoreboard objectives remove temp.mot_steer
scoreboard objectives remove temp.fl_wheel
scoreboard objectives remove temp.fr_wheel
scoreboard objectives remove temp.bl_wheel
scoreboard objectives remove temp.br_wheel
scoreboard objectives remove temp.mot_fl_wheel
scoreboard objectives remove temp.mot_fr_wheel
scoreboard objectives remove temp.mot_bl_wheel
scoreboard objectives remove temp.mot_br_wheel

scoreboard objectives remove temp.right_speed
scoreboard objectives remove temp.left_speed

scoreboard objectives remove temp.kick_ticks
scoreboard objectives remove temp.kick_cooldown

scoreboard objectives remove temp.y_1
scoreboard objectives remove temp.y_2
scoreboard objectives remove temp.y_3
scoreboard objectives remove temp.y_4
scoreboard objectives remove temp.y_5

scoreboard objectives remove temp.mot_y_1
scoreboard objectives remove temp.mot_y_2
scoreboard objectives remove temp.mot_y_3
scoreboard objectives remove temp.mot_y_4
scoreboard objectives remove temp.mot_y_5







# Terminate entities

kill @e[type=#temp:generic/entity,tag=temp.entity]







# Clear items

clear @a warped_fungus_on_a_stick{temp:{item:1b}}







# Remove tags from entities

tag @a remove temp.player.property.riding.racecar







# Clear storage

data remove storage temp:data tag







# Reset scores

scoreboard players reset #template_module_last_modified nexus.value







# Send message to chat

execute if score #debug_system_messages nexus.value matches 1 run tellraw @a[tag=nexus.player.operator] ["",{"text":"[","color":"gray"},{"text":"Template Module","color":"gold"},{"text":"]","color":"gray"}," ",{"text":"Module was successfully uninstalled.","color":"gray"}]