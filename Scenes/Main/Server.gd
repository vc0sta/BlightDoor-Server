extends Node


var network = NetworkedMultiplayerENet.new()
var port = 1909
var max_players = 3

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
	
func _Peer_Disconnected(player_id):
	print("User " + str(player_id) + " disconnected")

remote func fetch_skill_damage(skill_name, requester):
	var player_id = get_tree().get_rpc_sender_id()
	var damage = Combat.fetch_skill_damage(skill_name)
	rpc_id(player_id, "return_skill_damage", damage, requester)
	print(str(damage) + " -> " + str(player_id))
