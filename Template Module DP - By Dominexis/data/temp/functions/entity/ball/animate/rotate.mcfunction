# Apply angular velocity

scoreboard players operation #input_ang_vel_x nexus.value = @s nexus.ang_vel_x
scoreboard players operation #input_ang_vel_y nexus.value = @s nexus.ang_vel_y
scoreboard players operation #input_ang_vel_z nexus.value = @s nexus.ang_vel_z
scoreboard players operation #input_ang_vel_x nexus.value *= #missed_ticks nexus.value
scoreboard players operation #input_ang_vel_y nexus.value *= #missed_ticks nexus.value
scoreboard players operation #input_ang_vel_z nexus.value *= #missed_ticks nexus.value

function nexus:generic/quaternion/from_ang_vel

scoreboard players operation #input_quaternion_1_r nexus.value = #output_quaternion_r nexus.value
scoreboard players operation #input_quaternion_1_i nexus.value = #output_quaternion_i nexus.value
scoreboard players operation #input_quaternion_1_j nexus.value = #output_quaternion_j nexus.value
scoreboard players operation #input_quaternion_1_k nexus.value = #output_quaternion_k nexus.value
scoreboard players operation #input_quaternion_2_r nexus.value = @s nexus.quaternion_r
scoreboard players operation #input_quaternion_2_i nexus.value = @s nexus.quaternion_i
scoreboard players operation #input_quaternion_2_j nexus.value = @s nexus.quaternion_j
scoreboard players operation #input_quaternion_2_k nexus.value = @s nexus.quaternion_k

function nexus:generic/quaternion/multiplication/single
function nexus:generic/quaternion/push
function nexus:generic/quaternion/normalize

scoreboard players operation @s nexus.quaternion_r = #output_quaternion_r nexus.value
scoreboard players operation @s nexus.quaternion_i = #output_quaternion_i nexus.value
scoreboard players operation @s nexus.quaternion_j = #output_quaternion_j nexus.value
scoreboard players operation @s nexus.quaternion_k = #output_quaternion_k nexus.value