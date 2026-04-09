extends Node2D

var character_scene = preload("res://src/game/character.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    for player in Players.players:
        var c = character_scene.instantiate()
        c.init(DeviceInput.new(player.device_number))
        add_child(c)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
