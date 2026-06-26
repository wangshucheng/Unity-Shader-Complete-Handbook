// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "ZHH/Blend" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "" {}
		//_GodRayTex ("God (RGB)", 2D) = ""{}
		Alpha ("Alpha", Float) = 1
	}
	
	
	
	// Shader code pasted into all further CGPROGRAM blocks
	CGINCLUDE
	
	#include "UnityCG.cginc"

	struct v2in {
		float4 vertex : POSITION;
		float2 texcoord  : TEXCOORD0;
	};
	
	struct v2f {
		float4 pos : POSITION;
		float2 uv  : TEXCOORD0;
	};
	
	sampler2D _MainTex;
	
	sampler2D _GodRayTex;
	
	uniform float Alpha;

	v2f vert( v2in v ) 
	{
		v2f o;
		o.pos = UnityObjectToClipPos(v.vertex);
		o.uv = v.texcoord;
		return o;
	} 
 	

	
	half4 frag(v2f i) : COLOR
	{
	  half4 color = tex2D(_MainTex, i.uv) + tex2D(_GodRayTex, i.uv)*Alpha;
	  //half4 color = tex2D(_MainTex, i.uv);

	  return color;
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