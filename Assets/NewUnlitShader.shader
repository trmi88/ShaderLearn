Shader "Unlit/NewUnlitShader"
{
    Properties
    {
        _ColorA("Color", Color) = (1,1,1,1)
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

            struct MeshData
            {
                float4 vertex : POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                   float3 normals: NORMAL;
            };

            struct Interpolators
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0; //mean not the same in MeshData
                float3 normal: TEXCOORD1;

            };

            float4 _Color;


            Interpolators vert (MeshData v)
            {
                Interpolators o;

                UNITY_INITIALIZE_OUTPUT(Interpolators, o);
                
                
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normals);
                o.uv = v.uv0;
                // o.uv = v.uv1;

                return o;
            }

             float random (float2 uv)
            {
                return frac(sin(dot(uv,float2(12.9898,78.233)))*43758.5453123);
            }

            float4 frag (Interpolators i) : SV_Target
            {
                // return float4(i.normal.xxx,1); //normal la ve huong anh sang
                // return float4(i.uv.xy, i.uv.x*2,1); //uv = UV mapping is the process of projecting a 2D image onto the mesh of a 3D object to give it shape, detail and texture
                //UV mapping = which texture for Mesh = UV coordinates =  texture coordinates
                // float r = 
                // return float4(i.uv,0,1);
                float r = random(i.uv);
                return float4(i.uv.xxx,1);
            }
            ENDCG
        }
    }
}
