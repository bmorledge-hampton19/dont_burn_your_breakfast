shader_type canvas_item;
uniform float maxLightening = 0.6;

void fragment() {
	float centeredYPos = UV.y-0.5;
	vec3 differenceFromWhite = vec3(1.0) - COLOR.rgb;
	float lightening = smoothstep(0, 0.5, abs(centeredYPos)) * maxLightening;
	COLOR.rgb += differenceFromWhite*lightening;
}
