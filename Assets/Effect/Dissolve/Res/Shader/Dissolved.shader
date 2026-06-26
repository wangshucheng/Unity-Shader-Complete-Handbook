Shader "MyShader/Effect//Dissolved"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _Noise("噪音图", 2D) = "white" {}
        _EdgeColor("边缘颜色",Color) = (1,1,1,1)
        _EdgeWidth("边缘宽度",Range(0,1)) = 0.2
        _Cut("溶解程度", Range(0,1)) = 0.5
    }
        SubShader
        {
            Pass
            {
                CGPROGRAM
                #pragma target 3.0
#pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"

                half4 _Color;
                sampler2D _MainTex;
                sampler2D _Noise;
                half4 _EdgeColor;
                float _EdgeWidth;
                float _Cut;

                struct a2v
                {
                    half4 vertex : POSITION;
                    half3 normal : NORMAL;
                    half4 texcoord : TEXCOORD0;
                };
                struct v2f
                {
                    half4 pos : SV_POSITION;
                    half2 uv : TEXCOORD0;
                    half3 worldNormal : TEXCOORD1;
                    half3 worldPos : TEXCOORD2;
                };

                v2f vert(a2v v)
                {
                    v2f o;
                    o.pos = UnityObjectToClipPos(v.vertex);
                    o.worldNormal = UnityObjectToWorldNormal(v.normal);
                    o.uv = v.texcoord.xy;
                    o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                    return o;
                }
                half4 frag(v2f i) :SV_Target
                {
                    float r = tex2D(_Noise, i.uv).r;
                    clip(r - _Cut);
                    if (r - _Cut < _EdgeWidth)
                    {
                        return _EdgeColor;
                    }
                    half3 albedo = tex2D(_MainTex, i.uv).rgb * _Color.rgb;


                    half3 ambient = albedo * UNITY_LIGHTMODEL_AMBIENT.rgb;

                    half3 l = normalize(_WorldSpaceLightPos0.xyz - _WorldSpaceLightPos0.w * i.worldPos);
                    float NdotL = max(0,dot(l, i.worldNormal));

                    half3 diffuse = albedo * NdotL;

                    return half4(ambient + diffuse, 1);
                }
                ENDCG
            }
        }
            FallBack "Diffuse"
}