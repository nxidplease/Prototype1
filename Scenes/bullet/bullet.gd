extends RigidBody2D

@export var speed: float = 500
@export var damage: float = 12.0
const ENEMY_COLLISISON_LAYER = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	apply_central_impulse(Vector2.from_angle(rotation) * speed)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body: PhysicsBody2D):
	if body.get_collision_layer_value(ENEMY_COLLISISON_LAYER):
		body.take_damage(damage)
		queue_free()
