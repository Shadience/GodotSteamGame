extends Node3D

var captured = true;

var steam_id = 0
var peer := SteamMultiplayerPeer.new()
@onready var spawner: MultiplayerSpawner = $MultiplayerSpawner


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	steam_id = Steam.getSteamID()
	Steam.lobby_created.connect(lc)
	Steam.lobby_joined.connect(lj)
	spawner.spawn_function = _spawn_player
	
	if Steam.getPersonaName() == "абдвг1848":
		Steam.createLobby(Steam.LOBBY_TYPE_PUBLIC, 4)
		peer.create_host()
	else:
		peer.create_client(steam_id)
	multiplayer.multiplayer_peer = peer

func lc(connec, lobby_id):
	Steam.allowP2PPacketRelay(true)

func lj(lobby, perms, locked, resp):
	spawner.spawn(steam_id)
	set_multiplayer_authority(steam_id, true)
	print("PRIKOL")

func _spawn_player(id):
	var p = load(spawner.get_spawnable_scene(0)).instantiate()
	p.set_multiplayer_authority(id)
	return p

func _unhandled_input(event: InputEvent):
	if event.is_pressed():
		if Input.is_key_pressed(KEY_ESCAPE):
			if captured:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				captured = !captured
			else:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				captured = !captured
