Shader "CMPM163/HW1/Simple_Vertex_Displacement"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_Color("Tint", Color) = (1,1,1,1)
		_Amplitude("amplitude", Range(0,1)) = 0.033
		_Frequency("frequency", Range(0,1)) = 0.033
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
			uniform float _Amplitude;
			uniform float _Frequency;
			float4 _MainTex_ST;


			v2f vert(appdata v)
			{
				v2f o;
				//v.pos.x += sin(_Time.y * )
				o.pos = UnityObjectToClipPos(v.pos);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				o.pos.x += sin(_Time.y * _Frequency + o.pos.y * 5 * _Amplitude);
				return o;


			}

			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				col *= _Color;
				return col;
			}

            ENDCG
        }
    }
}
