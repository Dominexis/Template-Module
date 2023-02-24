# Assign features

scoreboard players set #feature_time_manager nexus.value 1
scoreboard players set #feature_player_health nexus.value 1
scoreboard players set #feature_player_respawn nexus.value 1
scoreboard players set #feature_entity_processing nexus.value 1
scoreboard players set #feature_custom_entity_ticking nexus.value 1
scoreboard players set #feature_vehicle nexus.value 1
scoreboard players set #feature_event_id_phe nexus.value 1
scoreboard players set #feature_object_ticking nexus.value 1
execute if score #feature_maximum_entity_time nexus.value matches 45.. run scoreboard players set #feature_maximum_entity_time nexus.value 45
execute if score #feature_maximum_object_time nexus.value matches 45.. run scoreboard players set #feature_maximum_object_time nexus.value 45
execute if score #feature_minimum_entity_time nexus.value matches ..5 run scoreboard players set #feature_minimum_entity_time nexus.value 5
execute if score #feature_minimum_object_time nexus.value matches ..5 run scoreboard players set #feature_minimum_object_time nexus.value 5
execute if score #feature_minimum_difficulty nexus.value matches ..1 run scoreboard players set #feature_minimum_difficulty nexus.value 1