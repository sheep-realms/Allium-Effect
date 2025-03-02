#version 150

#moj_import <minecraft:fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec2 texCoord0;
in vec4 vertexColor;

in float data;
in vec4 overrideColor;

out vec4 fragColor;

void main() {
    vec4 mulColor = vertexColor;
    if (data > 0) {
        mulColor = 1.0 / data * overrideColor;
    }

    vec4 color = texture(Sampler0, texCoord0) * mulColor * ColorModulator;
    if (color.a < 0.1) {
        discard;
    }
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}

