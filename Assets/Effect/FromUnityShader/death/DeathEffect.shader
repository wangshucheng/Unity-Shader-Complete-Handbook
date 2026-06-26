Shader "Custom/DeathEffect" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_LuminosityAmount ("GrayScale Amount", Range(0.0, 1.0)) = 1.0
	}
	SubShader {
		Pass {
			CGPROGRAM
			#pragma target 3.0
#pragma vertex vert_img
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			
			uniform sampler2D _MainTex;
			half _LuminosityAmount;
			
			half4 frag(v2f_img i) : COLOR
			{
				//Get the colors from the RenderTexture and the uv's
				//from the v2f_img struct
				half4 renderTex = tex2D(_MainTex, i.uv);
				
				//Apply the Luminosity values to our render texture
				float luminosity = 0.299 * renderTex.r + 0.587 * renderTex.g + 0.114 * renderTex.b;
				half4 finalColor = lerp(renderTex, luminosity, _LuminosityAmount);
				
				return finalColor;
			}
			
			ENDCG
		}
	}
	FallBack "Diffuse"
}
