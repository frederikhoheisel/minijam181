shader_type canvas_item;

instance uniform bool should_be_colorless = false;

const float RED_LUMINANCE = 0.2126;
const float GREEN_LUMINANCE = 0.7152;
const float BLUE_LUMINANCE = 0.0722;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 col = COLOR;
	// Called for every pixel the material is visible on.
	if(should_be_colorless) {
		float luminance = (col.r*RED_LUMINANCE + col.g*GREEN_LUMINANCE + col.b*BLUE_LUMINANCE);
		col = vec4(vec3(luminance), .5 * col.a);
	}

	COLOR = col;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
