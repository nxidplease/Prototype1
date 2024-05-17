extends CharacterBody2D

const speed = 200

const PLAYER_PHYSICS_LAYER = 2

@export var player: Node2D
@export var MAX_HEALTH = 100.0
@export var ATTACK_COOLDOWN_SECONDS = .5
@export var ATTACK_DAMAGE = 10
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var health_bar: HealthBar = $HealthBar

signal bug_died(bug_position: Vector2)

var health = MAX_HEALTH
var last_attack_millis

func _ready():
	last_attack_millis = Time.get_ticks_msec()
	

func _physics_process(delta: float) -> void:
		
	makepath()
	
	if nav_agent.is_navigation_finished():
		velocity = (player.position - position).normalized() * speed
	else:
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = dir * speed
		
	
	if move_and_slide():
		for i in get_slide_collision_count():
			var col = get_slide_collision(i)
			var collider = col.get_collider()
			
			if collider is CollisionObject2D && collider.get_collision_layer_value(PLAYER_PHYSICS_LAYER):
				var now = Time.get_ticks_msec()
				
				if now - last_attack_millis < ATTACK_COOLDOWN_SECONDS * 1000:
					continue
				
				last_attack_millis = Time.get_ticks_msec()
				collider.take_damage(ATTACK_DAMAGE)
	

func makepath() -> void:
	nav_agent.target_position = player.global_position

func _on_timer_timeout():
	makepath()

func take_damage(damagePoints: float):
	health -= damagePoints

	health_bar.set_health_percent(health / MAX_HEALTH)
	
	if health <= 0:
		bug_died.emit(global_position)
		queue_free()
