shader_type canvas_item;
uniform float buriedDepth = 0.0;
uniform float darkeningPerDepth = 0.2;

void fragment() {
	COLOR.rgb *= 1.0-(darkeningPerDepth*buriedDepth);
}
