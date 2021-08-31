extends Node

onready var player_container_scene = preload("res://Scenes/Instances/PlayerContainer.tscn")
onready var server_data = get_node("../ServerData")

func start(player_id):
	"""
	https://www.youtube.com/watch?v=y_3f_QXmvU8&list=PLZ-54sd-DMAKU8Neo5KsVmq8KtoDkfi4s&index=5
	"""
	create_player_container(player_id)
	
func create_player_container(player_id):
	var new_player_container = player_container_scene.instance()
	new_player_container.name = str(player_id)
	get_parent().add_child(new_player_container, true)
	var player_container = get_node("../" + str(player_id))
	fill_player_container(player_container)
	
func fill_player_container(player_container):
	player_container.player_stats = server_data.test_data.Stats
