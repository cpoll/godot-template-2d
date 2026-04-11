// https://www.shadertoy.com/view/wt2GRt
shader_type canvas_item;

uniform float zoom = 10.0;
uniform float speed = 0.3;
uniform float bright = 5.0;

void fragment()
{
	// uncoment when using real texture
	//vec4 texture_color = texture(TEXTURE, UV);
	vec4 texture_color = vec4(0.192156862745098, 0.6627450980392157, 0.9333333333333333, 1.0);

	vec4 k = vec4(TIME)*speed;
	k.xy = UV * zoom;
	float val1 = length(0.5-fract(k.xyw*=mat3(vec3(-2.0,-1.0,0.0), vec3(3.0,-1.0,1.0), vec3(1.0,-1.0,-1.0))*0.5));
	float val2 = length(0.5-fract(k.xyw*=mat3(vec3(-2.0,-1.0,0.0), vec3(3.0,-1.0,1.0), vec3(1.0,-1.0,-1.0))*0.2));
	float val3 = length(0.5-fract(k.xyw*=mat3(vec3(-2.0,-1.0,0.0), vec3(3.0,-1.0,1.0), vec3(1.0,-1.0,-1.0))*0.5));
	COLOR = vec4 (pow(min(min(val1,val2),val3), 7.0) * bright)+texture_color;
}