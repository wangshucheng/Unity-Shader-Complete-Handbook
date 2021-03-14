Shader "MyShader/tuqiShader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Length("Length", Range(0.01, 10)) = 0.02
		_AppendLength("AppendLength",Range(0,0.05)) = 0.01
		_CustomColor("CustomColor",COLOR) = (1,1,1,1)
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100
 
		Pass
		{
			Cull Off
			CGPROGRAM

			#pragma target 4.0
			#pragma vertex vert
			#pragma fragment frag
			#pragma geometry geom
			
			#include "UnityCG.cginc"
 
			struct a2v
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float3 normal : NORMAL;
			};
 
			struct v2g
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};
 
			struct g2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};
 
			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _Length;
			float _AppendLength;
			fixed4 _CustomColor;

			//添加顶点
			void ADD_VERT(float3 v, g2f o, inout TriangleStream<g2f> tristream)
			{
				o.vertex = UnityObjectToClipPos(v);
				tristream.Append(o);
			}

			//添加应用三角面
			void ADD_TRI(float3 p0,float3 p1,float3 p2,g2f o,inout TriangleStream<g2f> tristream)
			{
				ADD_VERT(p0,o,tristream);
				ADD_VERT(p1,o,tristream);
				ADD_VERT(p2,o,tristream);
				tristream.RestartStrip();
			}

      
			v2g vert(appdata_base v)
			{
				v2g o;
				o.vertex = v.vertex;
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				return o;
			}

			[maxvertexcount(30)]
			void geom(triangle v2g IN[3], inout TriangleStream<g2f> tristream)
			{
				g2f o;
 
				float3 edgeA = IN[1].vertex - IN[0].vertex;
				float3 edgeB = IN[2].vertex - IN[0].vertex;
				float3 normalFace = normalize(cross(edgeA, edgeB));
 
				float3 centerVertex = (IN[0].vertex + IN[1].vertex + IN[2].vertex) / 3;    //中心点
				float2 centerTex = (IN[0].uv + IN[1].uv + IN[2].uv) / 3;
 
				o.uv = centerTex;
 
				float3 v0 = IN[0].vertex;
				float3 v1 = IN[1].vertex;
				float3 v2 = IN[2].vertex;
				float3 v3 = IN[0].vertex + normalFace * _Length;
				float3 v4 = IN[1].vertex + normalFace * _Length;
				float3 v5 = IN[2].vertex + normalFace * _Length;
				
				ADD_TRI(v0,v3,v2, o, tristream);
				ADD_TRI(v3,v5,v2, o, tristream);
				ADD_TRI(v3,v4,v0, o, tristream);
				ADD_TRI(v4,v1,v0, o, tristream);
				ADD_TRI(v5,v2,v1, o, tristream);
				ADD_TRI(v5,v4,v1, o, tristream);
				ADD_TRI(v3,v4,v5, o, tristream);


				//追加一个顶尖面
				float3 newCenterPoint = centerVertex + normalFace * (_Length  + _AppendLength);
				ADD_TRI(v3,v4,newCenterPoint, o, tristream);
				ADD_TRI(v4,v5,newCenterPoint, o, tristream);
				ADD_TRI(v5,v3,newCenterPoint, o, tristream);
			}
 
			fixed4 frag (g2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv) * _CustomColor;
				return col;
			}

		ENDCG
		}//Pass_end
	}
}