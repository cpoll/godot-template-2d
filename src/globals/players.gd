extends Node

var players = []

class Player extends RefCounted:
    var device_number = 10
    var player_number = 10
    
    func _init(device_number: int) -> void:
        self.device_number = device_number
        
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

# TODO: Manage joined players across scenes.
# join_game_menu adds/removes players, this singleton won't handle itself
# game loop loops through players and gets each player's device?
# Alternatively, use this class to get the device and pass it to the player we instantiate

func add_player(device_number: int) -> void:
    players.append(Player.new(device_number))
    
func remove_player(player_number: int) -> void:
    pass
    
