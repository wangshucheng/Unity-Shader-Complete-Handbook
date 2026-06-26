// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "ZHH/GodRay" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "" {}
		ScreenLightPos ("ScreenLightPos", Vector) = (0,0,0,0)
		Density ("Density", Float) = 0.01
		Decay ("Decay", Float) = 0.5
		Exposure ("Exposure", Float) = 0.5
	}
	
	
	
	// Shader code pasted into all further CGPROGRAM blocks
	CGINCLUDE
	
	#include "UnityCG.cginc"
	#define NUM_SAMPLES 8
	struct v2in {
		float4 vertex : POSITION;
		float2 texcoord  : TEXCOORD0;
	};
	
	struct v2f {
		float4 pos : POSITION;
		float2 uv  : TEXCOORD0;
	};
	
	sampler2D _MainTex;
	
	uniform float4 ScreenLightPos;
	
	uniform float Density;
	
	uniform float Decay;
	
	uniform float Exposure;

	v2f vert( v2in v ) 
	{
		v2f o;
		o.pos = UnityObjectToClipPos(v.vertex);
		o.uv = v.texcoord;
		return o;
	} 
 	
//  	half4 frag(v2f i) : COLOR 
//  	{
//          float4 tex = tex2D(_MainTex, i.uv);
//          return tex;
//  	}
	
	half4 frag(v2f i) : COLOR
	{
	
	  half2 texCoord = i.uv;
	  half2 deltaTexCoord = texCoord - ScreenLightPos.xy;
      deltaTexCoord *= 1.0f / NUM_SAMPLES * Density;
	  half4 color = tex2D(_MainTex, i.uv);
	  half illuminationDecay = 1.0f;
	  for (int i = 0; i < NUM_SAMPLES; i++)
	  {
		texCoord -= deltaTexCoord;

		half4 sample = tex2D(_MainTex, texCoord);

		sample *= illuminationDecay;
		
		color += sample;

		illuminationDecay *= Decay;
	  }
	  
	  color /= NUM_SAMPLES;
	  
	  return half4( color.xyz * Exposure, 1);
	}
	
	ENDCG 
	
Subshader {
 
    Tags { "Queue" = "Transparent" }

 Pass {
	  ZWrite Off
	  
	  			// BindChannels removed (deprecated in Unity 5+)
	  
	  Fog { Mode off }      
      CGPROGRAM
      #pragma target 3.0
#pragma fragmentoption ARB_precision_hint_fastest 
      #pragma vertex vert
      #pragma fragment frag
      ENDCG
  }
  
}

Fallback off
	
} // shader