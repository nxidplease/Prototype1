extends CharacterBody2D


@export var SPEED = 300.0

@export var MAX_HEALTH = 100.0
@onready var health_bar: HealthBar = $HealthBar

var health = MAX_HEALTH

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var bulletScene = preload("res://Scenes/bullet/bullet.tscn")

@onready var bullet_spawn: Marker2D = $BulletSpawn

var mouseDir: Vector2 = Vector2.ZERO

func _ready():
	#health_bar.text = str(health)
	pass

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX = Input.get_axis("move_left", "move_right")
	var directionY = Input.get_axis("move_up", "move_down")
	
	if directionX || directionY:
		velocity = Vector2(directionX, directionY) * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, velocity.length() * .1)

	move_and_slide()
	
func _input(event):
	if event is InputEventMouseMotion:
		var halfScreenSize = get_viewport().get_visible_rect().size / 2
		var dir = (event.position - halfScreenSize).normalized()
		bullet_spawn.position = dir * (bullet_spawn.position.length())
		mouseDir = dir
	elif Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	var bulletInstance = bulletScene.instantiate() as RigidBody2D
	bulletInstance.position = bullet_spawn.global_position
	bulletInstance.rotation = mouseDir.angle()
	get_tree().current_scene.add_child(bulletInstance)
	
func take_damage(damagePoints: float):
	health -= damagePoints
	
	print("Player percent: %s" % (health/MAX_HEALTH))
	
	health_bar.set_health_percent(health/MAX_HEALTH * 100)
	
	if health <= 0:
		print("You died!")
		get_tree().reload_current_scene()
