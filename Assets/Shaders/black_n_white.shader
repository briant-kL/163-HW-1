Shader "Custom/black_n_white"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_Color("Tint", Color) = (1,1,1,1)
		_Edge("Edge Threshold", Range(0,1)) = 1
	}
		SubShader
		{

			Pass
			{
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag


				#include "UnityCG.cginc"

				struct appdata
				{
					float4 pos : POSITION;
					float2 uv : TEXCOORD0;
				};

				struct v2f
				{
					float4 pos : SV_POSITION;
					float2 uv : TEXCOORD0;

				};


				uniform sampler2D _MainTex;
				uniform float4 _Color;
				uniform float _Edge;
				float4 _MainTex_ST;


				v2f vert(appdata v)
				{
					v2f o;
					o.pos = UnityObjectToClipPos(v.pos);
					o.uv = TRANSFORM_TEX(v.uv, _MainTex);
					return o;


				}

				fixed4 frag(v2f i) : SV_Target
				{
					//fixed4 col = _Color * tex2D(_MainTex, i.uv);
					
					fixed4 orgCol = tex2D(_MainTex, i.uv);
					float avg = (orgCol.r + orgCol.g + orgCol.b) / 3.0;
					fixed4 col = fixed4(avg, avg, avg, 1);

					if (col.r < _Edge) {
						col.r = 1.0;
					}
					else col.r = 0.0;

					if (col.g < _Edge) {
						col.g = 1.0;
					}
					else col.g = 0.0;


					if (col.b < _Edge) {
						col.b = 1.0;
					}
					else col.b = 0.0;
					


					
					return col;
				}




				ENDCG
			}
		}
}
