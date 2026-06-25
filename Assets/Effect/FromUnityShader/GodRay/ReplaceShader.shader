Shader "ZHH/ReplaceShader" 
{
	Properties 
	{
		_MainTex ("base", 2D) = "white" {}
		_ColorBack ("Main Color", Color) = (0,1,1,1)
		_Color ("Replace Color", Color) = (0,1,1,1)
	}

	SubShader
	{	
		Lighting Off Fog { Mode Off }

		Tags { "GodRayEffect"="BlackBack" "Queue"="Geometry"}
		Pass
		{
			Lighting OFF
			
			BindChannels 
			{
				Bind "Vertex", vertex
				Bind "texcoord", texcoord0
				Bind "texcoord1", texcoord1
			}
			
			Color [_ColorBack]
		}
	}

	SubShader 
	{	
		Lighting Off Fog { Mode Off }

		Tags { "GodRayEffect"="ColorBack" "Queue"="Geometry"}
		Pass
		{

			
			Lighting OFF
			
			BindChannels 
			{
				Bind "Vertex", vertex
				Bind "texcoord", texcoord0
				Bind "texcoord1", texcoord1
			}
			
			Color [_Color]
			//SetTexture [_MainTex] { combine texture * primary }
		}
	}
}
