extends Sprite2D

@export var circleSize:float = 0.05
@export var circleSpeed:float = 100.0

var shader_mat : ShaderMaterial

func _ready():
	shader_mat = material
	material.set_shader_parameter("circle_size",circleSize)
	material.set_shader_parameter("circle_speed",circleSpeed)

func _process(delta):
	pass
		
