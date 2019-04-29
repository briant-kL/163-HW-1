Shader "Custom/OutputTexture"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
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
				float4 vertex : POSITION;
				float2 uv: TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv: TEXCOORD0;
			};

			sampler _MainTex;

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{

				float4 col = tex2D(_MainTex, i.uv);
                //return float4(col.r, col.g, col.b, 1.0);
				//sinc(float x , out s , out c ) 
				//col.r += sin(_Time.y   * 1);
				//col.g += cos(_Time.y * 2);
				//col.b += sin(_Time.y * 2);
				return col;
			}
			
			ENDCG
		}
      
    }
    FallBack "Diffuse"
}
