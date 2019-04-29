Shader "CMPM163/HW1/Simple_Unlit_Texture"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
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
			float4 _MainTex_ST;


			v2f vert(appdata v) 
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.pos);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;


			}

			fixed4 frag (v2f i ) : SV_Target
			{
				fixed4 col = _Color * tex2D(_MainTex, i.uv);
				
				return col;
			}




            ENDCG
        }
    }
}
