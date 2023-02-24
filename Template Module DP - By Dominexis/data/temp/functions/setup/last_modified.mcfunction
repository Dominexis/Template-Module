# Set last modified value

scoreboard players set #last_modified nexus.value 2023022363
execute unless score #template_module_last_modified nexus.value = #last_modified nexus.value run scoreboard players set #update_installation_boolean nexus.value 1
scoreboard players operation #template_module_last_modified nexus.value = #last_modified nexus.value