class_name HealthBar
extends ColorRect

var health_percent = 100.0
const MAX_RECT_WIDTH = 22
@onready var inside_rect = $InsideRect

func set_health_percent(health_percent: float):
	self.health_percent = health_percent
	
	inside_rect.size.x = remap(self.health_percent, 0, 100, 0, MAX_RECT_WIDTH)
