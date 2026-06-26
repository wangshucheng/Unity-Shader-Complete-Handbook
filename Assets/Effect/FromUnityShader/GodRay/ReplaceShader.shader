Shader "ZHH/ReplaceShader" 
{
	Properties 
	{
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
			
			// BindChannels removed (deprecated in Unity 5+)
			
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
			
			// BindChannels removed (deprecated in Unity 5+)
			
			Color [_Color]
			//SetTexture [_MainTex] { combine texture * primary }
		}
	}
}
