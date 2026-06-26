Shader "MyShader/Effect/3D_Outline1"
{
	Properties{
		_MainTex("Texture", 2D) = "white"{}
		_Diffuse("DiffuseColor", Color) = (1,1,1,1)
		_Specular("SpecularColor",Color) = (1,1,1,1)
		_Gloss("Gloss",Range(8,256)) = 32
		_OutlineColor("OutlineColor", Color) = (1,0,0,1)
		_OutlineLength("OutlineLength", Range(0,1)) = 0.1
	}

		SubShader
		{

			//第一个pass，各顶点沿法线向外位移指定距离，只输出描边的纯颜色
			Pass
			{
				//剔除正面，只渲染背面，防止描边pass与正常渲染pass的模型交叉
				Cull Front
				//深度偏移操作，两个参数的数值越大，深度测试时该pass渲染的片元将获得比原先更大的深度值
				//即距离相机更远，更容易被正常渲染的pass覆盖，防止描边pass与正常渲染pass的模型交叉
				Offset 20,20
			//Zwrite Off

			CGPROGRAM
			#include "UnityCG.cginc"
			half4 _OutlineColor;
			float _OutlineLength;

			struct v2f
			{
				float4 pos : SV_POSITION;
			};

			v2f vert(appdata_full v)
			{
				v2f o;
				//在物体空间下，每个顶点沿法线位移，这种描边会造成近大远小的透视问题
				//v.vertex.xyz += v.normal * _OutlineLength;
				o.pos = UnityObjectToClipPos(v.vertex);
				//将法线方向转换到视空间，为接下来转换到投影空间做准备
				float3 normalView = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
				//将视空间法线xy坐标转换到投影空间，z深度不转换的原因是尽量避免垂直于视平面的顶点位移
				//防止描边pass与正常渲染pass的模型交叉
				float2 offset = TransformViewToProjection(normalView.xy);
				//最终在投影空间进行顶点沿法线位移操作
				o.pos.xy += offset * _OutlineLength;
				return o;
			}

			half4 frag(v2f i) : SV_Target
			{
				//这个Pass直接输出描边颜色
				return _OutlineColor;
			}

			#pragma target 3.0
#pragma vertex vert
			#pragma fragment frag
			ENDCG
		}

			//第二个pass利用Blinn-Phong着色模型正常渲染
			Pass
			{
				CGPROGRAM

				#include "Lighting.cginc"

				half4 _Diffuse;
				sampler2D _MainTex;
				//使用了TRANSFROM_TEX宏就需要定义XXX_ST
				float4 _MainTex_ST;
				half4 _Specular;
				float _Gloss;

				struct v2f
				{
					float4 pos : SV_POSITION;
					float3 worldNormal : TEXCOORD0;
					float2 uv : TEXCOORD1;
					float3 worldPos : TEXCOORD2;
				};

				v2f vert(appdata_base v)
				{
					v2f o;
					o.pos = UnityObjectToClipPos(v.vertex);
					o.worldPos = mul((float3x3)unity_ObjectToWorld, v.vertex);
					//通过TRANSFORM_TEX转化纹理坐标，主要处理了Offset和Tiling的改变,默认时等同于o.uv = v.texcoord.xy;
					o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
					o.worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);
					return o;
				}

				half4 frag(v2f i) : SV_Target
				{

					half3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
					half3 worldNormal = normalize(i.worldNormal);
					half3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
					half3 viewDir = normalize(_WorldSpaceCameraPos.xyz - i.worldPos);
					half3 halfDir = normalize(viewDir + worldLightDir);
					half3 specular = _Specular * pow(saturate(dot(halfDir, worldNormal)), _Gloss);
					half3 diffuse = _LightColor0.xyz * _Diffuse * saturate(dot(worldNormal, worldLightDir));
					half4 color = tex2D(_MainTex, i.uv);
					color.rgb = color.rgb * diffuse + ambient;
					return color;
				}
				#pragma vertex vert
				#pragma fragment frag	

				ENDCG
			}
		}
			FallBack "Diffuse"
}