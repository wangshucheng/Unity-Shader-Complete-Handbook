Shader "MyShader/jianciShader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Length("Length", Range(0, 2)) = 2
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
			half4 _CustomColor;
      
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

			[maxvertexcount(27)]
			void geom(triangle v2g IN[3], inout TriangleStream<g2f> tristream)
			{
				g2f o;
 
				float3 v1 = IN[1].vertex - IN[0].vertex;
				float3 v2 = IN[2].vertex - IN[0].vertex;
				float3 cebterNormal = normalize(cross(v1, v2));
 
				float2 centerTex = (IN[0].uv + IN[1].uv + IN[2].uv) / 3;
				o.uv = centerTex;
				
				float3 point0 = IN[0].vertex;
				float3 point1 = IN[1].vertex;
				float3 point2 = IN[2].vertex;
				float3 point3 = (IN[0].vertex + IN[1].vertex + IN[2].vertex) / 3;    //中心点

				//尖刺1构建
				float3 cebterPoint1 = (point0 + point1 + point3) / 3 * _Length ;
				ADD_TRI(point0,point1,cebterPoint1,o,tristream);
				ADD_TRI(point1,point3,cebterPoint1,o,tristream);
				ADD_TRI(point3,point0,cebterPoint1,o,tristream);
				
				//尖刺2构建
				float3 cebterPoint2 = (point1 + point2 + point3) / 3 * _Length;
				ADD_TRI(point1,point2,cebterPoint2,o,tristream);
				ADD_TRI(point2,point3,cebterPoint2,o,tristream);
				ADD_TRI(point3,point1,cebterPoint2,o,tristream);
				

				//尖刺3构建
				float3 cebterPoint3 = (point0 + point2 + point3) / 3 * _Length;
				ADD_TRI(point0,point2,cebterPoint3,o,tristream);
				ADD_TRI(point2,point3,cebterPoint3,o,tristream);
				ADD_TRI(point3,point2,cebterPoint3,o,tristream);
			}
 
			half4 frag (g2f i) : SV_Target
			{
				half4 col = tex2D(_MainTex, i.uv) * _CustomColor;
				return col;
			}

		ENDCG
		}//Pass_end
	}
}