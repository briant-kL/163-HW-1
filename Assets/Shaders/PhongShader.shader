Shader "CMPM163/HW1/PhongShader"
{
	Properties
	{
		_Color("Tint", Color) = (0,0,0,0)
		_SpecularColor("Specular", Color) = (1,1,1,1)
		_Shininess("Shininess", float) = 1.0
		_MainTex("Texture", 2D) = "white" {}
	}
		SubShader
	{

		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag


			#include "UnityCG.cginc"

			//Based off 
			//http://partlyshaderly.com/2019/02/07/a-little-about-phong-shading/


			struct appdata
			{
				float4 pos : POSITION;
				float2 uv : TEXCOORD0;
				float3 normal : NORMAL;

			};

			struct v2f
			{

				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
				float3 normal : NORMAL;
				float3 posWorldCoords: TEXCOORD1;
			};

			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;

			uniform float4 _Color;
			uniform float4 _SpecularColor;
			uniform float _Shininess;


			float4 _LightColor0;

			v2f vert(appdata v)
			{
				v2f o;
				o.posWorldCoords = mul(unity_ObjectToWorld, v.pos);

				o.pos = UnityObjectToClipPos(v.pos);
				o.normal = v.normal;
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				//ambient material
				float3 Ka = float3 (1, 1, 1);
				//global light Specular
				float3 globalAmbient = float3(0.2, 0.2, 0.2);
				float3 ambientComp = Ka * globalAmbient;

				//position of object in world space
				float3 P = i.posWorldCoords.xyz;

				//surface normal
				float3 N = normalize(i.normal);
				//light vector
				float3 L = normalize(_WorldSpaceLightPos0.xyz - P);

				//diffuse material
				float3 Kd = _Color.rgb;
				float3 lightColor = _LightColor0.rgb;
				float3 diffuseComp = Kd * lightColor * max(dot(N, L), 0);

				//Specular material and Shininess
				float3 Ks = _SpecularColor.rgb;
				float3 V = normalize(_WorldSpaceCameraPos - P);
				float3 H = normalize(L + V);
				float3 specularComp = Ks * lightColor * pow(max(dot(N, H), 0), _Shininess);





				//fixed4 col = tex2D(_MainTex, i.uv);
				float3 col = ambientComp + diffuseComp + specularComp;
				//col = float4(col, 1.0) * tex2D(_MainTex, i.uv);

				return float4(col, 1.0);

			}
			ENDCG
		}
	}
}
