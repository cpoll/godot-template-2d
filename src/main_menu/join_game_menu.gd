extends Control

# This menu handles all inputs by looping through joined/unjoined devices.
# When start() is called, it populates the Players global and changes scenes.

class Device extends RefCounted:
    var device_id = null
    var device_name = ""

# Joined devices; their position in the array corresponds with P1-P4
var joined_devices = [
    Device.new(),
    Device.new(),
    Device.new(),
    Device.new()
]
var countdown = null

@onready var center_label = %CenterLabel
@onready var p1_label = $Layout/P1P2/P1/PData
@onready var p2_label = $Layout/P1P2/P2/PData
@onready var p3_label = $Layout/P3P4/P3/PData
@onready var p4_label = $Layout/P3P4/P4/PData
var p_labels


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    p_labels = [p1_label, p2_label, p3_label, p4_label]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    handle_input()
    update_ui()
    
    if countdown != null:
        countdown -= delta
        if countdown <= 0:
            start_game()

func handle_input():
    var devices = Input.get_connected_joypads()
    var unjoined_devices = devices.filter(func(d): return d not in joined_devices.map(func(d): return d.device_id))

    # Handle unjoined device input
    for device in unjoined_devices:
        if MultiplayerInput.is_action_just_pressed(device, "Confirm"):
            # Unjoined device wants to join
            
            var first_empty_player_slot = joined_devices.find_custom(func(d): return d.device_id == null)
            if first_empty_player_slot > -1:
                joined_devices[first_empty_player_slot].device_id = device
                joined_devices[first_empty_player_slot].device_name = Input.get_joy_name(device) # TODO: This isn't working. get_joy_info doesn't give much either
    
    # Handle joined device input
    for i in joined_devices.size():
        var device = joined_devices[i].device_id
        if device == null:
            continue
            
        if MultiplayerInput.is_action_just_pressed(device, "Back"):
            joined_devices[i].device_id = null
            joined_devices[i].device_name = ""
            stop_countdown()
        elif MultiplayerInput.is_action_just_pressed(device, "Start"):
            start_countdown()

func start_countdown():
    countdown = 5
    
func stop_countdown():
    countdown = null
    
func start_game():
    # TODO: Add players/devices to Players
    print("start game")
    pass
    
func update_ui():
    for i in joined_devices.size():
        if joined_devices[i].device_id == null:
            p_labels[i].text = "Press Confirm to Join"
        else:
            p_labels[i].text = "Joined!" + joined_devices[i].device_name
        
    if countdown != null:
        center_label.text = str(int(ceil(countdown)))
    else:
        # TODO: Change the label depending on whether 2+ players have joined
        center_label.text = "Press any key to join"
        
        
