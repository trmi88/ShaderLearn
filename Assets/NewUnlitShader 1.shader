// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Unlit/NewUnlitShader"
{
    Properties
    {
        _ColorA("Color", Color) = (1,1,1,1)
                _ColorB("Color", Color) = (1,1,1,1)
                _float1("float1", Range(0,1)) = 1

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


            Interpolators vert (MeshData v)
            {
                Interpolators o;

                UNITY_INITIALIZE_OUTPUT(Interpolators, o);

                float4 tempVertex = UnityObjectToClipPos(v.vertex);

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

            float4 frag (Interpolators i) : SV_Target
            {
                // float t = random(i.uv) >_float1? func1(i.uv.x) : func2(i.uv.x);
                //float4 returnColor = lerp(_ColorA,_ColorB,random(i.uv));
                // return float4(func1(i.uv.x), 0 ,0,1);
                //return returnColor;
                //return float4(i.uv,1,1);

//return float4(1,1,0,1);

    float4 objectOrigin = mul(unity_ObjectToWorld, float4(0.0,0.0,0.0,1.0) );
    float dist = distance(objectOrigin, i.fragPos);

if (dist > _float1){
  //  return float4(0.4,0,0,1);
} else {
   // return float4 (0,1,0,1);
}

//black 0 0 0 1
//yellow1 1 0 1
//center 0.5 0.5 0 1

float dist2 = distance(float2(0.5,0.5), i.uv);
const float maxDist = sqrt(2)/2;

    float4 returnColor = lerp(_ColorA,_ColorB,func1(dist2/maxDist));
return returnColor;

return float4(1,0,0,dist2/maxDist);

if (dist2 > _float1){
    return float4(1,0,0,1);
} else {
    return float4 (1,0,0,0);
}

return float4(i.uv,0,1);

return float4(1,0,0,random(i.uv));

                return float4(i.normal,1);

            }
            ENDCG
        }
    }
}
