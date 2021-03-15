Shader "Custom/SurfaceShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        //_Glossiness ("Smoothness", Range(0,1)) = 0.5
        //_Metallic ("Metallic", Range(0,1)) = 0.0

        _Cubemap("Cubemap", CUBE) = ""{}
	    _ReflectionAmount("Reflection Amount", Range(0,1)) = 1
		_RimPower("Fresnel Falloff", Range(0.1, 8)) = 2
		_SpecColor("Specular Color", Color) = (1,1,1,1)
		_SpecPower("Specular Power", Range(0,1)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf BlinnPhong fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        samplerCUBE _Cubemap;
	    sampler2D _MainTex;
	    float _ReflectionAmount;
	    float _RimPower;
	    float _SpecPower;

        struct Input
	    {
		    float2 uv_MainTex;
		    float3 worldRefl;
		    float3 viewDir;
	    };

        //half _Glossiness;
        //half _Metallic;
        fixed4 _Color;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            // Metallic and smoothness come from slider variables
            //o.Metallic = _Metallic;
            //o.Smoothness = _Glossiness;

		    float rim = 1 - saturate(dot(o.Normal, normalize(IN.viewDir)));
		    rim = pow(rim, _RimPower);

		    o.Emission = (texCUBE(_Cubemap, IN.worldRefl).rgb * _ReflectionAmount) * rim;
		    o.Specular = _SpecPower;
		    o.Gloss = 1.0;
		    o.Alpha = c.a;

        }
        ENDCG
    }
    FallBack "Diffuse"
}
