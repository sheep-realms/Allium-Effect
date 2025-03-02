#version 150

#moj_import <minecraft:fog.glsl>

in vec3 Position;
in vec2 UV0;
in vec4 Color;
in ivec2 UV2;

uniform sampler2D Sampler0;
uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform int FogShape;

out float vertexDistance;
out vec2 texCoord0;
out vec4 vertexColor;

out vec4 overrideColor;
out float data;

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
    
    vec4 override = texture(Sampler0, UV0);
    if (override == vec4(11.0 / 255.0, 45.0 / 255.0, 14.0 / 255.0, 0.0) && Color.x > 0.0 && Color.z == 0.0 && Color.y <= 50.0 / 255.0) {
	    data = 1.0;
        overrideColor = Color.x * vec4(0.779, 0.509, 1.0, 1.0) * texelFetch(Sampler2, UV2 / 16, 0);
    }else {
        data = 0.0;
	    overrideColor = vec4(0.0, 0.0, 0.0, 0.0);
    }

    vertexDistance = fog_distance(Position, FogShape);
    texCoord0 = UV0;
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
}

