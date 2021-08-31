extends Node


var network = NetworkedMultiplayerENet.new()
var port = 1909
var max_players = 3

onready var player_verification_proccess = get_node("PlayerVerification")
onready var combat_functions = get_node("Combat")

var player_state_collection = {}

func _ready():
	StartServer()
	
func StartServer():
	network.create_server(port, max_players)
	get_tree().set_network_peer(network)
	print("Server started")
	
	network.connect("peer_connected", self, "_Peer_Connected")
	network.connect("peer_disconnected", self, "_Peer_Disconnected")
	
func _Peer_Connected(player_id):
	print("User " + str(player_id) + " connected")
	player_verification_proccess.start(player_id)
	rpc_id(0, "spawn_new_player", player_id, Vector3(0.0, 7.0, 0.0))
	
func _Peer_Disconnected(player_id):
	print("User " + str(player_id) + " disconnected")
	if has_node(str(player_id)):
		get_node(str(player_id)).queue_free()
		player_state_collection.erase(player_id)
		rpc_id(0, "despawn_player", player_id)

remote func fetch_skill_damage(skill_name, requester):
	var player_id = get_tree().get_rpc_sender_id()
	var damage = combat_functions.fetch_skill_damage(skill_name)
	rpc_id(player_id, "return_skill_damage", damage, requester)

remote func receive_player_state(player_state):
	var player_id = get_tree().get_rpc_sender_id()
	if player_state_collection.has(player_id):
		if player_state_collection[player_id]["T"] < player_state["T"]:
			player_state_collection[player_id] = player_state
	else:
		player_state_collection[player_id] = player_state
		
func send_world_state(world_state):
	rpc_unreliable_id(0, "receive_world_state", world_state)
