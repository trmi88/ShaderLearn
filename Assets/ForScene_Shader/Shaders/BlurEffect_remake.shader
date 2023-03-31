Shader "Unlit/BlurEffect_remake"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
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
            };

            struct Interpolators
            {
		        float4 vertex : SV_POSITION;
		        float2 uv : TEXCOORD0;
		        float2 taps[4] : TEXCOORD1; 
            };

	        sampler2D _MainTex;
	        float4 _MainTex_TexelSize; //Vector4(1 / width, 1 / height, width, height) x MainTex sampler dimension
	        float4 _BlurOffsets; //assign in BlitMultitap

	        Interpolators vert(MeshData v) {
		        Interpolators o; 
		        o.vertex = UnityObjectToClipPos(v.vertex);
		        o.uv = v.uv0 - _BlurOffsets.xy * _MainTex_TexelSize.xy;
		        o.taps[0] = o.uv + _MainTex_TexelSize * _BlurOffsets.xy;
		        o.taps[1] = o.uv - _MainTex_TexelSize * _BlurOffsets.xy;
		        o.taps[2] = o.uv + _MainTex_TexelSize * _BlurOffsets.xy * float2(1,-1);
		        o.taps[3] = o.uv - _MainTex_TexelSize * _BlurOffsets.xy * float2(1,-1);
		        return o;
	        }

	        float4 frag(Interpolators i) : SV_Target {
		        float4 color = tex2D(_MainTex, i.taps[0]);
		        color += tex2D(_MainTex, i.taps[1]);
		        color += tex2D(_MainTex, i.taps[2]);
		        color += tex2D(_MainTex, i.taps[3]); 
		        return color * 0.25;
	        }
            ENDCG
        }
    }
}
