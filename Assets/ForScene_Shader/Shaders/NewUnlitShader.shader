Shader "Unlit/NewUnlitShader"
{
    Properties
    {
        _ColorA("Color", Color) = (1,1,1,1)
        _MainTex ("Example (R16)", 2D) = "black" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            #define PI 3.1415926

            struct MeshData
            {
                float4 vertex : POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float3 normals: NORMAL;

                float4 color : COLOR;
            };

            struct Interpolators
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0; //mean not the same in MeshData
                float3 normal: TEXCOORD1;

                float4 color : COLOR;
            };

            float4 _Color;



            Interpolators vert (MeshData v)
            {
                Interpolators o;
                UNITY_INITIALIZE_OUTPUT(Interpolators, o);

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normals);

              //  o.normal = v.normals;
                o.uv = v.uv0;


                o.color = v.color;

                return o;
            }
            
            // Utils 
             float random (float2 uv)
            {
                return frac(sin(dot(uv,float2(12.9898,78.233)))*43758.5453123);
            }


            float4 frag (Interpolators i) : SV_Target
            {

                //return i.color;

            
                

                return float4(i.uv,0,1);

                float4 color1 = 0;
                color1.rgb = i.normal;
                return color1;

                return float4(i.uv,0,1);

                return float4(i.normal,1);

                float f = i.uv;
                float s = frac(5 * f * cos(f * 2 * PI));
                return s;
            }

            ENDCG
        }
    }
}
