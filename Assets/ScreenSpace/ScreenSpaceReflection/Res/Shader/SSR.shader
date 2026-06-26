Shader "MyShader/SSR"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _SkyBox("Sky Box", Cube) = "Cube"{}

        _BumpMap("法线贴图", 2D) = "bump"{}
        _Noise("噪音贴图", 2D) = "white"{}
    }
        SubShader
    {
        Tags  {"RenderType" = "Opaque"}
        LOD 100
        GrabPass {} //取得当前的屏幕图片，屏幕空间反射当然要用此图的颜色
        Pass
        {

            CGPROGRAM
            #pragma target 3.0
#pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "Lighting.cginc"


            half4 _Color;
            sampler2D _CameraDepthTexture; //深度图
            sampler2D _GrabTexture; //屏幕图片
            sampler2D _BumpMap; //法线贴图，增加水面细节
            sampler2D _Noise; //噪音纹理，让水面（法线）流动不是那么规律


            struct a2v
            {
                half4 vertex : POSITION;
                half3 normal : NORMAL;
                half4 texcoord : TEXCOORD;
                half4 tangent : TANGENT;
            };
            struct v2f
            {
                half4 pos : POSITION;
                half2 uv : TEXCOORD0;
                half3 worldNormal : TEXCOORD1;
                half3 worldPos : TEXCOORD2;
                fixed3x3 mat : TEXCOORD3; //模型空间到切线空间的过渡矩阵
            };

            v2f vert(a2v v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);

                o.uv = v.texcoord.xy;
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;


                half3 t = normalize(v.tangent.xyz);
                half3 bt = cross(v.normal, t) * v.tangent.w;
                o.mat = fixed3x3(t, bt, v.normal);

                return o;
            }
            samplerCUBE _SkyBox; //天空盒。当时码代码时忘了加它，运行的时候模型变紫，写在这里了

            //判断是否碰撞，反射点，反射方向，第几步，当前点所对应的屏幕uv 
            bool IsInsec(half3 pos, half3 dir, float factor, out half2 screenUV)
            {
                half3 p = pos + dir * factor; //当前反射到的点的世界空间的坐标
                float pD = length(p - _WorldSpaceCameraPos.xyz); //当前点离摄像机的距离

                //当前点在屏幕上的投影坐标
                half4 scrnCoord = ComputeScreenPos(UnityWorldToClipPos(half4(p, 1)));
                //除以w转化为uv坐标
                screenUV = scrnCoord.xy / scrnCoord.w;
                if (screenUV.x < 0 || screenUV.y < 0 || screenUV.x>1 || screenUV.y>1)
                {
                    //如果在画面外，返回否
                    screenUV = half2(-1, -1);
                    return false;
                }
                //当前点所对应的屏幕空间点的深度值
                float cD = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE_PROJ(_CameraDepthTexture, UNITY_PROJ_COORD(scrnCoord)));

                return pD > cD; //当点的深度大于摄像机深度，判定相交
            }

            //返回反射的颜色
            half3 Ref(half3 pos, half3 dir)
            {
                half3 reflection = texCUBE(_SkyBox, dir).rgb;    //天空盒颜色

                //二分法端点的初始值
                float x1 = 1;
                float x2 = -1;
                float x3 = 0;
                half2 uv;

                if (!IsInsec(pos, dir, 64, uv)) //在64步时没有碰撞时，返回天空盒颜色
                {
                    return reflection;
                }
                float gap = 1; //设置步长为1
                UNITY_LOOP
                for (float i = 1; i < 64; i += gap) //进行循环
                {
                    if (IsInsec(pos, dir, i, uv)) //如果碰撞，进行二分查找碰撞点
                    {
                        x1 = i - gap;
                        x2 = i;
                        x3 = 0;
                        for (int i = 0; i < 5; i++)
                        {
                            x3 = (x1 + x2) / 2;
                            if (IsInsec(pos, dir, x3, uv))
                            {
                                x2 = x3;
                            }
                            else if (uv.x < 0)
                            {
                                return reflection;
                            }
                            else
                            {
                                x1 = x3;
                            }
                        }
                    }
                }
                if (x2 - x1 > 0) //如果二分查找成功，则返回屏幕上的颜色
                {
                    reflection = tex2D(_GrabTexture, uv);
                }

                return reflection;
            }

            half4 frag(v2f i) :SV_Target
            {
                float noise = tex2D(_Noise, i.uv).r;
                half3 rgb = tex2D(_BumpMap, i.uv + half2(noise,0) * _Time.x * 0.4).rgb;
                half3 normal = rgb * 2 - 1;
                normal.xy *= 0.1;
                normal.z = sqrt(1 - dot(normal.xy,normal.xy));
                normal = UnityObjectToWorldNormal(normal);


                half3 v = normalize(_WorldSpaceCameraPos.xyz - i.worldPos);
                half3 l = normalize(_WorldSpaceLightPos0.xyz);
                float NdotV = max(0, dot(v, normal));

                half3 r = reflect(-v, normal);  //反射光线

                half3 diffuse = _Color.rgb * max(0, dot(l, normal));

                half3 color = lerp(Ref(i.worldPos, r) * 0.5, diffuse, NdotV);
                return half4(color, 1);
            }
            ENDCG
        }
    }
        FallBack "Diffuse"
}