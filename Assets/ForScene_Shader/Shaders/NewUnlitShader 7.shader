Shader "Unlit/NewUnlitShader 7"
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

            #define PI 3.1415926



            struct Interpolators
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0; //mean not the same in MeshData

            };

            float4 _Color;


            Interpolators vert (appdata_img v)
            {
                Interpolators o;
                UNITY_INITIALIZE_OUTPUT(Interpolators, o);

                o.vertex = UnityObjectToClipPos(v.vertex);

                o.uv = v.texcoord;



                return o;
            }
     

            float4 frag (Interpolators i) : SV_Target
            {

                if (i.uv.x > 0.5){
                    return float4(i.uv,0,1);

                } else {
                    return float4(1,0,0,1);
                }

               // return float4(i.uv,0,1);

 
            }

            ENDCG
        }
    }
}
