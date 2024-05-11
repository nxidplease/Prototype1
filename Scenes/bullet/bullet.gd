extends RigidBody2D

@export var speed: float = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	apply_central_impulse(Vector2.from_angle(rotation) * speed)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
