Shader "MyShader/pointShader" 
{ 
    Properties 
    { 
        _MainTex ("Texture", 2D) = "white" {} 
		_CustomColor("CustomColor",Color) = (1,1,1,1)
    } 
    SubShader 
    { 
        Tags { "RenderType"="Opaque" } 
        LOD 100 
 
        Pass 
        { 
            CGPROGRAM 
            #pragma vertex vert 
            //-------声明几何着色器 
            #pragma geometry geom 
            #pragma fragment frag 
      			 
            #include "UnityCG.cginc" 
 
            struct a2v 
            { 
                float4 vertex : POSITION; 
                float2 uv : TEXCOORD0; 
            }; 
 
            //-------顶点向几何阶段传递数据 
            struct v2g{ 
                float4 vertex:SV_POSITION; 
                float2 uv:TEXCOORD0; 
            }; 
 
            //-------几何阶段向片元阶段传递数据 
            struct g2f 
            { 
                float2 uv : TEXCOORD0; 
                float4 vertex : SV_POSITION; 
            }; 
 
            sampler2D _MainTex; 
            float4 _MainTex_ST; 
			fixed4 _CustomColor;
             
            v2g vert (a2v v) 
            { 
                v2g o; 
                o.vertex = UnityObjectToClipPos(v.vertex); 
                o.uv = TRANSFORM_TEX(v.uv, _MainTex); 
                return o; 
            } 
 
            //-------静态制定单个调用的最大顶点个数 
            [maxvertexcount(1)] 
            void geom(point v2g input[1],inout PointStream<g2f> outStream){ 
                g2f o=(g2f)0; 
                o.vertex=input[0].vertex; 
                o.uv=input[0].uv; 
                 
                outStream.Append(o); 
            } 
             
            fixed4 frag (g2f i) : SV_Target 
            { 
                fixed4 col = tex2D(_MainTex, i.uv) * _CustomColor; 
                return col; 
            } 
            ENDCG 
        } 
    } 
} 