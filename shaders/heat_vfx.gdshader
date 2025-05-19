shader_type canvas_item;
uniform float minAlpha = 0.1;
uniform float maxAlpha = 0.8;

void fragment() {
	COLOR.a *= mix(minAlpha,maxAlpha,UV.y);
}
