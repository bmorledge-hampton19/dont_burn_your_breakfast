shader_type canvas_item;
uniform float buriedDepth = 0.0;

void fragment() {
	COLOR.rgb *= 1.0-(0.2*buriedDepth);
}
