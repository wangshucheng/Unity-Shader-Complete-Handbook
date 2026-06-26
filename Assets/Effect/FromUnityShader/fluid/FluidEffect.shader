Shader "Custom/FluidEffect" {
	Properties{
		_MainTex("Base (RGB)", 2D) = "white" {}
		_MainTint("Diffuse Tint", Color) = (1, 1, 1, 1)
		_ScrollXSpeed("X Scroll Speed", Range(0, 10)) = 2
		_ScrollYSpeed("Y Scroll Speed", Range(0, 10)) = 2
	}
	SubShader{
		Tags{ "RenderType" = "Opaque" }
		LOD 200

	CGPROGRAM
	#pragma target 3.0
#pragma surface surf Standard fullforwardshadows
	half4 _MainTint;
	half _ScrollXSpeed;
	half _ScrollYSpeed;
	sampler2D _MainTex;

	struct Input {
		float2 uv_MainTex;
	};

	void surf(Input IN, inout SurfaceOutput o) {
		half2 scrolledUV = IN.uv_MainTex;
		half xScrollValue = _ScrollXSpeed * _Time;
		half yScrollValue = _ScrollYSpeed * _Time;
		scrolledUV += half2(xScrollValue, yScrollValue);
		half4 c = tex2D(_MainTex, scrolledUV);
		o.Albedo = c.rgb * _MainTint;
		o.Alpha = c.a;
	}
	ENDCG
	}
	FallBack "Diffuse"
}