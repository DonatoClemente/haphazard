shader_type canvas_item;

uniform float time;
uniform float glitch_intensity : hint_range(0, 1) = 0.2;
uniform vec3 glow_color = vec3(0.0, 1.0, 1.0); // Fallback without hint


float random(vec2 coord) {
    return fract(sin(dot(coord, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
    vec2 uv = UV;

    // Add horizontal glitch lines
    float glitch_line = step(0.98, random(vec2(floor(uv.y * 50.0), time * 5.0)));
    float glitch_shift = random(vec2(uv.y * 10.0, time)) * glitch_intensity;

    // Shift horizontal sections randomly
    uv.x += glitch_line * glitch_shift;

    // Vertical distortion (less frequent)
    if (random(vec2(time, uv.y * 100.0)) < 0.1) {
        uv.y += glitch_intensity * random(vec2(time, uv.x * 10.0));
    }

    // Apply color and glow
    vec4 tex_color = texture(TEXTURE, uv);
    tex_color.rgb += glow_color * glitch_line; // Add glow
    COLOR = tex_color;
}
