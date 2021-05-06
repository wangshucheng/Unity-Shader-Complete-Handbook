Shader "MyShader/SandShader"
{
    Properties
    {
        _MainTex ("MainTexture", 2D) = "white" {}
		_CustomColor("CustomColor",Color) = (1,1,1,1)
		_InitialSpeed("InitialSpeed",Float) = 10
		_GravityAcceValue("GravityAcceValue",Float) = 10
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
			#pragma geometry geom
            #pragma fragment frag
            #include "UnityCG.cginc"

			sampler2D _MainTex;
            float4 _MainTex_ST;
			fixed4 _CustomColor;
			float _InitialSpeed;  
			float _GravityAcceValue;
			float _StartTime;   

			//应用阶段--》顶点着色
            struct a2v
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

			//顶点着色--》几何着色
			struct v2g
			{
				float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
			};

			//几何着色--》片元着色
            struct g2f
            {
				float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

           //顶点着色器
            v2g vert (a2v v)
            {
                v2g o;
                o.vertex = v.vertex;
                o.uv = v.uv;
                return o;
            }

			//几何着色器
			[maxvertexcount(1)]
			void geom(triangle v2g IN[3],inout PointStream<g2f> pointStream)
			{
				g2f o;

				float3 v1 = IN[1].vertex - IN[0].vertex;
				float3 v2 = IN[2].vertex - IN[0].vertex;

				//1.求三角面的法线
				float3 tempNormal = normalize(cross(v1,v2));

				//2.获取三角面的中心点
				float3 tempPos = (IN[0].vertex + IN[1].vertex + IN[2].vertex)/3;

				//3.设定时间变量t
				float timeT = _Time.y - _StartTime;

				//4.使用加速度公式(x=vt+½at²)，将三角面的中心点沿着法线方向运动。
				tempPos += tempNormal *  (_InitialSpeed * timeT + 0.5 * _GravityAcceValue * pow(timeT,2));

				//5.对新产生的顶点做mvp矩阵变换
				o.vertex = UnityObjectToClipPos(tempPos);
				o.uv = (IN[0].uv + IN[1].uv + IN[2].uv) / 3;

				//6.加入到顶点的流中
				pointStream.Append(o);
			}

			//片元着色器
            fixed4 frag (g2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                return col * _CustomColor;
            }

            ENDCG
        }
    }
}
