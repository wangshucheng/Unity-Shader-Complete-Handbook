Shader "Custom/SpriteEffect" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_TexWidth ("Sheet Width", float) = 0.0
		_CellAmount ("Cell Amount", float) = 0.0//有几个画面
		_Speed ("Speed", Range(0.01, 32)) = 12
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
 
			CGPROGRAM
#pragma target 3.0
#pragma surface surf Standard fullforwardshadows
			float _TexWidth;
		float _CellAmount;
		float _Speed;
 
		sampler2D _MainTex;
 
 
		struct Input {
			float2 uv_MainTex;
		};
 
		void surf (Input IN, inout SurfaceOutput o) {
 
			float2 spriteUV = IN.uv_MainTex;
			float cellPixelWidth = _TexWidth/_CellAmount;//一个小画面的宽度
			float cellUVPercentage = cellPixelWidth/_TexWidth;//小画面占大画面比率，个数越少比率越大 1/8
			float timeVal = fmod(_Time.y * _Speed, _CellAmount); //0-7
			timeVal = ceil(timeVal);//向上取整，得到一个小于CellAmount的整数 1-8
			float xValue = spriteUV.x;			
			xValue += timeVal;//
			xValue *= cellUVPercentage;//对uv进行缩放
			spriteUV = float2(xValue, spriteUV.y);
			half4 c = tex2D (_MainTex, spriteUV);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
