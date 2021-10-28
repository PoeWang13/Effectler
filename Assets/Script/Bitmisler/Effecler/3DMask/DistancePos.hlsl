void DistancePos_half(in float3 PlayerPos, in float3 WorldPos, in float Radius, in float3 PrimaryTexture, in float3 SeconderyTexture, out float3 Out)
{
	if (distance(PlayerPos.xyz, WorldPos.xyz) > Radius)
	{
		Out = PrimaryTexture;
	}
	else if (distance(PlayerPos.xyz, WorldPos.xyz) > Radius - 0.2)
	{
		Out = float4(1, 1, 1, 1);
	}
	else
	{
		Out = SeconderyTexture;
	}
}