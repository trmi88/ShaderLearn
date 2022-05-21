// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Unlit/NewUnlitShader"
{
    Properties
    {
        _ColorA("Color", Color) = (1,1,1,1)
                _ColorB("Color", Color) = (1,1,1,1)
                _float1("float1", Range(0,100)) = 1
                _baseRadius("baseRadius", Range(0,1)) = 1
                _elapsedTime("elapsedTime", float) = 0


    }
    SubShader
    {
      //  Tags { "RenderType"="Opaque" }

        // for transparent
         Tags { "Queue"="Transparent" "RenderType"="Transparent" }
         Blend SrcAlpha OneMinusSrcAlpha


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
            };

            struct Interpolators
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0; //mean not the same in MeshData
                float3 normal: TEXCOORD1;
                float4 fragPos : TEXCOORD2;


            };

            float4 _ColorA;
            float4 _ColorB;
            float _float1;
            float _baseRadius;
            float _elapsedTime;


            Interpolators vert (MeshData v)
            {
                Interpolators o;

                UNITY_INITIALIZE_OUTPUT(Interpolators, o);

               // float4 tempVertex = UnityObjectToClipPos(v.vertex);

                o.vertex = UnityObjectToClipPos(v.vertex);

                // o.vertex = float4(tempVertex.xxx,1);
                // o.vertex = float4(tempVertex.x, tempVertex.y, tempVertex.z,1);

                o.normal = UnityObjectToWorldNormal(v.normals);
                o.uv = v.uv0;
                o.fragPos = mul (UNITY_MATRIX_MV, v.vertex);

               // o.uv = v.uv1;

                return o;
            }

             float random (float2 uv)
            {
                return frac(sin(dot(uv,float2(12.9898,78.233)))*43758.5453123);
            }

            float func1(float f)
            {
                return frac(abs(sin(2*f)-cos(f)));
            }

                float func2(float f)
            {
                return frac(abs(f*f*f - 3*f*f + 9*f + 0.5));
            }

            // spiral
                float func3(float f)
             {
                 return frac(5 * f * cos(f * 2 * PI));
             }

            float4 frag (Interpolators i) : SV_Target
            {
                
               // return float4(0,0,1,1);

               // return float4(i.uv.yyy,1);
               //sang phai:x 0 > 1, len tren x giu nguyen
               //sang phai:y giu nguyen, len tren y 0 > 1

                float2 center = float2(0.5,0.5);

                //center 0.5 0.5

                //calculate angle between center and i.uv
                float angle = atan2(i.uv.y - center.y, i.uv.x - center.x);
                float dist = distance(center, i.uv);

                const float maxDist = sqrt(2)/2;
                const float duration = 5;

                //radius continuous update based on factor, choose factor depend on distance
                //approach nay KHONG tao spiral vi factor = nhau giua cac diem doi xung > nen van la doi xung
             //   float factor = dist;
             //   float maxFactor = dist/maxDist;
             //   float rContinuous = _baseRadius * (1 + factor/maxFactor) ;

                //approach 2: rContinuous ~ based on time, not distance > van bi doi xung vi 2 diem doi xung van co t bang nhau
                //spiral khong doi xung

                float rContinuous = _baseRadius * cos(_elapsedTime * _float1 / 100 + 0.05)  ;

                float t = frac(dist / rContinuous);

                float4 returnColor = lerp(_ColorA,_ColorB,t);
                return returnColor;

            }
            ENDCG
        }
    }
}
