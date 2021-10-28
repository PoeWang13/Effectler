﻿void BlurredColor_float(float4 Seed, float Min, float Max, float BlurX, float BlurY, out float4 Out)
{
	float randomNo = frac(sin(dot(Seed.xy, float2(12.9898, 78.233))) * 43758.5453);
	float noise = lerp(Min, Max, randomNo);
	float uvx = float(sin(noise)) * BlurX;
	float uvy = float(cos(noise)) * BlurY;
	float4 uvPos = float4(Seed.x + uvx, Seed.y + uvy, Seed.zw);
	Out = uvPos;
}