extends Node2D
@export var player: CharacterBody2D
var light = preload("res://Scenes/torch.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("SpwanTorch")):
		var lightInstance = light.instantiate()
		lightInstance.global_position = player.global_position
		get_tree().current_scene.add_child(lightInstance)		
