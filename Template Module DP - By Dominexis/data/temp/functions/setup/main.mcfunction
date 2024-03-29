# Create scoreboard objectives

scoreboard objectives add temp.value dummy
scoreboard objectives add temp.sound dummy

scoreboard objectives add temp.traction dummy
scoreboard objectives add temp.traction_delta dummy

scoreboard objectives add temp.steer dummy
scoreboard objectives add temp.mot_steer dummy
scoreboard objectives add temp.fl_wheel dummy
scoreboard objectives add temp.fr_wheel dummy
scoreboard objectives add temp.bl_wheel dummy
scoreboard objectives add temp.br_wheel dummy
scoreboard objectives add temp.mot_fl_wheel dummy
scoreboard objectives add temp.mot_fr_wheel dummy
scoreboard objectives add temp.mot_bl_wheel dummy
scoreboard objectives add temp.mot_br_wheel dummy

scoreboard objectives add temp.right_speed dummy
scoreboard objectives add temp.left_speed dummy

scoreboard objectives add temp.kick_ticks dummy
scoreboard objectives add temp.kick_cooldown dummy

scoreboard objectives add temp.y_1 dummy
scoreboard objectives add temp.y_2 dummy
scoreboard objectives add temp.y_3 dummy
scoreboard objectives add temp.y_4 dummy
scoreboard objectives add temp.y_5 dummy

scoreboard objectives add temp.mot_y_1 dummy
scoreboard objectives add temp.mot_y_2 dummy
scoreboard objectives add temp.mot_y_3 dummy
scoreboard objectives add temp.mot_y_4 dummy
scoreboard objectives add temp.mot_y_5 dummy







# Set constants

scoreboard players set #1 temp.value 1
scoreboard players set #10 temp.value 10
scoreboard players set #100 temp.value 100
scoreboard players set #1000 temp.value 1000
scoreboard players set #10000 temp.value 10000
scoreboard players set #100000 temp.value 100000
scoreboard players set #1000000 temp.value 1000000
scoreboard players set #10000000 temp.value 10000000
scoreboard players set #100000000 temp.value 100000000
scoreboard players set #1000000000 temp.value 1000000000

scoreboard players set #2 temp.value 2
scoreboard players set #4 temp.value 4
scoreboard players set #8 temp.value 8
scoreboard players set #16 temp.value 16
scoreboard players set #32 temp.value 32
scoreboard players set #64 temp.value 64
scoreboard players set #128 temp.value 128
scoreboard players set #256 temp.value 256
scoreboard players set #512 temp.value 512
scoreboard players set #1024 temp.value 1024
scoreboard players set #2048 temp.value 2048
scoreboard players set #4096 temp.value 4096
scoreboard players set #8192 temp.value 8192
scoreboard players set #16384 temp.value 16384
scoreboard players set #32768 temp.value 32768
scoreboard players set #65536 temp.value 65536
scoreboard players set #131072 temp.value 131072
scoreboard players set #262144 temp.value 262144
scoreboard players set #524288 temp.value 524288
scoreboard players set #1048576 temp.value 1048576
scoreboard players set #2097152 temp.value 2097152
scoreboard players set #4194304 temp.value 4194304
scoreboard players set #8388608 temp.value 8388608
scoreboard players set #16777216 temp.value 16777216
scoreboard players set #33554432 temp.value 33554432
scoreboard players set #67108864 temp.value 67108864
scoreboard players set #134217728 temp.value 134217728
scoreboard players set #268435456 temp.value 268435456
scoreboard players set #536870912 temp.value 536870912
scoreboard players set #1073741824 temp.value 1073741824
scoreboard players set #-2147483648 temp.value -2147483648







# Assign features

function temp:setup/feature/assign



# List of features

scoreboard players add #feature_time_manager nexus.value 0
scoreboard players add #feature_external_time_measurement nexus.value 0
scoreboard players add #feature_player_nbt nexus.value 0
scoreboard players add #feature_player_health nexus.value 0
scoreboard players add #feature_player_respawn nexus.value 0
scoreboard players add #feature_player_motion nexus.value 0
scoreboard players add #feature_entity_processing nexus.value 0
scoreboard players add #feature_entity_health nexus.value 0
scoreboard players add #feature_custom_entity_ticking nexus.value 0
scoreboard players add #feature_unconditional_entity_ticking nexus.value 0
scoreboard players add #feature_damage_sensor_ticking nexus.value 0
scoreboard players add #feature_vehicle nexus.value 0
scoreboard players add #feature_event_id_phe nexus.value 0
scoreboard players add #feature_event_id_pke nexus.value 0
scoreboard players add #feature_event_id_ehp nexus.value 0
scoreboard players add #feature_event_id_ekp nexus.value 0
scoreboard players add #feature_event_id_piwe nexus.value 0
scoreboard players add #feature_object_ticking nexus.value 0
scoreboard players add #feature_chunk_processing nexus.value 0
scoreboard players add #feature_chunk_activation nexus.value 0
scoreboard players add #feature_chunk_range nexus.value 0
scoreboard players add #feature_maximum_entity_time nexus.value 0
scoreboard players add #feature_maximum_object_time nexus.value 0
scoreboard players add #feature_maximum_chunk_time nexus.value 0
scoreboard players add #feature_minimum_entity_time nexus.value 0
scoreboard players add #feature_minimum_object_time nexus.value 0
scoreboard players add #feature_minimum_chunk_time nexus.value 0
scoreboard players add #feature_minimum_difficulty nexus.value 0







# Increment module count

scoreboard players add #doms_nexus_module_count nexus.value 1