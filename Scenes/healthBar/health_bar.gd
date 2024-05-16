class_name HealthBar
extends ColorRect

var health_normalized = 1.0
const MAX_RECT_WIDTH = 22

@export var health_color_gradient: Gradient

@onready var inside_rect = $InsideRect

func set_health_percent(health_normalized: float):
	self.health_normalized = health_normalized
	
	inside_rect.color = health_color_gradient.sample(self.health_normalized)
	inside_rect.size.x = health_normalized * MAX_RECT_WIDTH
