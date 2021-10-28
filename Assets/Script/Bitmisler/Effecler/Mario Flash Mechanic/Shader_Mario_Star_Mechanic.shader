Shader "Emre/Shader_Mario_Star_Mechanic"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        speed("Color Speed", Range(5, 10)) = 10
        color_Power("Color Power", Range(0, 1)) = 0.5
        [KeywordEnum(Off, On)] IsActive("Is Active", float) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog
            #pragma multi_compile ISACTIVE_OFF ISACTIVE_ON

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
                float3 normal : NORMAL0;
                float3 position_World : TEXCOORD2;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float speed;
            float color_Power;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                o.normal = normalize(mul(unity_ObjectToWorld, float4(v.normal, 0))).xyz;
                o.position_World = mul(unity_ObjectToWorld, v.vertex).xyz;
                return o;
            }

            void Unity_FresnelEffectfloat(float3 Normal, float3 ViewDir, float Power, out float Out)
            {
                Out = pow((1.0 - saturate(dot(normalize(Normal), normalize(ViewDir)))), Power);
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float speedNew = ceil(_Time.y * speed);
                float2 initial_Color = float2(1, 1);
                float3 star_Color = (float3(initial_Color.xyx) + speedNew) + float3(0, 2, 4);
                star_Color = cos(star_Color) * color_Power;
                
                float3 normal_world = i.normal;
                float3 view_dir = normalize(_WorldSpaceCameraPos.xyz - i.position_World.xyz);
                
                float fresnel = 0;
                Unity_FresnelEffectfloat(normal_world, view_dir, 1, fresnel);

                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);

                #if ISACTIVE_ON
                    return col + float4(star_Color, 1) + fresnel;
                #else
                    return col;
                #endif
            }
            ENDCG
        }
    }
}
