Shader "Custom/SimpleReflection" {
	Properties{
		_MainTex("Base (RGB)", 2D) = "white" {}
	_MainTint("Diffuse Color", Color) = (1, 1, 1, 1)
		_Cubemap("CubeMap", CUBE) = ""{}
	_ReflAmount("Reflection Amount", Range(0.01, 1)) = 0.5
	}
		SubShader{
		Tags{ "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
#pragma target 3.0
#pragma surface surf Standard fullforwardshadows

		sampler2D _MainTex;
	samplerCUBE _Cubemap;
	float4 _MainTint;
	float _ReflAmount;

	struct Input {
		float2 uv_MainTex;
		float3 worldRefl;////worldRefl:即为世界空间的反射向量///内置的worldRefl 来做立方图反射(cubemap         reflection)//为了计算反射
	};

	void surf(Input IN, inout SurfaceOutput o) {
		half4 c = tex2D(_MainTex, IN.uv_MainTex) * _MainTint;
		o.Emission = texCUBE(_Cubemap, IN.worldRefl).rgb * _ReflAmount;
		//	o.Albedo = texCUBE(_Cubemap, IN.worldRefl).rgb * _ReflAmount;//c.rgb;
		o.Albedo = c.rgb;
		o.Alpha = c.a;
	}
	ENDCG
	}
		FallBack "Diffuse"
}
