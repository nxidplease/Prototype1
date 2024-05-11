

shader_type canvas_item;
uniform float circle_size = 0.05f;
uniform float circle_speed = 100.0f;

void fragment(){
	float curr_circle_size = circle_size+sin(TIME)/circle_speed;
	if (distance(vec2(0.5,0.5), UV) < curr_circle_size){
		COLOR = vec4(1,1,1,0);
	}
}
