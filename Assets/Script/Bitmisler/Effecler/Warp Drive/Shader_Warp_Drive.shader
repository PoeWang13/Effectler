Shader "Emre/Shader_Warp_Drive"
{
    Properties
    {
        [Header(Base Settings)]
        warpColor("Color", Color) = (1, 1, 1, 1)
        vortexFade("Vortex Fade", Range(1, 2)) = 1

        [Header(Warp Settings)]
        warpSize ("Warp Size", Range(0.0, 0.5)) = 0.1
        warpDepth ("Warp Depth", Range(0, 2)) = 0.3
        warpSpeed ("Warp Speed", Range(0, 5)) = 1
        warpTileX ("Warp Tile X", Range(1, 10)) = 10
        warpTileY ("Warp Tile Y", Range(1, 10)) = 10
    }
    SubShader
    {
        Tags { "Queue" = "Transparent" "RenderType"="Transparent" }
        Blend One One
        Cull Off
        ZWrite Off
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float2 uvMask : TEXCOORD1;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float2 uvMask : TEXCOORD1;
            };
            float4 warpColor;
            float vortexFade;
            float warpSize;
            float warpDepth;
            float warpSpeed;
            float warpTileX;
            float warpTileY;

            float warp_Tex(float2 uv)
            {
                float left_Wall = step(uv.x, warpSize);
                float right_Wall = step(1 - uv.x, warpSize);
                left_Wall += right_Wall;

                float top_Gradient = smoothstep(uv.y, uv.y - warpDepth, 0.5);
                float bottom_Gradient = smoothstep(1 - uv.y, 1 - uv.y - warpDepth, 0.5);
                float cut = clamp(top_Gradient + bottom_Gradient, 0, 1);
                
                return clamp((1 - left_Wall) * (1 - cut), 0, 1);
            }
            float unity_Noise_RandomValue(float2 uv)
            {
                return frac(sin(dot(uv, float2(12.9898, 78.233))) * 43758.5453);
            }
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.uvMask = v.uvMask;
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                i.uv.x *= warpTileX;
                i.uv.y *= warpTileY;
                i.uv.y += (_Time.y * warpSpeed);

                float2 uvFrac = float2(frac(i.uv.x), frac(i.uv.y));
                float2 id = floor(i.uv);

                float x = 0;
                float y = 0;
                fixed4 col = 0;

                for (y = -1; y <= 1; y++)
                {
                    for (x = -1; x <= 1; x++)
                    {
                        float2 offSet = float2(x, y);
                        float noise = unity_Noise_RandomValue(id + offSet);
                        float size = frac(noise * 123.32);
                        float warp  = warp_Tex(uvFrac - offSet - float2(noise, frac(noise * 56.12)));
                        col += warp * size;
                    }
                }
                float newVortexFade = abs(i.uvMask.y - 0.5) * vortexFade;

                return clamp(col - newVortexFade, 0, 1) * warpColor;
            }
            ENDCG
        }
    }
}
