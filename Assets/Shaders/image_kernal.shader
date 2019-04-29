Shader "CMPM163/HW1/image_kernel"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_Color("Tint", Color) = (1,1,1,1)
		_Blur("Blur Threshold", Range(0,.1)) = .02
		_StandardDev("Standard Deviation", Range(0,0.1)) = 0.1

	}
		SubShader
		{


			Pass
			{
				CGPROGRAM


				///gaussian blur formula taken from
				///https://www.ronja-tutorials.com/2018/08/27/postprocessing-blur.html
				///float gauss = (1 / sqrt(2*PI*standardDevSQRD)) * pow(E, -((offset*offset)/(2*standardDevSQRD)));
				#pragma vertex vert
				#pragma fragment frag
				#define pi 3.14159
				#define E 2.7182
				#define samples 10

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


				sampler2D _MainTex;
				uniform float4 _Color;
				uniform float _Blur;
				uniform float4 _MainTex_ST;
				uniform float _StandardDev;

				v2f vert(appdata v)
				{
					v2f o;
					o.pos = UnityObjectToClipPos(v.pos);
					//o.uv = TRANSFORM_TEX(v.uv, _MainTex);
					o.uv = v.uv;
					return o;


				}

				float sum = 0;


				fixed4 frag(v2f i) : SV_Target
				{
					float4 col = tex2D(_MainTex, i.uv);


					for(float index = 0; index < samples; index++)
					{
						float offset = (index / (samples - 1) - 0.5) * _Blur;
						float2 uv = i.uv + float2(0, offset);

						float standardDevSQRD = _StandardDev * _StandardDev;
						float gauss = (1 / sqrt(2 * pi *standardDevSQRD)) * pow(E, -((offset*offset) / (2 * standardDevSQRD)));

						sum += gauss;

						col += tex2D(_MainTex, uv) * gauss;
					}
					
					

					col = col / sum;
					return col;
				}




				ENDCG
			}
		}
}
